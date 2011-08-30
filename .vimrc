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
  set laststatus=2               " always show status line.  1 => only show
                                 " statusline if >1 window
  "set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P
  "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
  "set statusline=%m%r%h%w\ [pos=%l,%c%V]%=%<[%p%%][buf=%n][hex=\%B][len=%L][eol=%{&ff}][fmt=%Y]\ %F
  "TODO: comment statusline.  break it up over multiple lines using by doing set
  "statusline+=stuff
  "then, it can also become modular rather than monolithic.  Also, see
  "http://stackoverflow.com/questions/164847/what-is-in-your-vimrc/1219104#1219104
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
set wildmode=list:longest,full   " comand <Tab> completion, list matches, then
                                 " longest common part, then all.
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
set updatecount=30               " every 30 characters, update the swap file
set updatetime=1000              " every second, update the swapfile
"set foldclose=all
set writebackup
" use exteneded regex plugin with '/' to search (%S for substitute)
"nnoremap / :M/
"nnoremap ,/ /
set mouse=a                      " Enable the mouse in the console
set textwidth=80                 " 80 character limit
set shell=zsh                    " :shell opens zsh

"*****************DISPLAY***********************
set nu                           " Line numbers on
set encoding=utf-8               " necessary to allow arrows
"set list
"set listchars+=eol:¶,tab:-→     " extends:»,trail:·,
                                 " extends and precedes are only used for when
                                 " wrap is disabled.  trail is just weird.
set tabpagemax=15                " only show 15 tabs
set winminheight=0               " windows can be 0 line high
set scrolljump=3                 " lines to scroll when cursor leaves screen
"set scrolloff=3                 " minimum lines to keep above and below cursor
"set foldenable                  " auto fold code
"set foldmethod=marker           " type of folding
if version >= 703
  set colorcolumn=+1             " highlights one column past textwidth to
                                 " act as a print margin
 " TODO: add persistent undo support (help undu-persistence)
endif

" Automatically highlight lines over textwidth characters
" This may need WinEnter,BufNewFile,BufRead instead of BufWinEnter and match
" instead of matchadd for old versions of vim.  Examples:
" http://vim.wikia.com/wiki/Highlight_long_lines
if &textwidth > 1
  if version >= 702
    "highlights everything over 80 characters as an error
    "autocmd BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)
    "highlights all lines with over 80 characters as an error
    "Ironically, greater than 80 characters
    autocmd BufWinEnter * let w:m1=matchadd('ErrorMsg', '\v(.*)(%>'.&textwidth.'v.+)@=', -1)
  endif
endif

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
" map lhs rhs replaces lhs with rhs.
" Each mapping command is associated with a particular mode.  Thus, some map
" commands will only remap in insert mode and some will only remap in normal
" mode.
" You can choose whether a mapping command will map recursively or not.  a
" 'noremap' is a non recursive version of 'map".
map <C-L> <C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
"map <S-H> gT
"map <S-L> gt

" Y yanks to the end of the line
map Y y$
" Q reformats the line
map Q gq
"Use gj and gk instead of j and k.  This moves the line up and down visually, so
"if the line wraps, you will not jump to a different line
"nnoremap uses normal mode; inoremap is for insert mode
"http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
nnoremap <silent> j gj
nnoremap <silent> k gk
inoremap <silent> <Down> <Esc>gja
inoremap <silent> <Up> <Esc>gka

" Going to the next element in a search will center on the line it's found in.
" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
map n nzz
map N Nzz

" If I accidentally press shift, q and w will still work
map:W :w
map:WQ :wq
map:wQ :wq
map:Wq :wq
map:Q :q

" map search and replace to \v search and \v replace.  This is 'very magic'
" mode, which is close to the Perl way of doing things.  That means that all
" characters other than a-zA-Z0-9_ will be treated as special characters and
" will need escaping to be treated literally.
noremap :%s/ :%s/\v
noremap / /\v

" space folds (in visual mode) and unfolds: http://vim.wikia.com/wiki/Folding
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
" vnoremap <Space> zf

autocmd bufenter * lcd %:p:h     " change directory the current file's

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

"TODO: add fuzzy finder

