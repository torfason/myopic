
# Echo a single line documenting the plugin
echo "Choose the best available editor"

EDITOR="vi"
if command -v vim >/dev/null 2>&1; then
    EDITOR="vim"
fi
if command -v nvim >/dev/null 2>&1; then
    EDITOR="nvim"
fi
export EDITOR

# Set common edit commands to the chosen editor
alias vi='$EDITOR'
alias edit='$EDITOR'
