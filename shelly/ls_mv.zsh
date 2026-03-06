
# Echo a single line documenting the plugin
echo "Set up opinionated aliases for ls and mv"

## Switch documentation
# -G → color output (macOS’s equivalent of --color=auto)
# -l → long format (permissions, owner, size, date)
# -h → human readable file sizes (not used by default)
# -a → include hidden “dotfiles”
# -e → show ACL privileges
# -@ → show extended attributes for each file (name and size, e.g.
# -t → sort by modification time (newest first)
# -r → reverse that order (so oldest first)

# Aliases for ls
alias ls='ls -G'  # Also defined by omz
alias ll='ls -Gl'
alias lll='ls -Gla'
alias llll='ls -Glae@'

# Human readable file size variant of ll
alias llh='ls -Glh'

# Special t variants that list in reverse time order of modification
alias lst='ls -Gtr'
alias llt='ls -Gltr'
alias lllt='ls -Glatr'

# THIS ONE IS VERY IMPORTANT
# Prevent mv from overwriting without asking
alias mv='mv -i'
