
# Basic aliases
alias ll='ls -l'
alias lll='ls -la'

# Choose the best available editor
EDITOR=vi
if [ `builtin type -p vim` ]; then 
    EDITOR=vim
fi
if [ `builtin type -p nvim` ]; then 
    EDITOR=nvim
fi
export EDITOR

# Set common edit commands to the chosen editor
alias vi='$EDITOR' 
alias edit='$EDITOR'

# Set a nicer prompt by defining PS1
#
# Options include \h \u \w \W
# If color settings are acting up a monochrome version is:
# export PS1="$HOSTNAME_SHORT [\W]$ "
C_GREEN="\[\e[0;32m\]"
C_YELLOW="\[\e[0;33m\]"
C_CLEAR="\[\e[0m\]"
export PS1="$C_GREEN$HOSTNAME_SHORT [$C_YELLOW\W$C_GREEN]$ $C_CLEAR"

# Activate terminal color
export TERM=xterm-color

