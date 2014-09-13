set number
set tabstop=2
set expandtab
set background=dark

"center the text vertically
set scrolloff=50

set syntax=on
set vb


set laststatus=1

if version >= 700
  highlight ModeMsg guibg=DarkCyan
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

