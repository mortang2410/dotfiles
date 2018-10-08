runtime! defaults.vim

let mapleader = "\<Space>"
let maplocalleader =  ","

"symotion-prefix) Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'chrisbra/Recover.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
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
Plug 'christoomey/vim-tmux-navigator'
" Plug 'lambdalisue/vim-manpager'
" Plug 'lambdalisue/vim-pager'
Plug 'mbbill/undotree'
Plug 'gcmt/taboo.vim'


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
Plug 'xolox/vim-easytags'
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
" "setup ncm
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:ncm2#matcher="substrfuzzy"
set completeopt+=preview

"" configure ncm2 for text
function! Ncm2SourcesFunc()
	Capture echo ncm2#_s('sources')
	%s/},/},\r/g 
	match Keyword /'enable/
endfunction

"" run Ncm2Sources to see enabled completion sources
command! Ncm2Sources :silent! call Ncm2SourcesFunc() 
command! SudoWrite :w suda://% 

if !exists("au_txt")
  let au_txt = 1
  let off_src = [ 'vim' , 'bufpath' , 'rootpath' , 'cwdpath' ]
  autocmd BufEnter *.txt,*.md :call Enter_txt(off_src) 
  autocmd BufLeave *.txt.*.md :call Leave_txt(off_src) 
endif

function! Enter_txt(off_src)
	for x in a:off_src
		call ncm2#override_source(x, {'enable': 0})
	endfor
	let b:ncm2_look_enabled = 1
endfunction

function! Leave_txt(off_src)
	for x in a:off_src
		call ncm2#override_source(x, {'enable': 1})
	endfor
endfunction


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
let g:LanguageClient_serverCommands = {'python': ['pyls'], 'c':['ccls'] , 'cpp':['ccls'], 'sh': ['bash-language-server', 'start']}
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

