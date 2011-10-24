#use zsh instead of csh if we are using an interactive shell and zsh exists 
#Checking that the prompt is defined is necessary because otherwise, the bootup
#shell when physically logging in to a cluster computer won't boot.
if ( $?prompt && -f /bin/zsh) exec /bin/zsh -l
