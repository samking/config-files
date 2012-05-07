#!/usr/bin/env bash
echo "This script will add lines in your zshrc, zshenv, vimrc, hgrc, and login
to source the files in this repository.  That way, you can have computer
specific settings (for instance, if you need a command to behave differently on
your ubuntu machine than on your mac) in your ~/.zshrc and settings that you
want on all of your computers in the repository.  Also, this creates a symbolic
link to the vim folder.
This makes it easier to update everything.  When there are changes in the
repository, all you need to do is hg pull and hg up.  You won't need to copy
anything down from your repository to your home directory.
Note that some things in each file are specific to me.  To find a list of those
places, run the following command:
  grep -n CUSTOMIZE *
Also note that gitconfig and gitinclude don't support includes, so you'll need
to manually copy them.
"

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
  # TODO: gitconfig might support includes soon.  When it does, add the include.

  # Creates a symbolic link to the vim folder where backups, temp files,
  # plugins, and other stuff is stored.
  # If ~/.vim doesn't exist
  if [ ! \( -d $HOME/.vim -o -L $HOME/.vim \) ]; then
    ln -s $CONFIG_PATH/vim -T $HOME/.vim
  # If we don't link to .vim, we still want the vimrc-etc folder to be linked.
  # If ~/.vim/vimrc-etc doesn't exist
  elif [ ! \( -d $HOME/.vim/vimrc-etc -o -L $HOME/.vim/vimrc-etc \) ]; then
    ln -s $CONFIG_PATH/vim/vimrc-etc -t $HOME/.vim
  fi
fi
