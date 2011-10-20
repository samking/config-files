# @(#) Leland Systems .login version 3.0.3
#
# The .login file is used by tcsh and csh for login shells.
# .login commands are executed after those in the .cshrc file
#
# It should only contain terminal initialization and programs run at
# login.  Other items, such as environment and shell variables and
# aliases belong in the .cshrc file, not here.
 
#use zsh instead of csh if we are using an interactive shell and zsh exists 
#Checking that the prompt is defined is necessary because otherwise, the bootup
#shell when physically logging in to a cluster computer won't boot.
if ( $?prompt && -f /bin/zsh) exec /bin/zsh -l

#----------------#
# Terminal Setup #
#----------------#

loop:
  ## If modem dialup or vt100, use vt100
  if ($TERM == network || $TERM =~ *[vV][tT]*100) eval `tset -QIs vt100`

  ## If don't know, ask (default to vt100).  Otherwise, use it.
  if ($TERM == '' || $TERM == unknown) then	# don't know?
    eval `tset -QIs \?vt100`		# then ask (default vt100)
    else eval `tset -QIs $TERM`		# know?  use it then
  endif

if ($TERM == unknown || $TERM == '') goto loop
unset noglob

#-------------------#
# X Windows Startup #
#-------------------#

# Ask if we should start X if logged onto a console
if ( ! $?tty ) set tty=`tty | sed 's%/dev/%%'`
if ( $tty == console || $tty =~ ?ft* ) then
    echo -n "Shall I start the X Windows System? (y/n) "
    if ("$<" =~ [yY]*) x
endif

#---------------------------#
# Login Programs and Checks #
#---------------------------#

# logout if idle for 90 minutes (only for login shells)
if ( $?loginsh && ! $?DISPLAY ) set autologout=90

# Display important system messages
msgs -pf

# Asynchronously notify me of new email (use "biff n" to disable)
biff y

# Allow other users to write and talk to me (use "mesg n" to disable)
mesg y
