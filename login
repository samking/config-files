# Use zsh instead of csh if we are using an interactive shell and zsh exists 
#
# This script is only necessary for people who use systems that
# * set their default shell to csh
# * don't let them configure their default shell
#
# Checking that the prompt is defined is necessary because otherwise, the bootup
# shell when physically logging in to a cluster computer won't boot.
#
# CUSTOMIZE(shell)
if ( $?prompt && -f /bin/zsh) exec /bin/zsh -l
