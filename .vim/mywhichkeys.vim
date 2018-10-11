" \\\\\\\\\\
nmap <C-e> $
nmap <C-a> ^


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

"" remove map from bclose

let g:bclose_no_plugin_maps=1


map <Leader>b :Buffers<CR>
map <Leader>t :Files<CR>
map <Leader>h :History<CR>
vnoremap <Leader>cc :TComment<CR>
nnoremap <Leader>cc :TComment<CR>
"formatting current paragraph
map <Leader>F gwap
let g:which_key_map.F = 'Format paragraph'
let g:which_key_map.e = { 'name' : 'Edit as' ,
            \ 't' : [ 'set ft=tex' ,  'Tex' ],
            \ 'm' : [ 'set ft=markdown' ,  'Markdown' ],
            \ 'p' : [ 'set ft=pandoc' ,  'Pandoc' ],
            \ 'h' : [ 'set ft=html' ,  'Html' ],
            \}
let g:which_key_map.s = { 'name' : 'Source conf' }
let g:which_key_map.r = { 'name' : 'Ranger' ,
            \'e' :[ 'Ranger' , 'Edit file chosen by Ranger' ],
            \'p' : 'Paste last dir open by ranger',
            \'c' : 'Cd to last dir open by ranger',
            \}
nnoremap <leader>rp "=system('cat ~/.rangerdir')<CR>p
nnoremap <leader>rc :cd <C-r>=system('cat ~/.rangerdir')<CR><CR>

let g:which_key_localmap.l = { 'name' : 'Latex' ,
            \ 'd' : [ 'VimtexDocPackage' , 'Texdoc' ] ,
            \}
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
vnoremap <leader>nt :NR<CR>:set ft=tex<CR><C-w>=


let g:which_key_map[':'] = { 'name' : 'Command mode'}
let g:which_key_map.u = {
            \'name' : '',
            \'t' : [':UndotreeToggle',  'Undo tree'],
            \}

let g:which_key_map.T = {
            \'name' : 'Tags',
            \'u' : ['<Plug>CTagsUpdateCurrent',  'Update tags for current file'],
            \'f' :  'Fzf the tags',
            \'A' : ['<Plug>CTagsUpdateAll',  'Update ALL tags in pwd. BIG!!'],
            \'h' : ['<Plug>CTagsUpdateHighlight',  'Highlight tags'],
            \}
nnoremap <leader>Tf :Tags<CR>
vnoremap <leader>Tf y:call fzf#vim#tags("<C-r>"")<CR>
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
let g:which_key_map.D = {
            \'name' : 'Diff+',
            \'g' : ['diffget',  'Use the other buffer'],
            \'p' : ['diffput',  'Use this buffer'],
            \'q' : ['diffoff',  'Done diffing'],
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
            \'m' : ['set modifiable',  'Modifiable'],
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
            \'r' : ['so $MYVIMRC',  'Reload init.vim'],
            \'R' : 'Reload .vimrc and plugins',
            \'v' : ['Voom',  'Voom'],
            \'t' : ['TagbarToggle',  'Tagbar'],
            \}
nnoremap <leader>vR :so $MYVIMRC<CR>:PlugInstall<CR>
let g:which_key_map.w = { 'name' : 'Wiki',
            \'h' : ['Vimwiki2HTMLBrowse',  'View HTML'],
            \'b' : ['VimwikiGoBackLink',  'Back'],
            \'n' : 'Jump to next link',
            \'f' : 'Follow link',
            \'p' : 'Jump to prev link',
            \'r' : ['VimwikiRenameLink',  'Rename current file'],
            \'S' : 'Search Wiki',
            \}
nmap <Leader>wf <Plug>VimwikiFollowLink
nmap <Leader>wn <Plug>VimwikiNextLink
nmap <Leader>wp <Plug>VimwikiPrevLink
inoremap <localleader>w<CR> <Esc>:VimwikiReturn 1 5<CR>
inoremap <localleader>w<S-CR> <Esc>:VimwikiReturn 2 2<CR>
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
