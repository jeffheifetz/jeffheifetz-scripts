#!/bin/sh
git submodule update --init
Repo=$PWD
sudo ln -fs $Repo/.bash_profile $HOME/.bash_profile
sudo ln -fs $Repo/.bash_aliases $HOME/.bash_aliases
sudo ln -fs $Repo/.bashrc $HOME/.bashrc
sudo ln -fs $Repo/.gitconfig $HOME/.gitconfig
sudo ln -fs $Repo/.gitignore $HOME/.gitignore
sudo ln -fs $Repo/.iterm $HOME/.iterm
sudo ln -fs $Repo/.ssh/config $HOME/.ssh/config
sudo ln -fs $Repo/.vim $HOME/.vim
sudo ln -fs $Repo/.vimrc $HOME/.vimrc
