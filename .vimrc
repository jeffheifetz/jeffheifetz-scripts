"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pathogen =
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call pathogen#infect()
call pathogen#helptags()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

behave mswin

" feel free to choose :set background=light for a different style
set background=dark
colors distinguished

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" allow switching of buffers without saving
" with great power comes great responsibility
set hidden

set number
set title
set wrap!
set nofoldenable

syntax on
filetype on
filetype plugin on
filetype indent on


au! BufRead,BufNewFile Jakefile     setfiletype javascript

" Tabbing
autocmd FileType * set tabstop=4|set shiftwidth=4
autocmd FileType ruby set tabstop=2|set shiftwidth=2
set expandtab
set autoindent
" Trim Whitespace
autocmd BufWritePre * :%s/\s\+$//e

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Use the arrows to something usefull
" Seems cool, but would need to get used to it :)
map <S-Right> :bn<cr>
map <S-Left> :bp<cr>
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Building javascript (jslint)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set makeprg=node-hint\ %\ --config\ '$HOME/.vim/plugin/jshint/.jslintrc'\ --reporter\ '$HOME/.vim/plugin/jshint/reporter.js'
" set errorformat=%f:%l:%c:%m

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Building ruby
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType ruby compiler ruby
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $q ''<esc>i

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby set omnifunc=rubycomplete#Complete
"Ruby specific
autocmd FileType ruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby let g:rubycomplete_classes_in_global=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => RDOC preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=0 RDocPreview call RDocRenderBufferToPreview()

function! RDocRenderBufferToPreview()
let rdocoutput = "/tmp/vimrdoc/"
call system("rdoc " . bufname("%") . " --op " . rdocoutput)
call system("chromiu    chromiu chromium-browser ". rdocoutput . "index.html")
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FuzzyFinder awesomeness
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fuf_modesDisable = []
let g:fuf_abbrevMap = {
    \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
    \   '^m0:' : [ '/mnt/d/0/', '/mnt/j/0/' ],
    \ }
let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> <C-n>      :FufBuffer<CR>
nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
nnoremap <silent> <C-f>p     :FufFile<CR>
nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
nnoremap <silent> <C-f>D     :FufDir<CR>
"nnoremap <silent> <C-j>      :FufMruFile<CR>
"nnoremap <silent> <C-k>      :FufMruCmd<CR>
nnoremap <silent> <C-b>      :FufBookmark<CR>
nnoremap <silent> <C-f><C-t> :FufTag<CR>
nnoremap <silent> <C-f>t     :FufTag!<CR>
noremap  <silent> g]         :FufTagWithCursorWord!<CR>
nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
nnoremap <silent> <C-f><C-l> :FufLine<CR>
nnoremap <silent> <C-f><C-h> :FufHelp<CR>
nnoremap <silent> <C-f><C-b> :FufAddBookmark<CR>
vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>
nnoremap <silent> <C-e><C-f> :NERDTreeToggle<CR>
nnoremap <silent> <C-e><C-t> :TlistToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Session List (from Nukul)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
" }
nmap <F8> :TagbarToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unix Files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ff=unix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => XML Formatting via =
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd vimenter * if !argc() | NERDTree | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MacVim Copy/Paste
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard=unnamed
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SuperTab to Ctrl-Space
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabMappingTabLiteral = '<Tab>'
