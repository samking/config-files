" some content from http://spf13.com/content/my-custom-vimrc-file-vim
" ****************** INITIALIZE *******************
set nocompatible                 " must be first line

"*******************************************************************************
" VUNDLE (Vim Bundle) Stuff
" See https://github.com/gmarik/Vundle.vim#about
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
"*******************************************************************************
filetype off                     " required for Vundle initialization

" Only use Vundle if it's installed.
if filereadable($HOME.'/.vim/bundle/Vundle.vim/autoload/vundle.vim')
  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  " Plugins to investigate:
  " * nerdtree
  " * vim-surround
  " * Syntastic and other syntax plugins (eg, vim-flake8, jshint)

  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  " YCM (You Complete Me) does tab completion.
  " See https://github.com/Valloric/YouCompleteMe
  " YCM requires python3 support, and the default Mac vim doesn't have python3
  " support.
  if has('python3')
    Plugin 'Valloric/YouCompleteMe'
  endif

  " Solarized color scheme
  " http://ethanschoonover.com/solarized
  Plugin 'altercation/vim-colors-solarized'

  " CtrlP does file search.  An alternative is Command-T.
  " https://github.com/kien/ctrlp.vim
  Plugin 'ctrlpvim/ctrlp.vim'

  " CtrlP search is bad in large codebases, so use a custom matcher for it.
  " However, this doesn't seem to work anymore.
  " Plugin 'JazzCore/ctrlp-cmatcher'

  " LESS (dynamic css) syntax highlighting.
  Plugin 'groenewege/vim-less'

  " Dart syntax highlighting, indentation, etc.
  " Plugin 'dart-lang/dart-vim-plugin'

  " Scala syntax highlighting
  " Plugin 'derekwyatt/vim-scala'

  " JS formatter
  Plugin 'prettier/vim-prettier'
  let g:prettier#autoformat = 0
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

  " JS syntax highlighting with stuff like JSX
  Plugin 'yuezk/vim-js'
  " Plugin 'maxmellon/vim-jsx-pretty'
  " Plugin 'ianks/vim-tsx'
  Plugin 'leafgarland/typescript-vim'
  Plugin 'peitalin/vim-jsx-typescript'

  " Syntax highlighting for all languages
  " Plugin sheerun/vim-polyglot

  call vundle#end()

  " Search all the files rather than limiting it.
  let g:ctrlp_max_files = 0
  " CtrlP should open dotfiles.
  let g:ctrlp_show_hidden = 1
  " Ignore files in .gitignore
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

  " CtrlP should open new files in a new tab rather than the current window.
  let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<c-t>'],
      \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
      \ }

  " After YCM shows a preview, close it automatically.
  let g:ycm_autoclose_preview_window_after_completion = 1
  " Allow showing unlimited diagnostic hints
  let g:ycm_max_diagnostics_to_display = 0
  map <C-f> :YcmCompleter FixIt<CR>
endif

filetype plugin indent on        " Automatically detect file types.
syntax on                        " syntax highlighting

" Read the whole file to do syntax highlighting.  This will be slower, but it
" will prevent the syntax highlighting from being randomly wrong.
autocmd BufEnter * :syntax sync fromstart

" ****************** VISUAL *******************
" Solarized color scheme with dark background
set t_Co=16
set background=dark
" The silent invocation means that if Solarized isn't detected, Vim won't error
" out on startup.
:silent! colorscheme solarized

" Highlight cursor
hi CursorColumn guibg=#333333

if has('cmdline_info')
  set ruler                      " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                    " show partial commands in status line and
                                 " selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2               " always show status line.  1 => only show
                                 " statusline if >1 window
  " set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P
  " set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
  " set statusline=%m%r%h%w\ [pos=%l,%c%V]%=%<[%p%%][buf=%n][hex=\%B][len=%L][eol=%{&ff}][fmt=%Y]\ %F
  " TODO: comment statusline.  break it up over multiple lines using by doing
  " set statusline+=stuff
  " then, it can also become modular rather than monolithic.  Also, see
  " http://stackoverflow.com/questions/164847/what-is-in-your-vimrc/1219104#1219104
  set statusline=%m%r%h%w\ %l,%c%V%=%<%p%%[b%n][0x%B][len=%L][%{&ff}][%Y]\ %F
endif

" GVIM- (here instead of .gvimrc)
if has('gui_running')
  set guioptions-=T              " remove the toolbar
  set lines=40                   " 40 lines of text instead of 24,
  set cursorline                 " highlight current line
  " highlight bg color of current line
  hi cursorline guibg=#333333
endif

" From vim.wikia.com/wiki/Configuring_the_cursor
" Set a green cursor in insert mode and a red cursor otherwise.
" Works at least for xterm, rxvt, and gnome (Ubuntu 10.10) terminals.
" TODO: Make this work.  Right now, I haven't figured out how to do all of the
" following:
"   - make it green when in insert mode
"   - make it red when not in insert mode
"   - start out colorized correctly
"   - turn it back to the color that it started at when I exit vim
" if &term =~ "xterm\\|rxvt"
"   "change to red now
"   :silent !echo -ne "\033]12;red\007"
"   let &t_SI = "\033]12;green\007"      "change to green when insert mode
"   let &t_EI = "\033]12;red\007"        "change to red when exiting insert mode
"   ""change to white when exiting to shell
"   autocmd VimLeave * :!echo -ne "\033]12;white\007"
" endif

