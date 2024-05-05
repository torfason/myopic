" Start with myopic configuration
source $HOME/myopic/vimrc
source $HOME/myopic/vimrc_myline

" Set $MYVIM variable and conditionally source ~/my/vimrc
if filereadable(expand("$HOME/my/vimrc"))
  let $MYVIM="$HOME/my"
  source $MYVIM/vimrc
else
  let $MYVIM="$HOME/myopic"
endif
