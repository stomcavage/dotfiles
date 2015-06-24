"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set to Vim mode, not Vi mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

set history=9999     " how many lines to remember in history
set autoread         " autoload any changes to current file
set autoindent       " indent next line to match current line
set ruler            " show current position
set number           " show line numbers
set cmdheight=2      " height of command bar
set magic            " enable regex support
set showmatch        " show matching brackets
set mat=2            " tenths of second for matching bracket blink
set ffs=dos,mac,unix " default file type ordering
set expandtab        " use spaces instead of tabs
set shiftwidth=2     " how may spaces for re-formatting
set tabstop=2        " how many spaces for tabs
set ignorecase       " case-insensitive search with lowercase
set smartcase        " case-sensitive searches with uppercase
set hlsearch         " highlight search results


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256         " 256 colors
syntax enable        " enable syntax highlighting
colorscheme monokai  " specify color scheme
set background=dark  " use a dark version of color scheme
set lines=999        " create GUI windows with maximum height
set columns=999      " create GUI windows with maximum width
set guifont=Inconsolata:h14


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ \ Column:\ %c%V


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GitGutter config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_escape_grep=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_c_checkers=['splint', 'gcc']
let g:syntastic_perl_checkers=['perl']
let g:syntastic_ruby_checkers=['mri', 'rubocop', 'rubylint']

let g:syntastic_haskell_hdevtools_args='-g-Wall'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen=1
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeCascadeOpenSingleChildDir=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Clojure settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1
let vimclojure#DynamicHighlighting=1
"let vimclojure#WantNailgun=1
let vimclojure#SplitPos="bottom"
let lhs_markup="tex"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Haskell settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType haskell nnoremap <buffer>          <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands to simplify working with multiple windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Add highlighting of TODO for all file types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto-remove end-of-line whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,haskell autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

