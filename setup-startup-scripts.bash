#!/usr/bin/env bash
echo "This script will set up the following files:
* Shells: zshrc, zshenv, login
* Editors: vimrc, vim directory
* Version Control: hgrc, gitconfig

This script does NOT set up any of the following:
* eclim, eclimrc
* gitignore

The vim directory will be symlinked; the others will import the files in the
config folder.  That means that you just need to git push and git pull to make
changes.

If you want computer-specific settings (for instance, if you need a command to
behave differently on your work machine versus on your personal machine), put
the common things in the repository and leave per-machine things in your actual
dot files.

Note that some things in each file should be customized.  To find a list of
those places, run the following command:
  grep -n CUSTOMIZE *

Also note that gitignore and eclimrc don't support includes, so you'll need to
manually copy them.

For the sake of visibility, none of these are dot files.  However, in your home
folder, they must be dot files.
"

# For instructions on how to do a confirmation like this, see
# http://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
read -r -p "This should just add a line to your files, but it could cause
unintended consequences.  Are you sure you want to continue? [Y/n] " response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y|) ]]
then
  # Get the path of the config directory, which is the same as the directory
  # from which this script was executed.  From
  # http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
  pushd `dirname $0` > /dev/null
  CONFIG_PATH=`pwd`
  popd > /dev/null

  # TODO: tell the user what commands we're running as we run them.  Tell the
  #       user when we're done.

  # Append the command to source the relevant files in this repo to the actual
  # dot files.  Only add the line if the line doesn't already exist
  if [ \( -z "`grep -s "source $CONFIG_PATH/zshrc" $HOME/.zshrc`" \) ]; then
    echo "source $CONFIG_PATH/zshrc" >> $HOME/.zshrc
  fi
  if [ \( -z "`grep -s "source $CONFIG_PATH/zshenv" $HOME/.zshenv`" \) ]; then
    echo "source $CONFIG_PATH/zshenv" >> $HOME/.zshenv
  fi
  if [ \( -z "`grep -s "source $CONFIG_PATH/vimrc" $HOME/.vimrc`" \) ]; then
    echo "source $CONFIG_PATH/vimrc" >> $HOME/.vimrc
  fi
  if [ \( -z "`grep -s "%include $CONFIG_PATH/hgrc" $HOME/.hgrc`" \) ]; then
    echo "%include $CONFIG_PATH/hgrc" >> $HOME/.hgrc
  fi
  if [ \( -z "`grep -s "source $CONFIG_PATH/login" $HOME/.login`" \) ]; then
    echo "source $CONFIG_PATH/login" >> $HOME/.login
  fi
  if [ \( -z "`grep -s "$CONFIG_PATH/gitconfig" $HOME/.gitconfig`" \) ]; then
    echo -e "[include]\n  path = $CONFIG_PATH/gitconfig" >> $HOME/.gitconfig
  fi
  # TODO: add option to copy over files even if there isn't an include directive

  # Creates a symbolic link to the vim folder where backups, temp files,
  # plugins, and other stuff is stored.
  # If ~/.vim doesn't exist
  if [ ! \( -d $HOME/.vim -o -L $HOME/.vim \) ]; then
    ln -s $CONFIG_PATH/vim $HOME/.vim
  # If we don't link to .vim, we still want the vimrc-etc folder to be linked.
  # If ~/.vim/vimrc-etc doesn't exist
  elif [ ! \( -d $HOME/.vim/vimrc-etc -o -L $HOME/.vim/vimrc-etc \) ]; then
    ln -s $CONFIG_PATH/vim/vimrc-etc $HOME/.vim/vimrc-etc
  fi
fi