""\\\\\\\\\\\\
""" setup fzf-vim
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
"Set fzf to mimic emacs command
map <M-x> :Commands<CR>
"" examples of fzf usage : 
"" External commands
"" call fzf#run({ 'source' : 'cat /usr/share/dict/words' })
"" Vim commands
"" call fzf#run({ 'source' : split(execute('version'),"\n") , 'options' : '--reverse' })
"" see <f-args> to pass arguments from commands to functions
function! MyFilterFunc(vim_command)
    call fzf#run({ 'source' : split(execute(a:vim_command),"\n") , 'options' : '--reverse' })
endfunction

command! -nargs=+ MyFilter call MyFilterFunc(<q-args>)

function! s:fzf_neighbouring_files()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = 'find ' .  cwd . ' -maxdepth 1 -type f'
  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction
command! FZFNeigh call s:fzf_neighbouring_files()

" credit to deathbeam
" let g:fuzzyfunc = &omnifunc
"
" function! FuzzyCompleteFunc(findstart, base)
"   let Func = function(get(g:, 'fuzzyfunc', &omnifunc))
"   let results = Func(a:findstart, a:base)
"
"   if a:findstart
"     return results
"   endif
"
"   if type(results) == type({}) && has_key(results, 'words')
"     let mylocalwords = []
"     for result in results.words
"       call add(words, result.word . ' ' . result.menu)
"     endfor
"   elseif len(results)
"     let mylocalwords = results
"   endif
"
"   if len(mylocalwords)
"     let result = fzf#run({ 'source': mylocalwords, 'down': '~40%', 'options': printf('--query "%s" +s', a:base) })
"
"     if empty(result)
"       return [ a:base ]
"     endif
"
"     return [ split(result[0])[0] ]
"   else
"     return [ a:base ]
"   endif
" endfunction
" function! FuzzyFuncTrigger()
"   setlocal completefunc=FuzzyCompleteFunc
"   setlocal completeopt=menu
"   call feedkeys("\<c-x>\<c-u>", 'n')
" endfunction
"
" imap <c-x><c-j> <c-o>:call FuzzyFuncTrigger()<cr>
"

" ////////////////
"
"
" "set up python-mode
" let g:pymode_python = 'python3'
" let g:pymode = 1
" let g:pymode_options = 1
"Set up easymotion

let g:EasyMotion_smartcase = 1
map s <Plug>(easymotion-s)
nmap S <Plug>(easymotion-s2)

" "Go through wrapped lines. Doesn't work with autocompletion.
" imap <silent> <Down> <C-o>gj
" imap <silent> <Up> <C-o>gk
" nmap <silent> <Down> gj
" nmap <silent> <Up> gk

""" Setup CTRL-P. I use fzf now :)
""" Don't map these since it's in g:lmap. 
" map <Leader>pl :CtrlPLine<CR>
" map <Leader>pf :CtrlPCurFile<CR>
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_max_depth = 1
" let g:ctrlp_extensions = ['line','buffertag','tag','dir']
" let g:ctrlp_show_hidden = 1

" "setup nerdtree 
" function! MyNerdToggle()
"     if &filetype == 'nerdtree'
"         :NERDTreeToggle
"     else
"         :NERDTreeFind
"     endif
" endfunction
" noremap <Leader>T :call MyNerdToggle()<CR>


" Diff with saved file
function! DiffWithSavedFunc()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call DiffWithSavedFunc()




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


inoremap <C-/> <C-X><C-U>

map <F7> mwgg=G`w<CR>

" set line numbers
set number

" if has('nvim')
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  	\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  	\,sm:block-blinkwait175-blinkoff150-blinkon175

" " " setting cursor colors in urxvt/xterm
"
" if &term =~ "xterm\\|rxvt"
"     " use an orange cursor in insert mode
"     let &t_SI = "\<Esc>]12;orange\x7"
"     " use a red cursor otherwise
"     let &t_EI = "\<Esc>]12;red\x7"
"     silent !echo -ne "\033]12;red\007"
"     " reset cursor when vim exits
"     autocmd VimLeave * silent !echo -ne "\033]112\007"
"     " use \003]12;gray\007 for gnome-terminal
" endif
" highlight Cursor ctermfg=white ctermbg=green

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
nmap <C-N><C-N> :set invnumber<CR>
" time to get efficient
nnoremap ; :
vnoremap ; :
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

" "here we give cnext and cprev som shortcuts
" nnoremap <expr> <silent> <F3>   (&diff ? "]c" : ":cnext\<CR>")
" nnoremap <expr> <silent> <S-F3> (&diff ? "[c" : ":cprev\<CR>")
" map <F4> :call CompileRunGcc()<CR>
" func! CompileRunGcc()
"   exec "w"
"   exec "! if [[  -f %< ]] then rm ./%<; fi"
"   exec "!gcc % -o %<" 
"   exec "! if [[  -f %< ]] then {cowsay 'successful' && ./%<} ; else cowsay 'Compile unsuccessful';fi "
" endfunc

" "setup markdown-preview
" let g:mkdp_auto_open = 0
" "
" " Q: the firefox preview window didn't close when leave the markdown file in vim
" "
" " A: if you want the plugin auto close the preview window on firefox, you have to do some config:
" "
" " 1. open firefox
" " 2. type `about:config` in the address bar and press Enter key
" " 3. search `dom.allow_scripts_to_close_windows` item and set the value to `true`
" let g:mkdp_refresh_slow = 1
" let g:mkdp_auto_close = 1
"
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
set smartindent
set preserveindent
set expandtab
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
set history=1000


"" end of file char = nothing
"nvim only stuff
if has('nvim')
	let g:vimtex_compiler_progname = 'nvr'
    set shada=!,'1000,s100,h
	set fcs=eob:\ 
    set inccommand=nosplit
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



" set up vimpager. I use vim-manpager for man pages  and vimpager for pager.
let g:vimpager = {}
let g:less     = {}
let g:vimpager.passthrough = 0
let g:less.enabled = 0

" \\\\\\\\\\\\\\\\\\\
" setup vimtex
let g:vimtex_view_method = 'zathura'
augroup my_cm_setup
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-cmds',
                \ 'priority': 8, 
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'prefix', 'key': 'word'},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-labels',
                \ 'priority': 8, 
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'substr', 'key': 'word'},
                \               {'name': 'substr', 'key': 'menu'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#labels,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'vimtex-files',
                \ 'priority': 8, 
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'abbrfuzzy', 'key': 'word'},
                \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#files,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
    autocmd Filetype tex call ncm2#register_source({
                \ 'name' : 'bibtex',
                \ 'priority': 8, 
                \ 'complete_length': -1,
                \ 'scope': ['tex'],
                \ 'matcher': {'name': 'combine',
                \             'matchers': [
                \               {'name': 'prefix', 'key': 'word'},
                \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                \               {'name': 'abbrfuzzy', 'key': 'menu'},
                \             ]},
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
augroup END


"//////////////////////////
"
" persistent undos between sessions
" then clean up stale undo files
" set undofile
if has("persistent_undo")
    set undodir="~/.undodir/"
    set undofile
endif

command! -nargs=0 CleanUpUndoFiles !find ~/.vim/undodir -type f -mtime +300 \! -name '.gitignore' -delete

""""" settings for text  & markdown file
""auto formatting. Slow with syntax checking
" set fo+=a

