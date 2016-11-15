################################################################################
# NOTE:  Most options are in the .zshrc since they only apply to interactive
# shells.  This is just for the enviornment variables that should be used for
# both interactive and non-interactive shells.
#
# This file was created by Sam King <sam@samking.org>.  Feel free to
# modify, distribute, and enjoy it.
################################################################################

# Get the path of the config directory, which is the same as the directory
# from which this script was executed.  From
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
pushd `dirname $0` > /dev/null
CONFIG_PATH=`pwd`
popd > /dev/null

# CUSTOMIZE(shell)
export SHELL=/bin/zsh
# CUSTOMIZE(editor)
export EDITOR=`which vim`
export VISUAL=`which vim`
# CUSTOMIZE(timezone)
# You can find the correct text for your timezone by running tzselect
TZ='America/Los_Angeles' 
export TZ
# My ackrc is in this config folder.
export ACKRC=$CONFIG_PATH/ackrc
