My myopic dot-files
==========

Yet another dot-file repository, in the style of `oh-my-zsh` and other such frameworks, but much more *myopic*, in that although it may well work for others, they would generally be much better off installing more comprehensive frameworks.

These files are not intended to be placed directly into the home directory. Rather, the recommended installation procedure is to clone this into a subdirectory (e.g. `~/myopic`) and include each file from the corresponding default configuration file. The files in `myopic/tilde` are suitable for linking to the home directory using GNU `stow`.

Installing myopic on a new computer
--------------------------------------------

The `myopic` dot files works best with `omz`, so install that first. Then do:

```
# First, clone the repository to your home directory
git clone https://github.com/torfason/myopic
cd myopic

# Then stow relevant files, except .zshrc which needs to be appended instead
stow -nv --ignore=.zshrc tilde # To see what will be done
stow -v  --ignore=.zshrc tilde
cat ~/myopic/tilde/.zshrc >> ~/.zshrc

# Enable omz plugins
omz plugin enable git
omz plugin enable timer
omz plugin enable vi-mode
omz plugin enable fzf
omz plugin enable z
```

