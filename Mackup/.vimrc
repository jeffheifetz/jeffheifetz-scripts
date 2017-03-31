set nocompatible
filetype off
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VUNDLE =
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'

Plugin 'https://github.com/derekwyatt/vim-scala.git'
Plugin 'https://github.com/Lokaltog/vim-distinguished.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/pangloss/vim-javascript.git'
Plugin 'git://github.com/vim-ruby/vim-ruby.git'
Plugin 'https://github.com/ervandew/supertab.git'
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
Plugin 'git://github.com/tpope/vim-rails.git'
Plugin 'git://github.com/tpope/vim-bundler.git'
Plugin 'git://github.com/tpope/vim-fugitive.git'
Plugin 'https://github.com/fholgado/minibufexpl.vim.git'
Plugin 'https://github.com/bling/vim-airline.git'
Plugin 'https://github.com/nanotech/jellybeans.vim.git'
Plugin 'https://github.com/mklabs/grunt.vim.git'
Plugin 'https://github.com/marijnh/tern_for_vim.git'
Plugin 'https://github.com/tpope/vim-surround.git'
Plugin 'git@github.com:ntpeters/vim-better-whitespace.git'
Plugin 'https://github.com/trusktr/seti.vim'
Plugin 'git@github.com:suan/vim-instant-markdown.git'
Plugin 'git@github.com:alvan/vim-closetag.git'
Plugin 'git@github.com:moll/vim-node.git'
Plugin 'git@github.com:tpope/vim-haml.git'
Plugin 'git@github.com:groenewege/vim-less.git'
Plugin 'git@github.com:hail2u/vim-css3-syntax.git'
Plugin 'git@github.com:scrooloose/syntastic.git'
Plugin 'git@github.com:keith/rspec.vim.git'
Plugin 'git@github.com:petRUShka/vim-opencl.git'
Plugin 'git@github.com:tpope/vim-markdown.git'
Plugin 'git@github.com:vim-scripts/DoxygenToolkit.vim.git'
Plugin 'https://github.com/udalov/kotlin-vim'
Plugin 'https://github.com/leafgarland/typescript-vim.git'

"
" " All of your Plugins must be added before the following line
 call vundle#end()            " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

behave mswin

" feel free to choose :set background=light for a different style
set background=dark
colors jellybeans

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git anyway...
set nobackup
set nowb
"Set undo files to their own directory
set undodir=~/tmp
"Should move the swap files
set directory=~/tmp

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
autocmd FileType javascript set tabstop=2|set shiftwidth=2
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
vnoremap $e <esc>`>a"<esc>`<i"<esc>

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
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'
"let g:SuperTabMappingTabLiteral = '<Tab>'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => XML Auto Close Tags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rubocop
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_ruby_rubocop_exec = '/Users/jeffheifetz/Coding/jeffheifetz-scripts/rubocop.sh'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Standard JS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_javascript_checkers = ['standard']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tslint
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_typescript_checkers = ['tslint']

