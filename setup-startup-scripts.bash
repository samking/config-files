#!/usr/bin/env bash
echo "This script will add lines in your zshrc, zshenv, vimrc, and hgrc to
source the files in this repository.  That way, you can have computer specific
settings (for instance, if you need a command to behave differently on your
ubuntu machine than on your mac) in your ~/.zshrc and settings that you want on
all of your computers in the repository.
Also, this makes it easier to update everything.  When there are changes in the
repository, all you need to do is hg pull.  You won't need to copy anything down
from your repository to your home directory."

# For instructions on how to do a confirmation like this, see
# http://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
read -p "This should just add a line to your files, but it could cause
unintended consequences.  Are you sure that you want to continue? " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Get the path of the config directory, which is the same as the directory
  # from which this script was executed.  From
  # http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
  pushd `dirname $0` > /dev/null
  CONFIG_PATH=`pwd`
  popd > /dev/null

  # Append the command to source the relevant files in this repo to the actual
  # dot files
  # TODO: don't append to a file if that file already has the same line in it
  # TODO: tell the user what commands we're running as we run them.  Tell the
  #       user when we're done.
  echo "source $CONFIG_PATH/.zshrc" >> $HOME/.zshrc
  echo "source $CONFIG_PATH/.zshenv" >> $HOME/.zshenv
  echo "source $CONFIG_PATH/.vimrc" >> $HOME/.vimrc
  echo "%include $CONFIG_PATH/.hgrc" >> $HOME/.hgrc

  # TODO: figure out what to do with files included by zshrc (.hg.bashrc) and
  # vimrc (.vim/stuff)
fi

# TODO: when this file is ready, the dot files in this directory should be
# un-dotted to make them easier to see

