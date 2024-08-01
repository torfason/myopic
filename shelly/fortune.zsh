
# Echo a single line documenting the plugin
echo "Define a fortune command if it is not installed"

# Make sure that a fortune_short command is always available,
# even if it is a non-informative stub.
if ! command -v fortune >/dev/null 2>&1; then
    # No fortune, naive substitute
    alias fortune_short='echo "Fortune favours the brave!"'
else
    # Check if 'fortune -s' returns an error
    fortune -s > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        # Check if 'fortune' without arguments returns an error
        fortune > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            # All calls to fortune return error, naive substitute
            alias fortune_short='echo "Fortune favours the brave!"'
        else
            # Error on -s, but plain fortune works
            alias fortune_short='fortune'
        fi
    else
        # Fortune present and fully working
        alias fortune_short='fortune -s'
    fi
fi
