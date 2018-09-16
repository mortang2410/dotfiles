" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/emmet-vim'
Plug 'tomtom/tcomment_vim'
Plug 'benknoble/clam.vim'
Plug 'AmaiSaeta/capture.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'miyakogi/conoline.vim'
Plug 'kshenoy/vim-signature'
Plug 'lervag/vimtex'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'lambdalisue/vim-manpager'
" Plug 'lambdalisue/vim-pager'
Plug 'mbbill/undotree'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

" Plug 'JuliaEditorSupport/julia-vim'

" Plug 'zchee/deoplete-jedi'
" Plug 'szymonmaszke/vimpyter'
" Plug 'sophAi/vim-ipython_py3'
" Plug 'python-mode/python-mode', { 'branch': 'develop' }

" Plug 'ervandew/supertab'
" Plug 'maralla/completor.vim'


" Plug 'w0rp/ale'


Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" "-------------------
" if has('nvim')
" 	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   	Plug 'Shougo/deoplete.nvim'
"   	Plug 'roxma/nvim-yarp'
"   	Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'Shougo/neco-vim'
" Plug 'zchee/deoplete-zsh'
""--------------------
"" setup ncm
if !has('nvim')
	Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'

" "---------------------

" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'yami-beta/asyncomplete-omni.vim'
" Plug 'prabirshrestha/asyncomplete-buffer.vim'
"
"
"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

" "============
" "setup ncm
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:ncm2#matcher="substrfuzzy"
set completeopt+=preview
" "============
" " setting up asyncomplete
" let g:asyncomplete_remove_duplicates = 1
" let g:asyncomplete_smart_completion = 1
" let g:asyncomplete_auto_popup = 1
" set completeopt+=preview
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" imap <c-space> <Plug>(asyncomplete_force_refresh)
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ asyncomplete#force_refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" if executable('pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif
" call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
" \ 'name': 'omni',
" \ 'whitelist': ['*'],
" \ 'blacklist': ['c', 'cpp', 'html'],
" \ 'completor': function('asyncomplete#sources#omni#completor')
" \  }))
" call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
"     \ 'name': 'buffer',
"     \ 'whitelist': ['*'],
"     \ 'blacklist': ['go'],
"     \ 'completor': function('asyncomplete#sources#buffer#completor'),
"     \ }))
"
" "=====================
"
" " setup deoplete
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#option({
" 			\'ignore_case': v:true,
" 			\})
"  
" "		 \'complete_method':"omnifunc"
" let g:deoplete#enable_at_startup = 1

"set up LanguageClient
let g:LanguageClient_serverCommands = {'python': ['pyls'], 'cpp':['ccls']}
set omnifunc=LanguageClient#complete
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

" "" ALE stuff
" let g:ale_linters = {'python': ['pyls'],'cpp':['clangd']}
" let g:ale_cpp_clangtidy_executable = 'clang-tidy-3.5'
" let g:ale_cpp_clangd_executable = 'clangd-6.0'
" let g:ale_lint_on_text_changed=0
" let g:ale_lint_on_save=1
" let g:ale_completion_enabled=1
" let g:ale_set_highlights=0
" set completeopt=menu,menuone,preview,noselect,noinsert
" nnoremap <silent> K :ALEHover<CR>
" nnoremap <silent> gd :ALEGoToDefinition<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"

"--------------------------

" Omnicompletion 
 filetype plugin on
" set omnifunc=syntaxcomplete#Complete
" set omnifunc=LanguageClient#complete


" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
"Set fzf to mimic emacs command
map <M-x> :Commands<CR>


" "set up python-mode
" let g:pymode_python = 'python3'
" let g:pymode = 1
" let g:pymode_options = 1

"Set up easymotion
let g:EasyMotion_smartcase = 1
map s <Plug>(easymotion-s)
nmap S <Plug>(easymotion-s2)

"Go through wrapped lines
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

"Set CTRL-P UP
map <C-p>l :CtrlPLine<CR>
map <C-p>f :CtrlPCurFile<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_depth = 1
let g:ctrlp_extensions = ['line','buffertag','tag','dir']
let g:ctrlp_show_hidden = 1

"setup nerdtree 
function! MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction
noremap \T :call MyNerdToggle()<CR>
"line hilighting
let g:conoline_auto_enable = 1

" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" Shift+insert for gvim
if has("gui_running")
    map  <silent>  <S-Insert>  "+p
    imap <silent>  <S-Insert>  <Esc>"+pa
endif


set hidden




if &cp | set nocp | endif