""setup lexical
let g:lexical#spelllang = ['en_us','en_ca','en_gb']

let g:lexical#thesaurus = ['~/.vim/thesaurus/words.txt']
augroup lexical
  autocmd!
  autocmd FileType pandoc,markdown,mkd call lexical#init({ 'spell': 0 })
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END



command! Spell :call lexical#init({ 'spell': 1 })
command! UnSpell :call lexical#init({ 'spell': 0 })

"" setup goyo with limelight
"" user functions that add on to goyo
let g:limelight_conceal_ctermfg = 241
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set linebreak
  " Limelight
  ConoLineDisable
  " ...
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  " Limelight!
  ConoLineEnable
  hi! Normal ctermbg=NONE 
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"my Zen version of Goyo (modified geometry)
command! Zen :call ZenFunc()
function! ZenFunc()
	if !exists('#goyo') 
		Goyo 40%x85%
	else 
		Goyo
	endif
endfunction

" setup voom by filetype

let g:voom_ft_modes = {'markdown': 'markdown', 
            \ 'tex': 'latex',
            \ 'html': 'html',
            \}


"\\\\\\\\\\\\\
"move by display lines instead of wrapped lines
noremap   <silent> k gk
noremap   <silent> j gj
noremap   <silent> 0 g0
noremap   <silent> ^ g^
noremap   <silent> $ g$
" noremap   <silent> <Home> g<Home>
" noremap   <silent> <End> g<End>
function! NoremapNormalCmd(key, preserve_omni, ...)
  let cmd = ''
  let icmd = ''
  for x in a:000
    let cmd .= x
    let icmd .= "<C-\\><C-O>" . x
  endfor
  execute ":nnoremap <silent> " . a:key . " " . cmd
  execute ":vnoremap <silent> " . a:key . " " . cmd
  if a:preserve_omni
    execute ":inoremap <silent> <expr> " . a:key . " pumvisible() ? \"" . a:key . "\" : \"" . icmd . "\""
  else
    execute ":inoremap <silent> " . a:key . " " . icmd
  endif
endfunction

" Cursor moves by screen lines
call NoremapNormalCmd("<Up>", 1, "gk")
call NoremapNormalCmd("<Down>", 1, "gj")
call NoremapNormalCmd("<Home>", 0, "g<Home>")
call NoremapNormalCmd("<End>", 0, "g<End>")

" PageUp/PageDown preserve relative cursor position
call NoremapNormalCmd("<PageUp>", 0, "<C-U>", "<C-U>")
call NoremapNormalCmd("<PageDown>", 0, "<C-D>", "<C-D>")
"//////////////////////// 

"Help window vertical split to the left
autocmd FileType help wincmd L

"vim and tmux
let g:tmux_navigator_no_mappings = 1
noremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>


" "vim and ranger, mysterious bug
" map <leader>re :RangerEdit<cr>
" map <leader>rv :RangerVSplit<cr>
" map <leader>rs :RangerSplit<cr>
" map <leader>rt :RangerTab<cr>
" "  insert and append filenames
" map <leader>ri :RangerInsert<cr>
" map <leader>ra :RangerAppend<cr>
" map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
" " let g:NERDTreeHijackNetrw = 0