" ****************** ENVIRONMENT *******************
set backspace=indent,eol,start   " backspace for dummys
set showmatch                    " show matching brackets/parenthesis
set wildmenu                     " show list instead of just completing
set wildmode=list:longest,full   " comand <Tab> completion, list matches, then
                                 " longest common part, then all.
set shortmess+=filmnrxoOtT       " abbrev. of messages (avoids 'hit enter')
set showmode                     " display the current mode
" set spell                      " spell checking on
set incsearch                    " find as you type search
set hlsearch                     " highlight search terms
set autowrite                    " automatically save before some commands
set whichwrap=b,s,h,l,<,>,[,]    " backspace and cursor keys wrap to
set ignorecase                   " case insensitive search
set smartcase                    " case sensitive when uppercase present
set backup                       " backups are nice
if version >= 703
  set undofile                   " save undo history to a file so that you can
endif                            " still undo even after closing a file
" we have a script to set backupdir, directory, and undodir, making the
" directories if they don't already exist.  Setting these options ensures that
" the backup, swap, and undo files won't clutter the working directory.
if filereadable($HOME.'/.vim/vimrc-etc/init-file-dirs.vim')
  source ~/.vim/vimrc-etc/init-file-dirs.vim
endif
set updatecount=30               " every 30 characters, update the swap file
set updatetime=1000              " every second, update the swapfile
" set foldclose=all
set writebackup                  " backup before overwriting a file
" use exteneded regex plugin with '/' to search (%S for substitute)
" nnoremap / :M/
" nnoremap ,/ /
set mouse=a                      " Enable the mouse in the console
set textwidth=80                 " 80 character limit
" CUSTOMIZE(shell)
if executable("zsh")
  set shell=zsh                  " :shell opens zsh
endif


" Vim jumps to the last position when opening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"*****************DISPLAY***********************
set nu                           " Line numbers on
set encoding=utf-8               " necessary to allow arrows
" set list
" set listchars+=eol:¶,tab:-→    " extends:»,trail:·,
                                 " extends and precedes are only used for when
                                 " wrap is disabled.  trail is just weird.
set tabpagemax=15                " only show 15 tabs
set winminheight=0               " windows can be 0 line high
set scrolljump=3                 " lines to scroll when cursor leaves screen
" set scrolloff=3                " minimum lines to keep above and below cursor
set nofoldenable                 " auto fold code
" set foldmethod=marker          " type of folding
if version >= 703
  set colorcolumn=+1             " highlights one column past textwidth to
                                 " act as a print margin
endif

" Automatically highlight lines over textwidth characters
" This may need WinEnter,BufNewFile,BufRead instead of BufWinEnter and match
" instead of matchadd for old versions of vim.  Examples:
" http://vim.wikia.com/wiki/Highlight_long_lines
if &textwidth > 1
  if version >= 702
    " highlights everything over 80 characters as an error
    " autocmd BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)
    " highlights all lines with over 80 characters as an error
    " Ironically, greater than 80 characters
    " autocmd BufWinEnter * let w:m1=matchadd('ErrorMsg', '\v(.*)(%>'.&textwidth.'v.+)@=', -1)
  endif
endif

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/

" ****************** FORMATTING *******************
" set nowrap                     " wrap long lines
"set autoindent                  " indent at the same level of the previous line
"set smartindent                 " do more indentation after indenty things
                                 " NOTE: can interfere with filetype indentation
set tabstop=2                    " 2 columns per tab
set expandtab                    " turn tabs into spaces
set shiftwidth=2                 " > and < will (un)indent 2 columns
set softtabstop=2                " when I press 'tab', vim inserts 4 columns
" set matchpairs+=<:>            " match, to be used with %
set pastetoggle=<F12>            " pastetoggle (sane indentation on pastes)
" set comments=sl:/*,mb:*,elx:*/ " auto format comment blocks

" If this is 1, python is two spaces; if this is 0, python is 4 spaces.
" The actual setting of tabstop, etc, happens in vim/after/ftplugin/python.vim
" To configure this on a per-computer basis, you can source this common file
" and, after sourcing it, overwrite this variable.
let g:python_use_two_spaces = 1

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
" map <S-H> gT
" map <S-L> gt

" Y yanks to the end of the line
map Y y$
" Q reformats the line
map Q gq
" Use gj and gk instead of j and k.  This moves the line up and down visually,
" so if the line wraps, you will not jump to a different line
" nnoremap uses normal mode; inoremap is for insert mode
" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
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
" CUSTOMIZE(regex-search-replace-style)
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
" map Control + F10 to Vtree
" :map <C-F10> <Esc>:vsp<CR>:VTree<CR>

let g:checksyntax_auto = 1

" comment out line(s) in visual mode
" vmap  o  :call NERDComment(1, 'toggle')<CR>
" let g:NERDShutUp=1

let b:match_ignorecase = 1

" TODO: add fuzzy finder
" TODO: when I exit insert mode and have caps lock on, something is probably
" wrong.  Either turn caps lock off or alert me of the fact that caps lock is
" still on.
