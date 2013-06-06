#!/bin/bash
# From
# http://askubuntu.com/questions/248972/how-can-i-disable-backlight-when-i-lock-the-screen
# Locks the screen and turns the monitor off
sleep 0.5
xset dpms force off
gnome-screensaver-command --lock
