filetype off
execute pathogen#infect()

"call pathogen#runtime_append_all_bundles()

" ===== Spacing and Tabs =====
set tabstop=2
set sw=2
set expandtab
set background=dark

" ===== Code Folding =====
"  set foldmethod=indent   " Create folds at indentation 
"  set foldlevelstart=20   " Starting fold level when opening files

" ===== Aesthetic Considerations =====
  syntax on               " Syntax Highlighting
  "set t_Co=256            " Terminal supports 256 colors
  "set title               " Change the terminal title
  set number              " Show line numbering
  "set relativenumber     " new feature
  set ruler               " show line info on status bar 
  set columns=80          " standard 80 column width 
  set synmaxcol=200       " No highlight beyond col
  "set cursorline          " highlight the active line. Ugly. 

"no need for vi compatibility, let's move on
set nocompatible

"center the text vertically
set scrolloff=50

"syntax highlighting
"set syntax
set vb

set laststatus=1

if version >= 700
  highlight ModeMsg guibg=DarkCyan
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

" ============================
" ===== Custom Bindings ======
" ============================

"map hh to escape in insert mode
  inoremap hh <ESC>

"one less shift key to press...
  nnoremap ; :

"avoiding the arrows!
"note: remap these to something useful in the future
  nnoremap <up> <nop>
  nnoremap <down> <nop>
  nnoremap <left> <nop>
  nnoremap <right> <nop>
  inoremap <up> <nop>
  inoremap <down> <nop>
  inoremap <left> <nop>
  inoremap <right> <nop>

" more intuitive, improved regex handling
  nnoremap / /\v
  vnoremap / /\v

" avoid accidental help when aiming for <ESC>
  map <F1> :<CR>
  map! <F1> <Left><Right>

"=============================
"==== DB Connection Strings ==
"=============================
let g:dbext_default_profile_xxxx = 'type=SQLSRV:integratedlogin=1:host=xxxx:dbname=xxxx'

