####################################
#BIG MESS
####################################

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
zstyle :compinstall filename '/home/samking/.zshrc'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh-histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory beep nomatch dvorak
unsetopt autocd extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install
#manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
#export MANPATH

# Hosts to use for completion (see later zstyle)
#hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)

# Some environment variables
#export MAIL=/var/spool/mail/$USERNAME
#export LESS=-cex3M
#export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

#MAILCHECK=300
DIRSTACKSIZE=40

# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
#watch=(notme)                   # watch for everybody but me
#LOGCHECK=300                    # check every 5 min for login/logout activity
#WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
#setopt   notify globdots correct pushdtohome cdablevars autolist
#setopt   correctall autocd recexact longlistjobs
#setopt   autoresume histignoredups pushdsilent noclobber
#setopt   autopushd pushdminus extendedglob rcquotes mailwarning
#unsetopt bgnice autoparamslash


#cdpath=(.. ~ ~/src ~/zsh)  #Search path for the cd command

# Use hard limits, except for a smaller stack and no core dumps
#unlimit
#limit stack 8192
#limit core 0
#limit -s

#umask 077

#environmental variables
export SHELL=/bin/zsh
export EDITOR=vim
export VISUAL=vim
export PATH=$PATH:/var/lib/gems/1.8/bin/
prompt='%B%n@%m%b[%*]%U%~%u$ ' #<b>name@server</b>[time]<u>path</u>$
export NNTPSERVER=usenet.stanford.edu
export PATH=$PATH:/usr/class/cs140/`uname -m`/bin 

###################################################
# ALIASES 
###################################################
alias srrun="./sr -u samking -T '1-router 2-server' -s vns-2.stanford.edu -r rtable.vrhost -l log"
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
#alias j=jobs
#alias pu=pushd
#alias po=popd
#alias d='dirs -v'
#alias h=history
alias grep=egrep            #use extended regular expressions
alias ls='ls --color=auto'  #make ls pretty
alias lsal='ls -al'
alias lsl='ls -l'           #detail-list view
alias dir=lsl
alias lsa='ls -a'           #list all
alias lsd='ls -d *(-/DN)'  #list directories
alias lsh='ls -ld .*'       #list hidden
alias ..='cd ..'
alias :q='exit'             #quit out of the shell like from vim
alias :Q='exit'
alias gdba='gdb --args'     #call GDB with args automatically set
alias asdf='setxkbmap -model pc104 -layout us -variant dvorak'  #asdf->dvorak 
alias aoeu='setxkbmap -model pc104 -layout us'                  #aoeu->qwerty
#alias rmt='trash'            #don't throw things away quite yet #but rmt is an existing command, so we shouldn't use it
alias diff='diff -bBr'      #ignore whitespace, recursively compare directories
alias hglu='hg log -r 0:' #upside down.  That way, even if there are many revisions, the important revision is visible
alias sizeof='du -csh'        #disk usage.  Calculate the total; show only a summary and don't recursively print; print size in human readable format rather than in bytes
alias processes='echo "did you mean ps?"'

# Global aliases -- These do not have to be
# at the beginning of the command line.
#alias -g M='|more'
#alias -g H='|head'
#alias -g T='|tail'

###################################################
# KEYBINDINGS
###################################################

# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand


###########################################
# FUNCTIONS, EXTERNAL MODULES: SETUP
###########################################

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
#zmodload -a zsh/stat stat
#zmodload -a zsh/zpty zpty
#zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile

############################################
#ZKBD: http://zshwiki.org/home/zle/bindkeys 
############################################

#autoload zkbd
#function zkbd_file() {
#    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
#    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
#    return 1
#}
#
#[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
#keyfile=$(zkbd_file)
#ret=$?
#if [[ ${ret} -ne 0 ]]; then
#    zkbd
#    keyfile=$(zkbd_file)
#    ret=$?
#fi
#if [[ ${ret} -eq 0 ]] ; then
#    source "${keyfile}"
#else
#    printf 'Failed to setup keys using zkbd.\n'
#fi
#unfunction zkbd_file; unset keyfile ret
#
## setup key accordingly
#[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
#[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
#[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
#[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
#[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
#[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
#[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
#[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
#[[ -n "${key[PageUp]}"  ]]  && bindkey  "${key[PageUp]}"  vi-backward-blank-word
#[[ -n "${key[PageDown]}"  ]]  && bindkey  "${key[PageDown]}"  vi-forward-blank-word

#############################
# From Ubuntu .bashrc
#############################

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ]; then
  case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
  esac
fi

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

