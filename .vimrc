" ===== Pathogen.vim ========
" manage plugins
filetype off
"execute pathogen#infect()
"call pathogen#runtime_append_all_bundles()

" ===== Spacing and Tabs =====
set tabstop=4
set sw=4
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
  highlight LineNr ctermfg=DarkGray " edit line numbering color
  "set relativenumber     " new feature
  set ruler               " show line info on status bar 
  "set columns=80          " standard 80 column width 
  set synmaxcol=200       " No highlight beyond col
  "set cursorline          " highlight the active line. Ugly. 
  set laststatus=2

" ==== VIM-Airline Config ====
let g:airline_theme="sol"

"no need for vi compatibility, let's move on
set nocompatible

"center the text vertically
set scrolloff=50

"syntax highlighting
"set syntax
set vb

"if version >= 700
"  highlight ModeMsg guibg=DarkCyan
"  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
"  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
"endif

" cccccccccccccccccccccccccccc
" ccccc Custom Bindings cccccc 
" cccccccccccccccccccccccccccc 

"map hh to escape in insert mode
  inoremap jj <ESC>
  vnoremap jj <ESC>

"one less shift key to press dozens of times a day...
  nnoremap ; :

"navigate through buffers more quickly with [ prefix
  nnoremap <silent> [b :bprevious<CR>
  nnoremap <silent> ]b :bnext<CR>
  nnoremap <silent> [B :bfirst<CR>
  nnoremap <silent> ]B :blast<CR>

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

" open help in vertical split
  command -nargs=* -complete=help Help vertical belowright help <args>

" ============================
" ===== Split Bindings ======
" ============================
 " Set up resize-pane keys; similar to custom tmux mappings
  nnoremap <C-w>/ :vertical res +5<CR>
  nnoremap <C-w>\ :vertical res -5<CR>  
  nnoremap <C-w>+ :res +5
  nnoremap <C-w>- :res -5

"=============================
"==== DB Connection Strings ==
"=============================

if filereadable($HOME."/.vimrc.dbext")
    source ${HOME}/.vimrc.dbext
endif

