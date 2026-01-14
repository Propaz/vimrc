" =============================================================================
"  PREAMBLE
" =============================================================================
set nocompatible
filetype on
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
set wildcharm=<Tab>	" Trigger for wildmenu

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


" =============================================================================
"  PLUGIN MANAGEMENT - VIM-PLUG
" =============================================================================
call plug#begin('~/.vim/plugged')

" Core & UI
Plug 'vim-airline/vim-airline'
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
nmap <leader>w :w<CR>
nmap <leader>a ggVG
nmap <leader>vm :e ~/.vimrc<CR>
nmap <silent> <leader><space> :noh<CR>

" --- Navigation ---
" Half-page scrolling that centers the cursor
nnoremap <silent> <PageUp> <C-U>zz
vnoremap <silent> <PageUp> <C-U>zz
inoremap <silent> <PageUp> <C-O><C-U><C-O>zz
noremap <silent> <PageDown> <C-D>zz
vnoremap <silent> <PageDown> <C-D>zz
inoremap <silent> <PageDown> <C-O><C-D><C-O>zz

" --- Buffer Navigation ---
nmap <leader>n :bn<CR>
nmap <leader>p :bp<CR>
nmap <leader>b :buffer <Tab>
nmap <leader>d :bprevious<CR>:bdelete #<CR>

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
inoremap <leader>j <Esc>:m .+1<CR>==gi
inoremap <leader>k <Esc>:m .-2<CR>==gi
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

" Insert empty line below
nmap <silent> <leader><CR> o<ESC>


" =============================================================================
"  PLUGIN CONFIGURATION
" =============================================================================

" --- netrw ---
let g:netrw_banner=0		" Hide the directory banner
let g:netrw_liststyle=3		" 0=thin; 1=long; 2=wide; 3=tree

" --- NERDTree ---
nmap <leader>e :NERDTreeToggle<CR>

" --- Undotree ---
nnoremap <F5> :UndotreeToggle<CR>

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

" Линтеры: mypy для типов, ruff для всего остального
let g:ale_linters = {'python': ['mypy', 'ruff']}

" Фиксеры: ruff делает всё (форматирование, импорты, автофикс)
let g:ale_fixers = {
\   'python': ['ruff'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\ }

" Настройки для Python
let g:ale_python_auto_pipenv = 1
let g:ale_python_mypy_auto_pipenv = 1
let g:ale_python_ruff_auto_pipenv = 1
let g:ale_python_mypy_options = '--strict'

" Настройки автодополнения
set omnifunc=ale#completion#OmniFunc
set completeopt=menu,menuone,preview,noselect,noinsert

" Более удобная навигация по ошибкам
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


" =============================================================================
"  CUSTOM FUNCTIONS
" =============================================================================

" Build or test Go files
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Helper for command line execution
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" Search for visual selection
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! gvy"

    let l:pattern = escape(@", '\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    let l:commands = {
    \   'b': 'normal! ?' . l:pattern . '\<CR>',
    \   'f': 'normal! /' . l:pattern . '\<CR>',
    \   'replace': 'call CmdLine("%s" . ''/''. l:pattern . ''/'')',
    \   'gv': 'call CmdLine("Rg " . ''/''. l:pattern . ''/'' . '' **/*.'')'
    \ }

    if has_key(l:commands, a:direction)
        execute l:commands[a:direction]
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Settings for handling large files
let g:LargeFile = 1024 * 1024 * 10 " 10 MB
function! LargeFile()
  " Применяем локальные настройки ТОЛЬКО для этого буфера.
  setlocal bufhidden=unload
  setlocal noswapfile
  setlocal syntax=off
  setlocal filetype=
  setlocal nofoldenable
  setlocal nospell
  setlocal nonumber
  setlocal norelativenumber
  setlocal nohlsearch

  " Глобально игнорируем FileType, НО только на время загрузки этого файла.
  set eventignore+=FileType

  " Создаем автокоманду, которая выполнится ОДИН РАЗ после загрузки
  " этого буфера и вернет eventignore в нормальное состояние.
  autocmd BufReadPost <buffer> ++once set eventignore-=FileType

  " Выводим сообщение.
  echohl WarningMsg
  echo "Активирован режим для больших файлов."
  echohl None
endfunction


" =============================================================================
"  AUTOCOMMANDS
" =============================================================================

" Trim trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" --- Filetype Specific Settings ---
autocmd BufNewFile,BufRead *.py setlocal expandtab autoindent tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" --- Go build mapping ---
autocmd FileType go nmap <C-b> :<C-u>call <SID>build_go_files()<CR>



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
vnoremap <silent> * :<C-u>call VisualSelection('f')<CR>
vnoremap <silent> # :<C-u>call VisualSelection('b')<CR>
" Search and replace selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>


" =============================================================================
"  CUSTOM COMMANDS
" =============================================================================
" :W to save with sudo
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
