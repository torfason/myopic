
" General options
"----------------------------------------
set encoding=utf-8             " UTF 8 should be the default encoding
set nocompatible               " We are pretty uninterested in vi compatibility
set number                     " Turn line numbering on
set confirm                    " If I ask for something, why not check if I meant it?
set ignorecase                 " Make searches case-insensitive
set smartcase                  " Make searches case-sensitive if search string includes upper-case
set showmatch                  " Show briefly matching bracket when closing it
set wildmenu                   " Get useful hints when hitting <TAB> in command mode
set history=1000               " Remember last n commands
set ttyfast                    " Smoother redraws
set sessionoptions+=unix,slash " Store session info in Unix format
set scrolloff=3                " Always keep a few lines above/below cursor visible
set sidescrolloff=10           " Always keep a few columns right/left of cursor visible
set sidescroll=1               " Only shift one char when scrolling to the side
set hlsearch                   " Highlight search terms
set winminheight=0             " Allow non-active windows to be squashed to zero
set winminwidth=0              " Allow non-active windows to be squashed to zero
set mouse=a                    " Enable full mouse support in the console [Overrides mswin.vim]
set autoread                   " Automatically reload files on change (may work better on nvim than vim)

" Commented out since nvim has started to complain about unsupported options
"set browsedir=buffer           " Start browsing in the directory of the file we are editing

" Wrapping options
"----------------------------------------
set nowrap                     " By default we do not want to wrap text
set linebreak                  " But if we do wrap, we want to break on word boundaries

" Options for indenting and tabs
"----------------------------------------
set autoindent                 " Copy indent from current line when starting a new line
set smartindent                " Tries to be smart about adding/removing indents
set cinwords=                  " No indenting after if/for/... (this should be set for filetype)
set smarttab                   " Tries to be a bit smarter about tabbing
set tabstop=4                  " The 'standard' tab-stop obtion, best to leave this at 8
set softtabstop=4              " Another one of the tab-stop options
set shiftwidth=4               " The final tab-stop option
set expandtab                  " Replace all tabs with spaces when entered

" Mappings (comments can not be appended in mappings)
"----------------------------------------

" Allow the use of jj instead of <Esc>
imap jj <Esc>

" Move up or down or to start/end within wrapped lines
nmap j gj
vmap j gj
nmap k gk
vmap k gk
nmap 0 g0
vmap 0 g0
nmap $ g$
vmap $ g$
