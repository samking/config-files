#! /usr/bin/env bash
# Dropbox will only sync a max of 10000 folders without this option set.
echo fs.inotify.max_user_watches=100000 | sudo tee -a /etc/sysctl.conf; sudo sysctl -p