"""" the other ranger plugin.
let g:ranger_map_keys = 0
"" remove map from bclose
map <Leader>r :Ranger<CR>


map <Leader>b :Buffers<CR>
map <Leader>t :Files<CR>
map <Leader>h :History<CR>
vnoremap <Leader>cc :TComment<CR>
nnoremap <Leader>cc :TComment<CR>
"formatting current paragraph
map <Leader>F gwap
""" use this if vimpager chokes on large files
" let g:vimpager.ansiesc = 0
"
" " \\\\\\\\\\\\\\\
" " """ setup vim-leader-guide. I use vim-which-key now :)
" call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
" nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
" vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
" " Define prefix dictionary
" let g:lmap =  {}
" " Second level dictionaries:
" let g:lmap.e = { 'name' : 'Edit' }
" let g:lmap.s = { 'name' : 'Source conf' }
" let g:lmap.r = { 'name' : 'Ranger' }
" let g:lmap.l = { 'name' : 'Latex' }
" let g:lmap._ = { 'name' : 'TComment' }
"
" let g:lmap.q = [ 'qa!' , 'Quit vim forcefully' ]
" let g:lmap.o = { 'name' : 'Open Stuff' }
" let g:lmap.o.q = ['copen', 'Open quickfix']
" let g:lmap.o.l = ['lopen', 'Open locationlist']
" let g:lmap.g = {
"             \'name' : 'Git Menu',
"             \'s' : ['Gstatus', 'Git Status'],
"             \'p' : ['Gpull',   'Git Pull'],
"             \'u' : ['Gpush',   'Git Push'],
"             \'c' : ['Gcommit', 'Git Commit'],
"             \'w' : ['Gwrite',  'Git Write'],
"             \}
"
" let g:lmap.u = {
"             \'name' : '',
"             \'t' : [':UndotreeToggle',  'Undo tree'],
"             \}
" let g:lmap.P = {
"             \'name' : 'Plugins',
"             \'i' : ['PlugInstall',  'Install'],
"             \'u' : ['PlugUpdate',  'Update'],
"             \'c' : ['PlugClean',  'Clean'],
"             \}
" let g:lmap.H = ['Helptags', 'Help' ]
" let g:lmap['?'] = {
"             \'name' : 'Info',
"             \'m' : ['Messages',  'Messages'],
"             \}
" let g:lmap.f = {
"             \'name' : 'Files',
"             \'w' : ['w',  'Write'],
"             \'s' : ['wq!',  'Save and quit forcefully'],
"             \'W' : ['w!',  'Write forcefully'],
"             \'q' : ['q',  'Quit window'],
"             \'r' : ['e!',  'Reload file'],
"             \'Q' : ['qa!',  'Quit all windows forcefully'],
"             \'cd' :['lcd %:p:h', 'Cd to current file'],
"             \}
" let g:lmap.p = {
"             \'name' : 'CtrlP & fzf',
"             \'f' : ['CtrlPCurFile',  'C-p Files in .'],
"             \'l' : ['BLines',  'Fzf Lines'],
"             \}
" nmap <Leader>vo gO
" let g:lmap.v = {
"             \'name' : 'vimrc & voom/outline',
"             \'e' : ['e ~/.vimrc',  'Edit .vimrc'],
"             \'r' : ['so $MYVIMRC',  'Reload .vimrc'],
"             \'v' : ['Voom',  'Voom'],
"             \'t' : ['TagbarToggle',  'Tagbar'],
"             \}
" let g:lmap.w = { 'name' : 'Wiki',
"             \'h' : ['Vimwiki2HTMLBrowse',  'View HTML'],
"             \}
" " let g:lmap.w = {
" "             \'name' : 'Wiki',
" "             \'s' : ['sp',  'Horizontal Split'],
" "             \'v' : ['vs',  'Vertical Split'],
" "             \'o' : ['only',  'Only'],
" "             \'c' : ['clo',  'Close'],
" "             \}
" " press <C-C> as LeaderGuide pops up to access these submode mappings
" let g:leaderGuide_submode_mappings =  { '<C-C>': 'win_close', '<C-F>': 'page_down', '<C-B>': 'page_up'}
"
"
"
"
" " ///////////////////////////

"" easytags
let g:easytags_async = 1




"" timeout insert
set timeoutlen=700 ttimeoutlen=0

" \\\\\\\\\\

let g:which_key_map =  {}
call which_key#register('<Space>', "g:which_key_map")
let g:which_key_localmap =  {}
call which_key#register(',', "g:which_key_localmap")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader>    :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader>     :<c-u>WhichKeyVisual ','<CR>
"

"" can provide docs for already existing maps
"nnoremap <silent> <leader>fd :e $MYVIMRC<CR>
"let g:which_key_map.f.d = 'open-vimrc'

" can map either commands, or key combos
" let g:which_key_map.w.v = ['<C-W>v', 'spibelow']

let g:which_key_map.F = 'Format paragraph'
let g:which_key_map.e = { 'name' : 'Edit as' ,
            \ 't' : [ 'set ft=tex' ,  'Tex' ],
            \ 'h' : [ 'set ft=html' ,  'Html' ],
            \}
let g:which_key_map.s = { 'name' : 'Source conf' }
let g:which_key_map.r = { 'name' : 'Ranger' }
let g:which_key_localmap.l = { 'name' : 'Latex' }
let g:which_key_map._ = { 'name' : 'TComment' }

let g:which_key_map.q = [ 'qa!' , 'Quit vim forcefully' ]
let g:which_key_map.o = { 'name' : 'Open Stuff' }
let g:which_key_map.o.q = ['copen', 'quickfix']
let g:which_key_map.o.l = ['lopen', 'locationlist']
let g:which_key_map.g = {
            \'name' : 'Git Menu',
            \'s' : ['Gstatus', 'Git Status'],
            \'p' : ['Gpull',   'Git Pull'],
            \'u' : ['Gpush',   'Git Push'],
            \'c' : ['Gcommit', 'Git Commit'],
            \'w' : ['Gwrite',  'Git Write'],
            \}
let g:which_key_map.c = { 'name' : '+TComment' }
""" use explicit nnoremap, as which_key can't deal with recursive 'no'. only use 
""" which_key for documentation
let g:which_key_map.n = { 
            \'name' : 'noh & narrow region',
            \'o' : 'Remove highlighting',
            \'t' : 'Edit narrow tex block',
            \'r' : 'Edit narrow block',
            \}
nnoremap <leader>no :noh<CR>
vnoremap <leader>nt :NR<CR>:set ft=tex<CR>
nnoremap <esc> :noh<return><esc>

let g:which_key_map[':'] = { 'name' : 'Command mode'}
let g:which_key_map.u = {
            \'name' : '',
            \'t' : [':UndotreeToggle',  'Undo tree'],
            \}

let g:which_key_map.T = {
            \'name' : 'Tags',
            \'u' : ['UpdateTags',  'Update tags'],
            \'h' : ['HighlightTags',  'Highlight tags'],
            \}
let g:which_key_map.D = {
            \'name' : 'Diff+',
            \'g' : ['diffget',  'Use the other buffer'],
            \'p' : ['diffput',  'Use this buffer'],
            \'q' : ['diffoff',  'Done diffing'],
            \}
let g:which_key_map.P = {
            \'name' : 'Plugins',
            \'i' : ['PlugInstall',  'Install'],
            \'u' : ['PlugUpdate',  'Update'],
            \'c' : ['PlugClean',  'Clean'],
            \}
let g:which_key_map.H = ['Helptags', 'Help' ]
let g:which_key_map['?'] = {
            \'name' : 'Info',
            \'m' : ['Messages',  'Messages'],
            \}
let g:which_key_map.f = {
            \'name' : 'Files',
            \'w' : ['w',  'Write'],
            \'D' : ['DiffSaved',  'Diff with saved'],
            \'W' : ['w!',  'Write forcefully'],
            \'t' : ['Filetypes',  'Filetypes'],
            \'q' : ['q',  'Quit window'],
            \'r' : ['e!',  'Reload file'],
            \'R' : ['FinishRecovery',  'Finish Recovery'],
            \'Q' : ['qa!',  'Quit all windows forcefully'],
            \'c' :['lcd %:p:h', 'Cd to current file'],
            \}
let g:which_key_map.p = {
            \'name' : 'Fzf',
            \'f' : ['FZFNeigh',  'Fzf Files in .'],
            \'l' : ['BLines',  'Fzf Lines'],
            \}
let g:which_key_map.U={
            \'name' : 'Ultisnips',
            \'e' : [ 'UltiSnipsEdit' , 'Edit snippets'],
            \'a' : [ 'UltiSnipsAddFiletypes' , 'Add snippets from other filetypes' ],
            \}

let g:which_key_map['6'] = [ 'e #' , 'Previous file' ]
let g:which_key_map.m = { 
            \'name' : '+marks',
            \'m' : ['Marks',  'Marks'],
            \}
let g:which_key_map.v = {
            \'name' : 'vimrc & voom/outline',
            \'e' : ['e ~/.vimrc',  'Edit .vimrc'],
            \'r' : ['so $MYVIMRC',  'Reload .vimrc'],
            \'R' : 'Reload .vimrc and plugins',
            \'v' : ['Voom',  'Voom'],
            \'t' : ['TagbarToggle',  'Tagbar'],
            \}
nnoremap <leader>vR :so $MYVIMRC<CR>:PlugInstall<CR>
let g:which_key_map.w = { 'name' : 'Wiki',
            \'h' : ['Vimwiki2HTMLBrowse',  'View HTML'],
            \'b' : ['VimwikiGoBackLink',  'Back'],
            \'n' : ['VimwikiNextLink',  'Jump to next link'],
            \'p' : ['VimwikiPrevLink',  'Jump to prev link'],
            \'r' : ['VimwikiRenameLink',  'Rename current file'],
            \'S' : 'Search Wiki',
            \}
let g:which_key_map.y = 'Win Clipboard'
" let g:which_key_map.w = {
"             \'name' : 'Wiki',
"             \'s' : ['sp',  'Horizontal Split'],
"             \'v' : ['vs',  'Vertical Split'],
"             \'o' : ['only',  'Only'],
"             \'c' : ['clo',  'Close'],
"             \}
"""emmet 
let g:which_key_emmet=  {}
call which_key#register('<C-y>', "g:which_key_emmet")
"""can't map '<C-Y>' in nnoremap so I hack it with a call function
function! WhichEmmet(vis)
    call which_key#start(a:vis,0,'<C-y>')
endfunction
nnoremap <C-y>  :call WhichEmmet(0)<CR>
vnoremap <C-y>  :call WhichEmmet(1)<CR>
" " /////////////////////////


""" vim wiki
" disable vimwiki filetype outside of wiki folder.
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'template_path': '~/vimwiki/templates/',
            \ 'template_default': 'default',
            \ 'template_ext': '.html',
            \ 'syntax' : 'markdown',
            \ 'ext' : '.md'
            \}]
