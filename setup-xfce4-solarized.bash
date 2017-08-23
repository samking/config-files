#!/bin/bash
set -euxo pipefail

# Get the path of the config directory, which is the same as the directory
# from which this script was executed.  From
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
pushd `dirname $0` > /dev/null
CONFIG_PATH=`pwd`
popd > /dev/null

# Setup Solarized terminal colors
if [[ ! -e $CONFIG_PATH/xfce4-terminal-colors-solarized/README.md ]]; then
  git clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git $CONFIG_PATH/xfce4-terminal-colors-solarized
fi

mkdir -p ~/.config/xfce4/terminal
ln -s $CONFIG_PATH/xfce4-terminal-colors-solarized/dark/terminalrc ~/.config/xfce4/terminal/terminalrc
