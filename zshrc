
# Main myopic function only shows documentation for now
myopic()
{
  echo "Choose one of the more specific commands:"
  echo "  myopic_list_plugins: List loaded plugins"
  echo "  myopic_source_directory: Source all files in a directory"
}

# Print list of loaded myopic shelly plugins
myopic_list_plugins()
{
    local combined_output

    # Loop over the array indices
    for i in {1..${#_MYOPIC_PLUGIN_NAMES[@]}}; do
        # Pad plugin_names[i] to be at least 12 characters wide, aligned left
        formatted_name=$(printf "%-14s" "${_MYOPIC_PLUGIN_NAMES[i]}:")
        # Append formatted name and corresponding documentation to combined_output
        combined_output+="${formatted_name} ${_MYOPIC_PLUGIN_INFO[i]}\n"
    done

    echo -n $combined_output | zay "Loaded plugins"
}

# Source all .zsh directories in a single directory and collect
# the results into environment variables for later examiniation
myopic_source_directory()
{
    local dir=$1

    # Check if the directory exists
    if [[ -d $dir ]]; then
        # Loop through all .zsh files in the specified directory
        for file in "$dir"/*.zsh; do
            # Check if the file exists to avoid errors if no .zsh files are found
            if [[ -f $file ]]; then
                # Append name of each shelly pluging to messages array
                local base_name="${file:t:r}"
                local plugin_info=$(source "$file" | head -n 1 | tr -d '\n')
                _MYOPIC_PLUGIN_NAMES+=("$base_name")
                _MYOPIC_PLUGIN_INFO+=("$plugin_info")
                # And then source the file to load its contents
                source $file > /dev/null
            fi
        done
    else
        echo "myopic_source_directory(): Directory <$dir> does not exist."
    fi

}


# ------------------------------------------
# Shelly: Source shelly plugins for myopic and my
# ------------------------------------------

# Source plugins using myopic_source_directory() (defined above)
# The function handles missing directories without errors
myopic_source_directory "$HOME/myopic/shelly"
myopic_source_directory "$HOME/my/shelly"

# END shelly


# ------------------------------------------
# Source ~/my/zshrc
# ------------------------------------------

if [ -f "$HOME/my/zshrc" ]; then
  source "$HOME/my/zshrc"
fi

# END source ~/my/zshrc


# ------------------------------------------
# Additional settings
# ------------------------------------------

# Determine if this is a local or remote connection
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ] || ps -p $PPID -o comm= | grep -iq sshd; then
  export MYOPIC_SESSION_TYPE="remote"
else
  export MYOPIC_SESSION_TYPE="local"
fi

# Vim bindings for zsh (and enable it if omz is not configured to do so)
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# Save history (especially for when omz is not installed)
# See: https://www.soberkoder.com/better-zsh-history/
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Additional config for omz timer plugin
TIMER_THRESHOLD=1

# Set ll aliases
alias ll='ls -l'   # Also defined by omz
alias lll='ls -la'
