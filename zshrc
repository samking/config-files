################################################################################
# There are many resources online to help you make your shell how you want it.
# http://grml.org/zsh/zsh-lovers.html has a good compilation of many resources,
# including many of the ones cited below. man zsh has a very complete and well
# organized set of man pages.  man zshroadmap has a brief intro.  A user's guide
# to ZSH is available at zsh.sourceforge.net/Guide.
# http://zsh.sourceforge.net/Doc/ has an online version of the man pages.
# zshwiki.org is also a good resource.
#
# The order of login shells is:
#  * zshenv
#  * zprofile (login shells)
#  * zshrc (interactive shells)
#  * zlogin (login shells)
# Note that /etc/zshenv is read before ~/.zshenv, and the /etc versions of other
# files are similarly read before their dot files.
#
# This file was created by Sam King <samking@cs.stanford.edu>.  Feel free to
# modify, distribute, and enjoy it.  Also let me know if you discover any other
# cool tricks -- ZSH is too huge for me to know everything about it.
# If I got anything from your zshrc online and forgot to credit you, please let
# me know!
################################################################################

################################################################################
# ZSTYLE OPTIONS
# These were generated by compinstall.  They can be regenerated using
# compinstall, but that would destroy everything inside the "The following
# lines..." comment.
# They mostly involve expansion and completion.
# To see how to write your own completion functions (if they aren't built in),
# check out http://www.linux-mag.com/id/1106/
# Also, see man zshcompsys for more on compinit and completion generally
################################################################################

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:]}={[:upper:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
# CUSTOMIZE(this_file)
zstyle :compinstall filename '/home/samking/.zshrc'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion

# hosts is an array (something inside () is an array in zsh) of all of the
# servers I want to be able to use tab completion to complete.
# You can also use accounts to set the names of accounts to autocomplete,
# but assocating an account with a remote host allows you to only use certain
# accounts on certain hosts (ie, if I'm samking@myth.stanford.edu and
# samk@shell.uoregon.edu).
# There is no need to explicitly include the login name if you only want zsh to
# autocomplete the remote host.  For instance, if my local login is samking,
# then it is unnecessary to ssh samking@myth.stanford.edu, and I could instead
# set my hosts to
# hosts=(myth.stanford.edu corn.stanford.edu xenon.stanford.edu)
# CUSTOMIZE(hosts)
hosts=(samking@pup.stanford.edu samking@myth.stanford.edu \
       samking@corn.stanford.edu samking@xenon.stanford.edu \
       samking@codethechange.org)
#accounts=(samking)
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts
#zstyle '*' accounts $accounts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# don't load every tab-completion module at startup.  instead, mark them all
# as autoloaded so that when you need them, they'll get loaded.
autoload -Uz compinit
# allow tab completion for command line options
compinit
# End of lines added by compinstall

################################################################################
# ZSH OPTIONS -- see man zshoptions for full descriptions
#  * setopt sets an option; unsetopt unsets an option
#  * Even for unsetopt, my comments refer to the option itself
#  * setting many of these options are unnecessary since they are set/unset by
#    default.  They are here for clarity.
#  * underscores are optional and ignored in zsh options.  There are also
#    one-letter names for some options
#  * prepending an option with "no" is the same as unsetting it
#  * these are the options for interactive shells.  Any options for both
#    interactive and noninteractive shells should go in zshenv
################################################################################

# Changing Directories
unsetopt auto_cd         # if I type a directory without 'cd', zsh automatically
                         # cds into it
setopt auto_pushd        # when I cd, push the old directory onto the dir stack
setopt pushd_ignore_dups # don't push duplicate copies of a directory to
                         # the directory stack

# Completion
setopt auto_list         # when tab completion is ambiguous, list choices
setopt auto_menu         # when tab completion is ambiguous, use menu completion
                         # (fill in the next option when you press tab)
setopt list_beep         # when tab completion is ambiguous, beep
unsetopt menu_complete   # when tab completion is ambiguous, zsh automatically
                         # fills in the first option
unsetopt list_ambiguous  # when there is an unambiguous prefix, insert that
                         # before inserting ambiguous stuff from the menu.
                         # menu_complete takes precedence over this.

# Expansion and Globbing
setopt glob              # expand stuff to generate filenames.
setopt extended_glob     # treat #, ~, and ^ as globbing patterns
setopt nomatch           # zsh gets mad when I glob patterns that don't exist

# History
setopt append_history    # append to the history file
setopt hist_ignore_dups  # don't add immediately repeated commands to history
setopt extended_history  # add timestamps to history.  For a rough idea of the
                         # extra disk space this uses, you'll use up an extra
                         # 15kB for running 1000 commands.  Your call.

# Init

# Input / Output
setopt aliases           # use aliases defined below
setopt correct           # correct my bad spelling of commands
setopt correct_all       # correct my bad spelling of all argument son a line
# CUSTOMIZE(keyboard_layout)
setopt dvorak            # zsh knows that I use dvorak when correcting my typos
setopt print_exit_value  # prints the exit value of commands when it's not 0
                         # (success); useful when writing shell scripts

# Job Control
setopt bg_nice           # nice background jobs (run them with lower priority)
setopt check_jobs        # yell at me if I try to exit zsh with jobs running
unsetopt notify          # notify me of background job status immediately

# Prompting

# Scripts and Functions
setopt octal_zeroes      # output octal numbers starting with a 0 instead of 8#
setopt c_bases           # output hex numbers with 0x rather than 16#
setopt multios           # allows redirection to multiple i/o streams; ie,
                         # echo "foo" > file1 > file2 | cat

# Shell Emulation

# Shell State

# Zle - ZSH Line Editor (the thing that takes in your text and runs the shell)
setopt beep              # zsh will beep when it's mad at me

################################################################################
# ZSH PARAMS + environment vars -- see man zshparam for full descriptions
#  * if you're interested in zsh scripting, man zshparam
#    tells you how parameters and arrays work in zsh scripts
#  * this only contains the params and environment variables that should NOT be
#    used by noninteractive shells.  Environmental variables that are global
#    go in zshenv
#  * CAPITAL means that the parameter will store one value; lowercase means that
#    the parameter is an array
#  * Many of the below parameters are commented out because the defaults are
#    good and we don't want to mess with them.
################################################################################

# Directory Stack
DIRSTACKSIZE=40            # max size of the directory stack. Good for
                           # truncating dirstack when it might grow very large
                           # (ie, when auto_pushd is on)

# History File
HISTFILE=~/.zsh-histfile   # Save shell history into .zsh-histfile so we don't 
                           # lose history (up arrow) when closing the shell
HISTSIZE=10000             # the number of lines to read from history file at
                           # startup.  The only reason to have this larger than
                           # SAVEHIST is as a buffer for saving duplicated
                           # history events
SAVEHIST=10000             # the number of lines to save to history at logout

# Completion
fignore=(.o .c~ .old .pro) # ignores these file types when doing file completion
                           # The same as the zstyle.

# Shell Prompt
# * PROMPT is PS1, the primary prompt string, which is printed before the
#   command is read.
# * PS2 is printed when the shell needs more info.  Ie, if I type
#   echo $(( 1 + 1 <enter>
#   then the shell needs me to close my parentheses.  By default, it will say
#   which shell constructs or quotation marks need to be closed.
# * PS3 is for select loops.
# * PS4 is for execution trace.
# * See http://zsh.sourceforge.net/Doc/Release/zsh_12.html#SEC40 for details on
#   prompt expansion.
PROMPT='%B%n@%m%b[%*]%U%~%u%# ' # <b>name@server</b>[time]<u>path</u>$
                                # (ends with # in su mode).
# PROMPT2=
# PROMPT3=
# PROMPT4=

# Display
# COLUMNS=80                     # Number of columns for printing lists and line
                                 # editor
# LINES=40                       # like COLUMNS
# LISTMAX=0                      # The number of matches to display without
                                 # prompting.  0 means it only asks if it would
                                 # go offscreen.

# TODO: Make ls use the same color scheme as zsh.
# * For a description of how the LS_COLORS environment variable works, check out
#   http://hintsforums.macworld.com/archive/index.php/t-46719.html
# * To see the ZSH colors, check out the Colored completion listings section of
#   man zshmodules
# LS_COLORS=

# Help
# not used internally; just sets MANPATH
# manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
# export MANPATH                         # path to look for man pages.
# export HELPDIR=/usr/local/lib/zsh/help # directory for run-help function to
                                         # find docs

# Locale
# * Locale sets what your output should look like for pretty much everything.
#   For instance, do you use commas or dots for numbers?  do you use dollars or
#   euros?  Do you use only ascii or can you use UTF-8?  English or Spanish?
# * The OS probably sets this to the correct value by default, so don't mess
#   with this unless you are getting weird output.
# * If you're using putty, you'll also want to make sure that putty's
#   window->translation is set to UTF-8.
# * LC_ALL sets the locale for everything.
# * LANG sets the locale for anything not set by an LC_something field
# * There are specific LC_ fields if you have a different locale for currency
#   than for time, for instance.  Check out man zshparam for the full list.
# export LC_ALL=en_US.UTF-8            # use US English encoded in UTF-8 as the
                                       # default character encoding locale.

# Mail
# mailpath=(/var/spool/mail/$USERNAME) # array of files to check for mail.
# MAILCHECK=60                         # Check for new mail every minute

# Paths
# cdpath=(.. ~ ~/src ~/zsh)            # Search path for the cd command
# path=()                              # array to search for commands (binaries
                                       # to run). Can use PATH instead.
# PATH=$PATH:~/bin                     # adds ~/bin to the end of path.  Note
                                       # the use of the colon as a delimiter.

# Watch for Friends
# LOGCHECK=300                         # check each 5min for friend login/logout
# WATCHFMT='%n %a %l from %m at %t.'   # format of login/logout reports.  See
                                       # man zshparam for what this means.
# watch=(notme)                        # watch for everybody but me
# watch=( $(<~/.friends) )             # watch for people in .friends file

################################################################################
# ALIASES
################################################################################
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
# alias j=jobs
# alias pu=pushd
# alias po=popd
# alias d='dirs -v'
# alias h=history
alias grep='grep -P'          # use Perl style regular expressions
alias chmud=chmod             # chmud is a typo for chmod
# TODO: make color work on macs / BSD too
# CUSTOMIZE(os)
alias ls='ls --color=auto'    # make ls pretty
alias lsal='ls -al'
alias lsl='ls -l'             # detail-list view
alias dir=lsl
alias lsa='ls -a'             # list all
alias lsd='ls -d *(-/DN)'     # list directories
alias lsh='ls -ld .*'         # list hidden
alias :q='exit'               # quit out of the shell like from vim
alias :Q='exit'
alias gdba='gdb --args'       # call GDB with args automatically set
alias asdf='setxkbmap -model pc104 -layout us -variant dvorak'  # asdf->dvorak
alias aoeu='setxkbmap -model pc104 -layout us'                  # aoeu->qwerty
alias diff='diff -bBr'        # ignore whitespace.  ignore blank lines.
                              # recursively compare directories
alias hglu='hg log -r 0:'     # hg log up. upside down.  That way, even with
                              # many revisions, the most recent one is visible
alias sizeof='du -csh'        # disk usage.  Calculate the total; show only a
                              # summary and don't recursively print; print size
                              # in human readable format rather than in bytes
alias processes='echo "did you mean ps?"'
alias off='xset dpms force off' #turn off the screen

# Global aliases -- These do not have to be at the beginning of the command line
# That means that if you have these aliased characters anywhere, they will be
# replaced by zsh.
# alias -g M='|more'
# alias -g H='|head'
# alias -g T='|tail'

# Suffix Aliases -- run the command whenever the alias is a suffix
# From http://grml.org/zsh/zsh-lovers.html
# alias -s tex=vim             #if I type foobar.tex, it will run the command
                               #vim foobar.tex

################################################################################
# KEYBINDINGS
#  * Check out man zshzle for more information on key bindings and on the ZSH
#    Line Editor.
#  * bindkey -s in-string out-string
#    when you type in-string, the line editor gets out-string
#  * bindkey [-R] in-string command
#    when you type in-string, command is run.  -R means that in-string is
#    treated as a range.
#  * the man page lists plenty of escape sequences that you can run
#  * you can use zle and vared for more advanced stuff.  You can also develop
#    your own widgets that mess with the line editor.
#  * TODO: customize based on the vim standard keymap
################################################################################

# CUSTOMIZE(editor)
# bindkey -e                # emacs keymap
bindkey -v                  # vim insert keymap
# bindkey -a                # vim command keymap

# bindkey '^X^Z' universal-argument ' ' magic-space
# bindkey '^X^A' vi-find-prev-char-skip
# bindkey '^Xa' _expand_alias
# bindkey '^Z' accept-and-hold
# bindkey -s '\M-/' \\\\
# bindkey -s '\M-=' \|

bindkey ' ' magic-space     # also do history expansion on space
bindkey '^I' complete-word  # complete on tab, leave expansion to _expand

################################################################################
# FUNCTIONS, EXTERNAL MODULES: SETUP
################################################################################

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Autoload zsh modules when they are referenced
# zmodload -a zsh/stat stat
# zmodload -a zsh/zpty zpty
# zmodload -a zsh/zprof zprof
# zmodload -ap zsh/mapfile mapfile

# use Ka-Ping Yee's hg commands
# TODO: only source if found
# within a script, $0 refers to the directory of the path of the script.  
# dirname $0 will get the directory of the script.
# we assume that hg-commands-for-bash.bashrc will be in the same directory as
# .zshrc
ZSHRC_DIR="$( dirname "$0" )"
source $ZSHRC_DIR/hg-commands-for-bash.bashrc

################################################################################
# ZKBD: see http://zshwiki.org/home/zle/bindkeys
# TODO: move this into its own file
################################################################################

# autoload zkbd
# function zkbd_file() {
#     [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
#     [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
#     return 1
# }
# 
# [[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
# keyfile=$(zkbd_file)
# ret=$?
# if [[ ${ret} -ne 0 ]]; then
#     zkbd
#     keyfile=$(zkbd_file)
#     ret=$?
# fi
# if [[ ${ret} -eq 0 ]] ; then
#     source "${keyfile}"
# else
#     printf 'Failed to setup keys using zkbd.\n'
# fi
# unfunction zkbd_file; unset keyfile ret
# 
# # setup key accordingly
# [[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
# [[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
# [[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
# [[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
# [[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
# [[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
# [[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
# [[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
# [[ -n "${key[PageUp]}"  ]]  && bindkey  "${key[PageUp]}"  vi-backward-blank-word
# [[ -n "${key[PageDown]}"  ]]  && bindkey  "${key[PageDown]}"  vi-forward-blank-word

################################################################################
# From Ubuntu .bashrc
# TODO: move this into its own file
################################################################################

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
  function command_not_found_handler {
    # check because c-n-f could've been removed in the meantime
    if [ -x /usr/lib/command-not-found ]; then
      /usr/bin/python /usr/lib/command-not-found -- $1
      return $?
    elif [ -x /usr/share/command-not-found ]; then
      /usr/bin/python /usr/share/command-not-found -- $1
      return $?
    else
      return 127
    fi
  }
fi

################################################################################
# SHELL COMMANDS TO RUN - these lines will be executed by zsh as if typed at
# the prompt.  If you can't find the man page for a given command, that's
# probably because it's built in to the shell.  In that case, you'll need to
# check out man zshbuiltins
################################################################################
# If messages are enabled with mesg y, then other people can message you using,
# for example, echo "Hey, Sam" | write samking would write "Hey, Sam" to my
# screen.  This will work as a primitive chat feature.  However, it also messes
# up your screen, so we disable it here.
mesg n

# Processes have resource limits, such as the number of file descriptors or the
# stack size.  running unlimit with no arguments sets the resource limit for
# all resources to the hard limit.  If you use -h, the hard limit is removed.
# if you use -s, the shell limit is removed.
# Check the description of limit in man zshbuiltins for a description of all
# resources that can be limited.
# It can be useful to use limits to prevent a buggy process from opening every
# file on the system or using all available memory with infinite recursion.
# We unlimit everything since it's more annoying to have a program crash after
# running for an hour because it ran out of stack space than to run low on
# memory and manually kill a process.
unlimit

# Manually set the limits that we want
# limit stack 8192
# limit core 0

# umask says what permissions files have when they're created (ie, using touch
# or mkdir).  If you use symbolic umask such as
# umask -S u=rw,g=r,o=r
# then you specify what IS allowed.  In this example, the user can read and
# write, and group and other can read.  Noone can execute.
# When you use octal notation such as
# umask 022
# then you specify what is not allowed.  In this case, the group and others
# CANNOT write to newly created files by default.
# If you only want yourself to be able to do anything, you can
# umask 077
# to make it so that noone else has any permissions.
# Either way, your umask will mask against 666, which means that noone will
# have execute permission by default.
umask 022

################################################################################
# TEMPORARY - Commands used for a class or a summer that is not intrinsic to
# the overall functioning of the shell
################################################################################

# alias srrun="./sr -u samking -T '1-router 2-server' -s vns-2.stanford.edu -r \
#              rtable.vrhost -l log" #cs144 SR running command
# export PATH=$PATH:/usr/class/cs140/`uname -m`/bin  # cs140 pintos bin folder
# export NNTPSERVER=usenet.stanford.edu # stanford usenet server
