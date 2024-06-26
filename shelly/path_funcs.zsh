
# Echo a single line documenting the plugin
echo "Functions to manipulate PATH and MANPATH varibles"

# These are crucial for path manipulation
path_append ()
{
    path_remove "$1";
    export PATH="$PATH:$1";
}

path_prepend ()
{
    path_remove "$1";
    export PATH="$1:$PATH";
}

path_remove ()
{
    PATH=$(printf "%s" "$PATH" | awk -v RS=: -v ORS=: -v target="$1" '$0 != target' | sed 's/:$//')
    export PATH
}

path_uniq ()
{
    path | sed "y/:/\n/" | awk '!_[$0]++' | sed "s/^/:/g" | tr -d '\n'  | sed "s/^://"
}

path ()
{
    echo "$PATH" | sed "y/:/\n/"
}


# Equivalent functions for manipulating cdpath
cdpath_append ()
{
    cdpath_remove "$1";
    export CDPATH="$CDPATH:$1";
}

cdpath_prepend ()
{
    cdpath_remove "$1";
    export CDPATH="$1:$CDPATH";
}

cdpath_remove ()
{
    CDPATH=$(printf "%s" "$CDPATH" | awk -v RS=: -v ORS=: -v target="$1" '$0 != target' | sed 's/:$//')
    export CDPATH
}

cdpath ()
{
    echo "$CDPATH" | sed "y/:/\n/"
}


# Equivalent functions for manipulating MANPATH
manpath_append ()
{
    manpath_remove "$1";
    export MANPATH="$MANPATH:$1";
}

manpath_prepend ()
{
    manpath_remove "$1";
    export MANPATH="$1:$MANPATH";
}

manpath_remove ()
{
    MANPATH=$(printf "%s" "$MANPATH" | awk -v RS=: -v ORS=: -v target="$1" '$0 != target' | sed 's/:$//')
    export MANPATH
}

manpath ()
{
    echo "$MANPATH" | sed "y/:/\n/"
}
