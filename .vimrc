"some content from http://spf13.com/content/my-custom-vimrc-file-vim
" ****************** INITIALIZE *******************
set nocompatible                 " must be first line
filetype plugin indent on        " Automatically detect file types.
syntax on                        " syntax highlighting

" ****************** VISUAL *******************
"color traditional               " load a colorscheme

" highlight cursor
hi CursorColumn guibg=#333333

if has('cmdline_info')
    set ruler                    " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd                  " show partial commands in status line and
                                 " selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2               " always show status line.  1 => only show statusline if >1 window
  "set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
  "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
  "set statusline=%m%r%h%w\ [pos=%l,%c%V]%=%<[%p%%][buf=%n][hex=\%B][len=%L][eol=%{&ff}][fmt=%Y]\ %F
  set statusline=%m%r%h%w\ %l,%c%V%=%<%p%%[b%n][0x%B][len=%L][%{&ff}][%Y]\ %F
endif

" GVIM- (here instead of .gvimrc)
if has('gui_running')
  set guioptions-=T              " remove the toolbar
  set lines=40                   " 40 lines of text instead of 24,
  colorscheme evening            " use the evening color scheme
  set cursorline                 " highlight current line
  " highlight bg color of current line
  hi cursorline guibg=#333333
endif

" From vim.wikia.com/wiki/Configuring_the_cursor
" Set a green cursor in insert mode and a red cursor otherwise.
" Works at least for xterm, rxvt, and gnome (Ubuntu 10.10) terminals.
"if &term =~ "xterm\\|rxvt"
"  "change to red now
"  :silent !echo -ne "\033]12;red\007"
"  let &t_SI = "\033]12;green\007"      "change to green when insert mode
"  let &t_EI = "\033]12;red\007"        "change to red when exiting insert mode
"  ""change to white when exiting to shell
"  autocmd VimLeave * :!echo -ne "\033]12;white\007"
"endif

" ****************** ENVIRONMENT *******************
set backspace=indent,eol,start   " backspace for dummys
set showmatch                    " show matching brackets/parenthesis
set wildmenu                     " show list instead of just completing
set wildmode=list:longest,full   " comand <Tab> completion, list matches, then longest common part, then all.
set shortmess+=filmnrxoOtT       " abbrev. of messages (avoids 'hit enter')
set showmode                     " display the current mode
"set spell                       " spell checking on
set incsearch                    " find as you type search
set hlsearch                     " highlight search terms
set autowrite
set whichwrap=b,s,h,l,<,>,[,]    " backspace and cursor keys wrap to
set ignorecase                   " case insensitive search
set smartcase                    " case sensitive when uc present
set backup                       " backups are nice
" a script that sets backupdir and directory, making the directorys if they
" don't already exist.
if filereadable($HOME.'/.vim/vimrc-etc/init-backup-dir.vim')
  source ~/.vim/vimrc-etc/init-backup-dir.vim
endif
"set backupdir=~/.vim-backup     " but don't go in current directory
"set directory=~/.vim-backup     " swap files don't go in current directory
                                 " ending with // makes it save the file with
                                 " the full path so that editing two files with
                                 " the same name in different directories won't
                                 " cause issues.
"set backupdir=C:\\Mev\\StandAlones\\Vim\\vim-backup "for windows
"set foldclose=all
set writebackup
" use exteneded regex plugin with '/' to search (%S for substitute)
"nnoremap / :M/
"nnoremap ,/ /

"*****************DISPLAY***********************
set nu                           " Line numbers on
set encoding=utf-8               " necessary to allow arrows
"set list
"set listchars+=eol:¶,tab:-→      " extends:»,trail:·, "extends and precedes are only used for when wrap is disabled.  trail is just weird.
set tabpagemax=15                " only show 15 tabs
set winminheight=0               " windows can be 0 line high
set scrolljump=3                 " lines to scroll when cursor leaves screen
"set scrolloff=3                 " minimum lines to keep above and below cursor
"set foldenable                  " auto fold code
"set foldmethod=marker           " type of folding

" ****************** FORMATTING *******************
"set nowrap                      " wrap long lines
set autoindent                   " indent at the same level of the previous line
set tabstop=8                    " 8 columns per tab so I notice tabs
set expandtab                    " turn tabs into spaces
set shiftwidth=2                 " > and < will (un)indepnt 2 columns
set softtabstop=2                " when I press 'tab', vim inserts 2 columns
"set matchpairs+=<:>             " match, to be used with %
set pastetoggle=<F12>            " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" ****************** GENERAL SHORTCUTS *******************
map <C-L> <C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
"map <S-H> gT
"map <S-L> gt

" Stupid shift key fixes
map:W :w
map:WQ :wq
map:wQ :wq
map:Wq :wq
map:Q :q

autocmd bufenter * lcd %:p:h     " change directory the current file's
"autocmd BufWritePost .vimrc source %

" ****************** CODING *******************
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

set completeopt+=menuone         " show preview of function prototype

" ****************** PLUGINS *******************
":map <C-F10> <Esc>:vsp<CR>:VTree<CR>

" map Control + F10 to Vtree

let g:checksyntax_auto = 1

"comment out line(s) in visual mode
"vmap  o  :call NERDComment(1, 'toggle')<CR>
"let g:NERDShutUp=1

let b:match_ignorecase = 1

