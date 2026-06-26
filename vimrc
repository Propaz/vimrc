" =============================================================================
"  PREAMBLE
" =============================================================================
set nocompatible
filetype plugin indent on
syntax on


" =============================================================================
"  GENERAL BEHAVIOR
" =============================================================================
set shell=/bin/bash
set hidden              " Opening new file hides current instead of closing
set history=10000       " Command history size
set undolevels=10000    " Undo history size
set autoread            " Auto read file if changed from outside
set title               " Set terminal title
set lazyredraw          " Redraw only when needed
set ttyfast             " Faster redrawing
set encoding=utf-8      " Set default encoding to UTF-8

" Disable bells
set novisualbell
set noerrorbells


" =============================================================================
"  UI & APPEARANCE
" =============================================================================
set number              " Show line numbers
set ruler               " Show cursor position
set showmatch           " Highlight matching brackets
set laststatus=2        " Always show the status line
set cursorline          " Highlight the current line
" set colorcolumn=85    " Show a column at 85 characters
set wildmenu            " Visual autocomplete for command menu
set wildcharm=<C-z>	" Trigger for wildmenu

" Change cursor style between modes (for supported terminals)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"


" =============================================================================
"  TABS, INDENTATION & WHITESPACE
" =============================================================================
set nowrap              " Switch off line wrapping
set tabstop=4           " Tabs are 4 characters wide
set shiftwidth=4        " Indentation width is 4 characters
set softtabstop=4       " Soft tab width is 4 characters
set expandtab           " Use spaces instead of hard tabs
set smarttab            " Be smart about tabs at the start of a line
set autoindent          " Enable basic auto-indentation
set copyindent          " Preserve manual indentation
set shiftround          " Round indentation to the nearest 'shiftwidth'


" =============================================================================
"  SEARCHING
" =============================================================================
set hlsearch            " Highlight all search matches
set incsearch           " Show matches incrementally while typing
set ignorecase          " Ignore case when searching
set smartcase           " Override ignorecase if search pattern has uppercase letters

" Use ripgrep for :grep command
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m
endif

" =============================================================================
"  FILES, BACKUPS & UNDO
" =============================================================================
set backspace=indent,eol,start  " Make backspace work intuitively
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o " Files to ignore for wildmenu
"set clipboard=unnamed	" Use system clipboard

" Centralize vim's temporary files
set undofile
set swapfile
set backup
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" Create those directories if they don't exist yet
for s:dir in ['~/.vim/.undo', '~/.vim/.backup', '~/.vim/.swp']
    if !isdirectory(expand(s:dir))
        call mkdir(expand(s:dir), 'p')
    endif
endfor


" =============================================================================
"  PLUGIN MANAGEMENT - VIM-PLUG
" =============================================================================
call plug#begin('~/.vim/plugged')

" Core & UI
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git Integration
Plug 'tpope/vim-fugitive'

" Editing & Text Objects
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Linting & Completion
Plug 'dense-analysis/ale'
Plug 'ward/VimCompletesMe'
Plug 'Propaz/karate-linter'

" Language Specific
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" Set theme after plugins are loaded
colorscheme gruvbox
set background=dark


" =============================================================================
"  KEY MAPPINGS
" =============================================================================
let mapleader=","

" --- General ---
nnoremap <silent> <F2> :set paste!<CR>
nnoremap <silent> <C-q> :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>a ggVG
nnoremap <leader>vm :e $MYVIMRC<CR>
nnoremap <silent> <leader><space> :noh<CR>

" --- Clipboard Operations ---
nnoremap <leader>cf :let @+=expand('%:t')<CR>
nnoremap <leader>cfp :let @+=expand('%:p')<CR>

nnoremap <leader>e :NERDTreeToggle<CR>

" --- Navigation ---
" Half-page scrolling that centers the cursor
nnoremap <silent> <PageUp> <C-U>zz
vnoremap <silent> <PageUp> <C-U>zz
inoremap <silent> <PageUp> <C-O><C-U><C-O>zz
noremap <silent> <PageDown> <C-D>zz
vnoremap <silent> <PageDown> <C-D>zz
inoremap <silent> <PageDown> <C-O><C-D><C-O>zz

" --- Buffer Navigation ---
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bprevious<CR>:bdelete #<CR>

" --- Tab Navigation ---
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt

" --- Editing ---
" Move selected lines up/down
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

" Insert empty line below
nnoremap <silent> <leader><CR> o<ESC>


" =============================================================================
"  PLUGIN CONFIGURATION
" =============================================================================

" --- NERDTree ---
" Disable the built-in netrw to prevent conflicts.
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" --- NERDTree optimal settings for maximum responsiveness ---
let g:NERDTreeMinimalUI = 1           " Enable minimal UI for faster rendering.
let g:NERDTreeHijackNetrw = 1         " Make NERDTree the default for opening directories.
let g:NERDTreeShowHidden = 1          " Show hidden files.
let g:NERDTreeAutoClose = 1           " Close NERDTree when a file is opened from it.

