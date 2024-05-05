# Start by sourcing ~/myopic/zlogin
source ~/myopic/zlogin

# Conditionally source ~/my/zprofile if it exists
if [ -f "$HOME/my/zlogin" ]; then
  source "$HOME/my/zlogin"
fi
