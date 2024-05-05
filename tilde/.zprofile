# Start by sourcing ~/myopic/zprofile
source ~/myopic/zprofile

# Conditionally source ~/my/zprofile if it exists
if [ -f "$HOME/my/zprofile" ]; then
  source "$HOME/my/zprofile"
fi
