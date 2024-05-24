
# Echo a single line documenting the plugin
echo "Define a fortune command if it is not installed"

# Make sure that a fortune command is always avaiable,
# even if it is a non-informative stub.
if ! command -v fortune >/dev/null 2>&1; then
    alias fortune='echo "Fortune favours the brave!"'
else
    # Check if 'fortune' returns an error
    fortune > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        alias fortune='echo "Fortune favours the brave!"'
    fi
fi
