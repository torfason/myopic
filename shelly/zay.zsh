
# Echo a single line documenting the plugin
echo "The zay*() functions for wrapping output in nice frames"

# Generate a gradient trail
zay_xtrail() {

    if [ "$ZAY_THEME" = "light" ]; then
        # Light theme: Use darker start for better visibility on light backgrounds
        local start_color=232   # Darker gray
        local end_color=250     # Lighter gray
    else
        # Dark theme: Use lighter start for dark backgrounds
        local start_color=250   # Lighter gray
        local end_color=232     # Darker gray
    fi

    # Set the total length of the gradient line
    local total_length=32 # Adjust this as needed

    # Calculate the color step for the gradient
    local num_steps=16
    local color_step=$(( (start_color - end_color) / num_steps ))

    # Print the gradient line
    i=0
    while [ "$i" -lt "$total_length" ]; do
        # Calculate the current position in the gradient
        local position=$(( i * num_steps / total_length ))
        local current_color=$(( start_color - position * color_step ))

        # Print the current segment with the calculated color, without a newline
        printf "\033[38;5;%dm─" "$current_color"

        # Increment i
        i=$((i + 1))
    done

    # Reset the terminal color and move to a new line after the gradient line is complete
    printf "\033[0m\n"
}

# Print the top border with a gradient trail
zay_top() {
    printf "\033[0m╭"
    zay_xtrail
}

# Print the bottom border with a gradient trail
zay_bottom() {
    # Explicitly reset before starting the line
    printf "\033[0m╰"
    zay_xtrail
}

# Print a middle separator with a gradient trail
zay_middle() {
    printf "\033[0m├"
    zay_xtrail
}

# Print a horizontal line with a gradient trail
zay_horizontal() {
    printf "\033[0m─"
    zay_xtrail
}


# Prepend piped text or arguments with leading verrtical bar
zay_echo() {
    local input_from_args=""

    # Check if arguments are provided
    if [ "$#" -gt 0 ]; then
        # Join all arguments into a single string, separated by newlines
        input_from_args=$(printf "%s\n" "$@")
    fi

    # If we have input from arguments, print it.
    # A bit complicated because it is handling potentially multiline input
    if [ -n "$input_from_args" ]; then
        echo "$input_from_args" | while IFS= read -r line; do
            printf "\e[0m│ %s\n" "$line"
        done
    fi

    # Check for piped input
    if ! [ -t 0 ]; then
        # Print each line of the piped input with a leading vertical bar
        while IFS= read -r line; do
            printf "\e[0m│ %s\n" "$line"
        done
    fi
}



zay_cat() {

    # Print each line of the piped input with a leading vertical bar
    if [ -z "$ZSH_VERSION" ]; then
        # Run POSIX version if not running in zsh
        while IFS= read -r line; do
            printf "\e[0m│ %s\n" "$line"
        done
    else
        # Run zsh version if running in zsh
        # This somewhat convoluted approach correctly handles the case were the
        # input is updated character by character or by overwriting it repeatedly
        # with \r (carriage return). For such inputs, the output will be shown
        # immediately rather than just after a final \n (newline) or when the
        # input ends, and it will correctly updated lines with "│", ensuring
        # that such script outputs will look good inside a zay frame.

        # Set variables
        local last_char=""
        local current_char=""
        local prefix; prefix="$(printf '\033[0m│ ')"

        # No posix compliant way was found to assign \n and \t to variables
        local newline; newline=$'\n'
        local creturn; creturn=$'\r'

        # Variable to track if it is the first round
        local first_round=true


        # Read and process input character by character
        # This syntax relies on zsh and does not work in bash or other shells
        while IFS= read -u 0 -k 1 current_char; do

            # Print the prefix once at the start
            if $first_round; then
                printf "%s" "$prefix"
                first_round=false
            fi

            # If there's a remembered last character, print it now
            if [ -n "$last_char" ]; then
                printf "%s" "$last_char"
                # If last_char was a newline or carriage return, print the prefix
                if [ "$last_char" = "$newline" ] || [ "$last_char" = "$creturn" ]; then
                    printf "%s" "$prefix"
                fi
            fi

            # Remember this character to be potentially printed next loop
            last_char=$current_char
        done

        # Print the last character if it's not a newline or carriage return
        if [ "$last_char" = "$newline" ] && [ "$last_char" = "$creturn" ]; then
            printf "%s" "$last_char"
        fi

        # Ensure output ends correctly with a newline. The check determines if any content
        # was found in the pipe, because then the first_round variable is no longer true.
        if ! $first_round; then
            printf "$newline"
        fi

    fi
}

zay() {
    local input_from_args=""
    local separator_needed=false

    # Check if arguments are provided
    if [ "$#" -gt 0 ]; then
        # Join all arguments into a single string, separated by newlines
        input_from_args=$(printf "%s\n" "$@")
    fi

    # Determine if we should prepare to print a separator based on the presence of arguments and piped input
    # The separator is needed only if both conditions are true.
    if [ -n "$input_from_args" ] && ! [ -t 0 ]; then
        separator_needed=true
    fi

    # Print the top border
    zay_top

    # If we have input from arguments, print it. A bit complicated in case we have multiline input
    if [ -n "$input_from_args" ]; then
        echo "$input_from_args" | while IFS= read -r line; do
            printf "\e[0m│ %s\n" "$line"
        done
    fi

    # If a separator is needed, print it
    if [ "$separator_needed" = true ]; then
        zay_middle
    fi

    # Check for piped input
    if ! [ -t 0 ]; then

        # Print each line of the piped input with a leading vertical bar
        if [ -z "$ZSH_VERSION" ]; then
            # Run POSIX version if not running in zsh
            while IFS= read -r line; do
                printf "\e[0m│ %s\n" "$line"
            done
        else
            # Run zsh version if running in zsh
            # This somewhat convoluted approach correctly handles the case were the
            # input is updated character by character or by overwriting it repeatedly
            # with \r (carriage return). For such inputs, the output will be shown
            # immediately rather than just after a final \n (newline) or when the
            # input ends, and it will correctly updated lines with "│", ensuring
            # that such script outputs will look good inside a zay frame.

            # Set variables
            local last_char=""
            local current_char=""
            local prefix; prefix="$(printf '\033[0m│ ')"

            # No posix compliant way was found to assign \n and \t to variables
            local newline; newline=$'\n'
            local creturn; creturn=$'\r'

            # Print the prefix once at the start
            printf "%s" "$prefix"

            # Read and process input character by character
            # This syntax relies on zsh and does not work in bash or other shells
            while IFS= read -u 0 -k 1 current_char; do
                # If there's a remembered last character, print it now
                if [ -n "$last_char" ]; then
                    printf "%s" "$last_char"
                    # If last_char was a newline or carriage return, print the prefix
                    if [ "$last_char" = "$newline" ] || [ "$last_char" = "$creturn" ]; then
                        printf "%s" "$prefix"
                    fi
                fi

                # Remember this character to be potentially printed next loop
                last_char=$current_char
            done

            # Print the last character if it's not a newline or carriage return
            if [ "$last_char" = "$newline" ] && [ "$last_char" = "$creturn" ]; then
                printf "%s" "$last_char"
            fi

            # Ensure output ends correctly
            echo
        fi

    fi

    # Print the bottom border
    zay_bottom
}
