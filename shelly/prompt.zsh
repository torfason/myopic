
# Echo one line on what this script does
echo "Set a very basic prompt (if omz is not installed)"

if [[ ! -d "$ZSH" ]]; then
    PS1="%n@%m %1~ ➜  "
fi
