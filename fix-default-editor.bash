#!/usr/bin/env bash
# Ubuntu decided that the default editor should be nano rather than vim.  This,
# annoyingly, makes it so that things like visudo or sudo git commit will use
# nano even if $EDITOR is set to vim.  To fix this, we need to change the
# default editor.
sudo update-alternatives --config editor

