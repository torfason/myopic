
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
  echo $MY_SHELLY_PLUGIN_INFO | zay "Loaded plugins"
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
                # Append base name of each shelly pluging to messages array
                base_name="${file:t:r}"
                plugin_names+=("$base_name")
                plugin_docs+=$(source $file)
                source $file > /dev/null
            fi
        done
    else
        echo "myopic_source_directory(): Directory <$dir> does not exist."
    fi

    # Loop over the array indices
    for i in {1..${#plugin_names[@]}}; do
        # Pad plugin_names[i] to be at least 12 characters wide, aligned left
        formatted_name=$(printf "%-14s" "${plugin_names[i]}:")
        # Append formatted name and corresponding documentation to combined_output
        combined_output+="${formatted_name} ${plugin_docs[i]}\n"
    done
}


# ----------------
# Main section:
# Source myopic shelly plugins relevant for interactive shells
# ----------------

# Initialize empty arrays
plugin_names=()
plugin_docs=()

# Initialized empty string
combined_output=""

# Source plugins using myopic_source_directory() (defined above)
# The function handles missing directories without errors
myopic_source_directory "$HOME/myopic/shelly"
myopic_source_directory "$HOME/my/shelly"

# Use sed to remove last newline in the combined output
combined_output=$(echo "$combined_output" | sed '$ s/\(.*\)\n/\1/')

# Export messages array as an environment variable
# TODO: Update structure to keep the names and info about loaded
#       plugins in array, and only combine them when calling
#       myopic_list_plugins() - with an argument on detail vs
#       only a simple name list.
export MY_SHELLY_PLUGINS=("${plugin_names[@]}")
export MY_SHELLY_PLUGIN_INFO="$combined_output"

# END shelly


# Determine if this is a local or remote connection
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ] || ps -p $PPID -o comm= | grep -iq sshd; then
  export MYOPIC_SESSION_TYPE="remote"
else
  export MYOPIC_SESSION_TYPE="local"
fi
