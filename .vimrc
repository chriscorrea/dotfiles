set number
set tabstop=2
set expandtab
set background=dark

syntax on
set vb

set laststatus=1
if version >= 700
  highlight ModeMsg guibg=DarkCyan
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

