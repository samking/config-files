Sam King's Config Files and Scripts
============

This contains the following config files:

* Shells: zshrc, zshenv, login
* Editors: vimrc, vim directory, eclimrc
* Version Control: hgrc, gitconfig, gitignore

To use these config files, do the following:

1.  Fork this repo so that you can make your own changes.
2.  Clone your repo.  I'll assume it's in `~/config-files`.
3.  Run `grep -n CUSTOMIZE ~/config-files` to find all of the lines you need to
    change (eg, your username isn't samking, so it would probably be bad for
    your gitconfig to indicate that your username was samking).
4.  Run `~/config-files/setup-startup-scripts.bash` to add includes from your
    actual dot files (eg, `~/.vimrc`) to the `~/config-files` folder.

It also contains scripts that do the following:

* Backup mysql to Dropbox (useful as an easy backup scheme for servers)
* Enable two finger scrolling (useful when your hardware touchpad supports two
  finger scrolling but Ubuntu won't let you turn it on)
* Change the default editor in Ubuntu
* Remove the 10,000 folder limit in Dropbox
* Fix the permissions in a Drupal directory
* Fix missing locales (if your terminal hasn't yelled at you about this, you
  don't need to worry about it)
* Make it easier to see what the currently selected tab is in the Ubuntu
  terminal 
* Turn the screen off when locking the screen

Any per-computer settings should go in your actual dotfiles (eg, if I want to
define an alias that only lives on my work computer, it should go in `~/.zshrc`).
Any settings that you want reflected on all of your computers should go in
`~/config-files`.  That way, you can sync your computers using `git push` and
`git pull`.

Note that most of the files in this repo aren't dot files (files whose names
start with a dot).  That's because dot files are hidden by default, and it's
more convenient to see these files by default.  However, your real config files
(eg, `~/.vimrc` still need to be dot files.
