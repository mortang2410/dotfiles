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
"Plug 'wincent/command-t', {'do':'rake make'}
Plug 'w0rp/ale'
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
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lambdalisue/vim-manpager'
Plug 'lambdalisue/vim-pager'
Plug 'mbbill/undotree'
Plug 'cohama/lexima.vim'
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  	Plug 'Shougo/deoplete.nvim'
  	Plug 'roxma/nvim-yarp'
  	Plug 'roxma/vim-hug-neovim-rpc'
endif

"
"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

" setup vimtex
let g:vimtex_view_method = 'zathura'

" setup deoplete
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
let g:deoplete#enable_at_startup = 1


"Set fzf to mimic emacs command
map <M-x> :Commands<CR>

"Set up easymotion
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s)
nmap S <Plug>(easymotion-s2)

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

" Omnicompletion 
filetype plugin on
set omnifunc=syntaxcomplete#Complete

""LanguageClienT complete. I use ALE now.
"let g:LanguageClient_serverCommands = {'python': ['pyls']}
"set completefunc=LanguageClient#complete
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

"" ALE stuff
let g:ale_linters = {'python': ['pyls']}
nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>




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

" set cursorshape to Ibeam in insert
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
	let &t_SI = "\e[5 q"
	let &t_EI = "\e[2 q"
endif
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

"for ALE syntax god
let g:ale_completion_enabled = 1


"for gundo
nnoremap <F4> :UndotreeToggle<CR>






"command-T tweaking
let g:CommandTScanDotDirectories = 1
let g:CommandTAlwaysShowDotFiles = 1
let g:CommandTMaxFiles=900000
let g:CommandTFileScanner="find"


"vim-latex
let g:Tex_DefaultTargetFormat ="pdf"
set winaltkeys=no

"latex-box
let g:vim_program="vim"
let g:LatexBox_latexmk_options ="-pvc"

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
set clipboard+=autoselect
set foldmethod=syntax
set foldlevelstart=999
let perl_fold=1
" Remember to check c.vim, perl.vim to see if the syntax files allow folding. There should be a switch. See :help c.vim

set ruler
set showcmd
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc


" fix meta-keys which generate <Esc>a .. <Esc>z
"fix meta key
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

""Force transparent background even when colorscheme doens't
hi! Normal ctermbg=NONE 

"" Vapoursynth add modules for linters
python3 import sys; sys.path.append('/usr/share/vsscripts/')
autocmd BufNewFile,BufRead *.vpy set filetype=python


"" timeout insert
set timeoutlen=1000 ttimeoutlen=0

" set up vimpager. I use vim-manpager for man pages  and vimpager for pager.
let g:vimpager = {}
let g:less     = {}
let g:vimpager.passthrough = 0
let g:less.enabled = 0

" persistent undos between sessions
" then clean up stale undo files
set undofile
set undodir=~/.vim/undodir
command! -nargs=0 CleanUpUndoFiles !find ~/.vim/undodir -type f -mtime +300 \! -name '.gitignore' -delete

" vim: set ft=vim :
