-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.motion.hop-nvim" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.python" },
  -- { import = "astrocommunity.note-taking.obsidian-nvim" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
}