map \b :Buffers<CR>
map \t :Files<CR>
map <F10> <c-L>
noremap :WW :w !sudo tee %
inoremap <C-/> <C-X><C-U>

map <F7> mwgg=G`w<CR>

" set line numbers
set number
set relativenumber

" if has('nvim')
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  	\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  	\,sm:block-blinkwait175-blinkoff150-blinkon175
" endif


" set cursorshape to Ibeam in insert
" if exists('$TMUX')
" 	let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
" 	let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
" else
" 	let &t_SI = "\e[5 q"
" 	let &t_EI = "\e[2 q"
" endif
" let &t_SI = "\<Esc>[6 q"
" let &t_SR = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"


" here we toggle line numbers
:nmap <C-N><C-N> :set invnumber<CR>
" time to get efficient
nnoremap ; :
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <silent> <leader>y :YRShow<CR> 
colorscheme molokai
"for molokai 
let g:rehash256 = 1

" make CSapprox respect terminal's normal fg, bg choice
let g:CSApprox_hook_post = ['hi Normal  ctermbg=NONE ctermfg=NONE',
                                \ 'hi NonText ctermbg=NONE ctermfg=NONE' ]

"latex suite
 filetype plugin on
 set grepprg=grep\ -nH\ $*
 filetype indent on
 let g:tex_flavor='latex'

"here we give cnext and cprev som shortcuts
nnoremap <expr> <silent> <F3>   (&diff ? "]c" : ":cnext\<CR>")
nnoremap <expr> <silent> <S-F3> (&diff ? "[c" : ":cprev\<CR>")
map <F4> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  exec "! if [[  -f %< ]] then rm ./%<; fi"
  exec "!gcc % -o %<" 
  exec "! if [[  -f %< ]] then {cowsay 'successful' && ./%<} ; else cowsay 'Compile unsuccessful';fi "
endfunc

"setup markdown-preview
let g:mkdp_auto_open = 1
let g:mkdp_refresh_slow = 1

"setup undotree
nnoremap <F4> :UndotreeToggle<CR>



"vim-latex
let g:Tex_DefaultTargetFormat ="pdf"
set winaltkeys=no

" "latex-box
" let g:vim_program="vim"
" let g:LatexBox_latexmk_options ="-pvc"

"automatic tex plugin
let g:atp_folding = 1
let g:atp_fold_environment = 1


set mouse=a
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set hidden
set cmdheight=1
syntax enable
set history=50
set hlsearch
set ignorecase 
" set smartcase
set incsearch
set nocompatible
set laststatus=2
set encoding=utf-8
set t_Co=256


set copyindent
set autoindent
set preserveindent
set noexpandtab
set softtabstop=0
set shiftwidth=4
set tabstop=4
set foldmethod=syntax
set foldlevelstart=999
let perl_fold=1
" Remember to check c.vim, perl.vim to see if the syntax files allow folding. There should be a switch. See :help c.vim

set ruler
set showcmd
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

"nvim only stuff
if has('nvim')
	let g:vimtex_compiler_progname = 'nvr'
endif


"vim-only stuff
" fix meta-keys which generate <Esc>a .. <Esc>z
"fix meta key
if !has('nvim')
	set clipboard+=autoselect
	let c='a'
	while c <= 'z'
  	  exec "set <A-".c.">=\e".c
  	  exec "imap \e".c." <A-".c.">"
  	  let c = nr2char(1+char2nr(c))
	endw
	if &term =~ '^screen'
    	" tmux knows the extended mouse mode
    	set ttymouse=xterm2
	endif
endif
"fix mouse for resizing vim splits in tmux
set mouse+=a


let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

""Force transparent background even when colorscheme doens't
hi! Normal ctermbg=NONE 

"" Vapoursynth add modules for linters
" if isdirectory('/usr/share/vsscripts/')
" 	python3 import sys; sys.path.append('/usr/share/vsscripts/')
" endif
autocmd BufNewFile,BufRead *.vpy set filetype=python


"" timeout insert
set timeoutlen=1000 ttimeoutlen=0

" set up vimpager. I use vim-manpager for man pages  and vimpager for pager.
let g:vimpager = {}
let g:less     = {}
let g:vimpager.passthrough = 0
let g:less.enabled = 0


" setup vimtex
let g:vimtex_view_method = 'zathura'

" persistent undos between sessions
" then clean up stale undo files
set undofile
set undodir=~/.vim/undodir
command! -nargs=0 CleanUpUndoFiles !find ~/.vim/undodir -type f -mtime +300 \! -name '.gitignore' -delete

" vim: set ft=vim :
