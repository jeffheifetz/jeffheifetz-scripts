#!/bin/sh
git submodule update --init
Repo=$PWD
sudo ln -s $Repo/.bash_profile $HOME/.bash_profile
sudo ln -s $Repo/.bash_aliases $HOME/.bash_aliases
sudo ln -s $Repo/.bashrc $HOME/.bashrc
sudo ln -s $Repo/.gitconfig $HOME/.gitconfig
sudo ln -s $Repo/.iterm $HOME/.iterm
sudo ln -s $Repo/.ssh/config $HOME/.ssh/config
sudo ln -s $Repo/.vim $HOME/.vim
sudo ln -s $Repo/.vimrc $HOME/.vimrc
