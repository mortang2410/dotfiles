
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'chrisbra/Recover.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/emmet-vim'
Plug 'mattn/webapi-vim'
Plug 'tomtom/tcomment_vim'
Plug 'benknoble/clam.vim'
Plug 'AmaiSaeta/capture.vim'
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'miyakogi/conoline.vim'
Plug 'kshenoy/vim-signature'
Plug 'lervag/vimtex'
Plug 'brennier/quicktex'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'lambdalisue/vim-manpager'
" Plug 'lambdalisue/vim-pager'
Plug 'mbbill/undotree'
""" taboo doesn't work with neovim.That sucks.
Plug 'gcmt/taboo.vim'
Plug 'sunaku/vim-dasht'

Plug 'vim-voom/VOoM'
" Plug 'iamcco/mathjax-support-for-mkdp'
" Plug 'iamcco/markdown-preview.vim'

Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-lexical'
Plug 'junegunn/limelight.vim'
Plug 'lambdalisue/suda.vim'
""" Strange bug
"Plug 'rafaqz/ranger.vim'

Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'majutsushi/tagbar'
""" exuberant ctags and easytags are dead. Use gutentags and universal ctags now.
" Plug 'xolox/vim-easytags'
""" Gutentags doesn't work at all
"Plug 'ludovicchabant/vim-gutentags'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/lh-tags'
Plug 'LucHermitte/local_vimrc'
Plug 'xolox/vim-misc'
" Track the engine.
Plug 'SirVer/ultisnips'
Plug 'mortang2410/vim-markdown-preview'
Plug 'chrisbra/NrrwRgn'
Plug 'andymass/vim-matchup'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Plug 'hecal3/vim-leader-guide'
Plug 'liuchengxu/vim-which-key'

" Plug 'godlygeek/tabular'
" Plug 'gabrielelana/vim-markdown' 

" Plug 'JuliaEditorSupport/julia-vim'

" Plug 'zchee/deoplete-jedi'
" Plug 'szymonmaszke/vimpyter'
" Plug 'sophAi/vim-ipython_py3'
" Plug 'python-mode/python-mode', { 'branch': 'develop' }

" Plug 'ervandew/supertab'
" Plug 'maralla/completor.vim'


" Plug 'w0rp/ale'

" if !has('nvim')
	Plug 'roxma/vim-hug-neovim-rpc'
" endif

Plug 'roxma/nvim-yarp'

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
Plug 'ncm2/ncm2'

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-ultisnips'
Plug 'filipekiss/ncm2-look.vim'

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
