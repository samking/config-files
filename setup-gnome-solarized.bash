#!/usr/bin/env bash
set -euxo pipefail

# Get the path of the config directory, which is the same as the directory
# from which this script was executed.  From
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
pushd `dirname $0` > /dev/null
CONFIG_PATH=`pwd`
popd > /dev/null

# Setup Solarized ls colors
if [[ ! -e $HOME/config-files/gnome-terminal-colors-solarized/install.sh ]]; then
  git clone git@github.com:Anthony25/gnome-terminal-colors-solarized.git $CONFIG_PATH/gnome-terminal-colors-solarized
fi

$CONFIG_PATH/gnome-terminal-colors-solarized/install.sh -s dark
