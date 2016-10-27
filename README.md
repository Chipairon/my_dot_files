My dot files
============

Usage:

```bash
cd ~
git clone https://github.com/Chipairon/my_dot_files.git .my_dot_files_repo
cd .my_dot_files_repo
./install.sh
```


For neovim / nvim use, follow this:

https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim

Last time I checked:

Install pyenv:
`curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash`

```shell
pyenv install 2.7.11
pyenv install 3.4.4

pyenv virtualenv 2.7.11 neovim2
pyenv virtualenv 3.4.4 neovim3

pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path

pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path

# The following is optional, and the neovim3 env is still active
# This allows flake8 to be available to linter plugins regardless
# of what env is currently active.  Repeat this pattern for other
# packages that provide cli programs that are used in Neovim.
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
```

Now that you've noted the interpreter paths, add the following to your
`init.vim` file:

```vim
let g:python_host_prog = '/full/path/to/neovim2/bin/python'
let g:python3_host_prog = '/full/path/to/neovim3/bin/python'
```