nnoremap <leader>wS :VimwikiIndex<CR>:Rg<Space>
autocmd FileType vimwiki set ft=pandoc

""" annoying tex symbols
let g:tex_conceal = ""


""" clipboard by F3 for WSL/Linux
if has('unix')
   let uname = system('uname -a') 
   """ test WSL is running
   if uname=~"Microsoft"
       vnoremap <silent> <Leader>y "xy:silent call MyYankToFile()<CR> \| :silent !cat ~/.clipboard \| clip.exe <CR>
       nnoremap <silent> <Leader>y :silent call MyWinClipToFile()<CR>"=system('cat ~/.clipboard')<CR>p
   else
       nnoremap <F3> "+p
       vnoremap <F3> "+y
   endif
endif



"map paste from clipboard

function! MyYankToFile()
    let save_more = &more
    set nomore
    redir! > ~/.clipboard
    echon @x
    redir END
    echo ""
    let &more = save_more
    unlet save_more 
endfunction

" requires ClipOut
function! MyWinClipToFile()
    let save_more = &more
    set nomore
    silent !ClipOut.exe  > ~/.clipboard
    let &more = save_more
    unlet save_more 
endfunction
command! MyCom :call MyFunc<CR>



""" setup vim-pandoc

let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
" let g:pandoc#filetypes#pandoc_markdown = 1

