#!/usr/bin/env python3
"""
Parse a math PDF to Markdown with LlamaParse.
- API key is pulled from ~/.authinfo.gpg (or ~/.authinfo) using the line whose
  machine/host/hostname is cloud.llamaindex.ai (or api.cloud.llamaindex.ai).
"""

import argparse
import os
import shlex
import subprocess
from pathlib import Path

from llama_cloud_services import LlamaParse  # pip install llama-cloud-services

HOSTS = ("cloud.llamaindex.ai", "api.cloud.llamaindex.ai")

def _read_authinfo_text():
    gpg = Path.home() / ".authinfo.gpg"
    plain = Path.home() / ".authinfo"
    if gpg.exists():
        # Uses your gpg-agent+pinentry (no loopback), so curses prompts will work.
        try:
            out = subprocess.run(
                ["gpg", "--quiet", "--decrypt", str(gpg)],
                check=True, capture_output=True, text=True
            )
            return out.stdout
        except subprocess.CalledProcessError as e:
            raise RuntimeError(f"GPG failed to decrypt {gpg}: {e.stderr.strip()}") from e
    if plain.exists():
        return plain.read_text()
    raise FileNotFoundError("No ~/.authinfo.gpg or ~/.authinfo found")

def _kv_pairs_from_line(line: str):
    """Parse netrc/authinfo-style tokens: key val key val ... -> dict."""
    toks = shlex.split(line.strip())
    it = iter(toks)
    return {k: v for k, v in zip(it, it)}

def get_llama_api_key_from_authinfo() -> str:
    text = _read_authinfo_text()
    for raw in text.splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        kv = _kv_pairs_from_line(line)
        host = kv.get("machine") or kv.get("host") or kv.get("hostname")
        if host and any(h in host for h in HOSTS):
            for field in ("password", "secret", "apikey", "api_key", "token"):
                if field in kv:
                    return kv[field]
    raise KeyError(f"No entry for {HOSTS} with a password/secret/apikey in authinfo")

def main():
    p = argparse.ArgumentParser(description="LlamaParse PDF -> Markdown (math-friendly).")
    p.add_argument("pdf", help="Input PDF path")
    p.add_argument("-o", "--output", help="Output .md (default: <pdf>.md)")
    p.add_argument("--preset",
                   choices=["scientific", "agentic", "agentic-plus", "cost-effective"],
                   default="agentic",
                   help="Parsing style; 'agentic' is a good default for math.")
    p.add_argument("--lang", default="en", help="OCR language(s), e.g. 'en' or 'en,fr'")
    p.add_argument("--to-lang", default=None,
               help="Translate output to this language (e.g. 'en', 'fr').")
    args = p.parse_args()

    api_key = os.environ.get("LLAMA_CLOUD_API_KEY") or get_llama_api_key_from_authinfo()

    # Choose mode/model per docs
    parse_mode = "parse_page_with_agent"
    model = None
    if args.preset == "agentic-plus":
        model = "anthropic-sonnet-4.0"
    elif args.preset == "agentic":
        model = "openai-gpt-4-1-mini"
    elif args.preset == "cost-effective":
        parse_mode = "parse_page_with_llm"
    elif args.preset == "scientific":
        # “Scientific Paper” preset isn’t a single flag in Python; emulate with Agentic+helpers.
        model = "openai-gpt-4-1-mini"

    parser = LlamaParse(
        api_key=api_key,
        parse_mode=parse_mode,
        model=model,
        high_res_ocr=True,  # higher OCR fidelity for scans
        do_not_unroll_columns=True,  # keep 2-column journal order
        output_tables_as_HTML=True,  # better merged-cell tables in MD
        adaptive_long_table=True,
        outlined_table_extraction=True,
        strict_mode_image_ocr=True,
        strict_mode_reconstruction=True,
        hide_headers=True,
        hide_footers=True,
        preserve_very_small_text=True,
        language=args.lang,
        verbose=True,
        user_prompt=(
            f"Translate the document into {args.to_lang}. "
            "Translate ONLY prose. Do NOT alter math content: "
            "anything between $...$ or $$...$$, environments like "
            "\\begin{equation}...\\end{equation}, variable names, "
            "symbols, and equation numbers must remain unchanged. "
            "Keep Markdown structure and section headings.")
            if args.to_lang else None,
        system_prompt_append=(
            "Keep output in Markdown. Preserve LaTeX math verbatim; "
            "do not paraphrase expressions; keep inline math as $...$ "
            "and display math as $$...$$."
        ),
    )

    result = parser.parse(args.pdf)
    md_docs = result.get_markdown_documents(split_by_page=False)
    md = "\n".join(doc.text for doc in md_docs)
    out_path = args.output or f"{os.path.splitext(args.pdf)[0]}.md"
    Path(out_path).write_text(md)
    print(f"Wrote {out_path}")

if __name__ == "__main__":
    main()
