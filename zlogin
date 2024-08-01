
# ----------------
# zlogin runs at the end of the login process to show information to the user
# ----------------

# Display a welcoming prompt on startup
echo ""
zay_top
zay_echo "System: $(uname) / $(whoami)@$(hostname) ($MYOPIC_SESSION_TYPE session)"
zay_echo "Shell:  $ZSH_NAME$BASH / $BASH_VERSION$(zsh --version)"
zay_middle
echo "Shelly: "${_MYOPIC_PLUGIN_NAMES[@]}"" | fold -sw 60 | zay_cat
zay_middle
fortune_short | zay_echo
zay_bottom
echo ""