" Ignore common clutter and large directories to speed up scanning.
let g:NERDTreeIgnore = [
    \ '\.pyc$', '\.swp$', '\.git$', '\.hg$', '\.svn$', '\.DS_Store$',
    \ '__pycache__', 'node_modules'
    \ ]

" --- Undotree ---
nnoremap <F5> :UndotreeToggle<CR>

" --- lightline ---
let g:lightline = { 'colorscheme': 'gruvbox' }

" --- fzf ---
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f>     :Files<CR>
nnoremap <silent> <Leader>m :Windows<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>
nnoremap <silent> <leader>ff :FZF -q <C-R>=expand("<cword>")<CR><CR>
" fzf autocomplete
imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" --- vim-fugitive (Git) ---
nnoremap <silent> <Leader>gl :Gclog -10 -- %<CR>
nnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <Leader>gd :Gvdiff<CR>

" --- ALE (Asynchronous Linting Engine) ---
let g:ale_sign_warning = '-!'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_virtualtext_cursor = 1

let g:ale_linters = {'python': ['ruff', 'mypy'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers = {'python': ['ruff'], '*': ['remove_trailing_lines', 'trim_whitespace']}

" Python-specific settings
let g:ale_python_auto_pipenv = 1
let g:ale_python_mypy_auto_pipenv = 1
let g:ale_python_ruff_auto_pipenv = 1
let g:ale_python_mypy_options = '--strict'
let g:ale_python_auto_detect_virtualenv = 1

" Completion settings
set completeopt=menu,menuone,preview,noselect,noinsert
" Use ALE's omni-completion everywhere except Go (handled by vim-go)
autocmd FileType * if &filetype !=# 'go' | setlocal omnifunc=ale#completion#OmniFunc | endif

" Easier navigation between lint errors
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" --- vim-go ---
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"
let g:go_fmt_command = "goimports"

" --- JSON formatting with jq ---
nnoremap <silent> <Leader>fj <Cmd>%!jq<CR>
nnoremap <silent> <Leader>fcj <Cmd>%!jq --compact-output<CR>
vnoremap <silent> <Leader>fj :'<,'>!jq<CR>
vnoremap <silent> <Leader>fcj :'<,'>!jq --compact-output<CR>

" -- clean ^M
nnoremap <silent> <leader>fcr :%s/\r//g<CR>:nohlsearch<CR>


" =============================================================================
"  CUSTOM FUNCTIONS
" =============================================================================

" Build or test Go files
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Yank the visual selection and use it to search (f/b) or seed a substitution.
function! s:VisualSelection(direction) range
    let l:saved_reg = @"
    normal! gvy

    let l:pattern = escape(@", '\/.*$^~[]')
    let l:pattern = substitute(l:pattern, '\n$', '', '')

    let @" = l:saved_reg
    let @/ = l:pattern

    if a:direction ==# 'replace'
        call feedkeys(':%s/' . l:pattern . '/', 'n')
    else
        let l:slash = a:direction ==# 'b' ? '?' : '/'
        call feedkeys(l:slash . l:pattern . "\<CR>", 'n')
    endif
endfunction

" Settings for handling large files
let g:LargeFile = 1024 * 1024 * 10 " 10 MB
function! LargeFile()
  " Apply these settings to THIS buffer only.
  setlocal bufhidden=unload
  setlocal noswapfile
  setlocal syntax=off
  setlocal filetype=
  setlocal nofoldenable
  setlocal nospell
  setlocal nonumber
  setlocal norelativenumber
  setlocal nohlsearch

  " Ignore FileType globally, but only while this file is loading.
  set eventignore+=FileType

  " Restore eventignore once, right after this buffer finishes loading.
  autocmd BufReadPost <buffer> ++once set eventignore-=FileType

  echohl WarningMsg
  echo "Large file mode activated."
  echohl None
endfunction


" =============================================================================
"  AUTOCOMMANDS
" =============================================================================

" Trailing whitespace is trimmed by ALE on save (see g:ale_fixers above)

" --- Filetype Specific Settings ---
autocmd BufNewFile,BufRead *.py setlocal expandtab autoindent tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" --- Go build mapping ---
autocmd FileType go nnoremap <C-b> :<C-u>call <SID>build_go_files()<CR>



" --- Session Management ---
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Auto-read file when changed from outside
au FocusGained,BufEnter * checktime

" --- Large File Handling ---
augroup LargeFile
  au!
  autocmd BufReadPre *
    \ let f=getfsize(expand("<afile>")) |
    \ if f > g:LargeFile || f == -2 |
    \   call LargeFile() |
    \ endif
augroup END


" --- Visual Mode Mappings ---
" Search for selected text
vnoremap <silent> * :<C-u>call <SID>VisualSelection('f')<CR>
vnoremap <silent> # :<C-u>call <SID>VisualSelection('b')<CR>
" Search and replace selected text
vnoremap <silent> <leader>r :call <SID>VisualSelection('replace')<CR>


" =============================================================================
"  CUSTOM COMMANDS
" =============================================================================
" :W to save with sudo
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
