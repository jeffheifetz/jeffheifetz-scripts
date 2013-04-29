#!/bin/sh
Repo=$PWD
sudo ln -s $Repo/.bash_profile $HOME/.bash_profile
sudo ln -s $Repo/.gitconfig $HOME/.gitconfig
sudo ln -s $Repo/.iterm $HOME/.iterm
sudo ln -s $Repo/.ssh/config $HOME/.ssh/config
sudo ln -s $Repo/.vim $HOME/.vim
sudo ln -s $Repo/.vimrc $HOME/.vimrc
sudo ln -s $Repo/configureWebkit.sh $HOME/configureWebkit.sh