""" verbose logging in vim
function! ToggleVerboseFunc()
    if !&verbose
        set verbosefile=~/.vim.verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=""
    endif
endfunction

command! ToggleVerbose :call ToggleVerboseFunc()
""" Debug vim:  ToggleVerbose and/or
" vim -V20 2>&1 | tee logfile 


""" setup polyglot with vimtex
let g:polyglot_disabled = ['latex']

""" text-object for / and :
onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
onoremap <silent> a/ :<C-U>normal! F/vf/<CR>
xnoremap <silent> i/ :<C-U>normal! T/vt/<CR>
xnoremap <silent> a/ :<C-U>normal! F/vf/<CR>


onoremap <silent> a: :<C-U>normal! F:vf:<CR>
xnoremap <silent> a: :<C-U>normal! F:vf:<CR>
onoremap <silent> i: :<C-U>normal! T:vt:<CR>
xnoremap <silent> i: :<C-U>normal! T:vt:<CR>

""" emmet mode
let g:user_emmet_mode='a'  
"\\\\\\\\\\\\\\\\
" SetupUltisnips 
" the tab key is fought over, so use C-j instead.
" in vimwiki, <CR> and <Tab> don't work as expected.
" c-f c-b for moving in snippet
" stupid bug <C-> if we don't set trigger
let g:UltiSnipsExpandTrigger		= "<tab>"
let g:UltiSnipsJumpForwardTrigger	= "<c-f>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-b>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:ulti_expand_or_jump_res = 0 "default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction
inoremap <NL> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":""<CR>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
"//////////////

""" view current highlighting group under cursor
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun



""" setup JamshedVesuna/vim-markdown-preview
let g:vim_markdown_preview_toggle=3
let g:vim_markdown_preview_pandoc=1
let g:vim_markdown_preview_hotkey='<C-p>'
autocmd FileType markdown,pandoc nnoremap <buffer> <C-p> :call Vim_Markdown_Preview()<CR>

let vim_markdown_preview_use_xdg_open=0

""" let gx use xdg-open
let g:netrw_browsex_viewer= "xdg-open"


" vim: set ft=vim :
