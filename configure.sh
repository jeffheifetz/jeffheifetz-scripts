#!/bin/sh
git submodule update --init
Repo=$PWD
sudo ln -fs $Repo/.bash_profile $HOME/.bash_profile
sudo ln -fs $Repo/.bash_aliases $HOME/.bash_aliases
sudo ln -fs $Repo/.bashrc $HOME/.bashrc
sudo ln -fs $Repo/.gitconfig $HOME/.gitconfig
sudo ln -fs $Repo/.iterm $HOME/.iterm
sudo ln -fs $Repo/.ssh/config $HOME/.ssh/config
sudo ln -fs $Repo/.vim $HOME/.vim
sudo ln -fs $Repo/.vimrc $HOME/.vimrc

# setup some personalized entries via question/answer
if [ "$1" == "update" ]; then
    echo "Enter your name used for git and press [ENTER]:"
    read git_name

    echo "Enter your email address usde for git and press [ENTER]:"
    read git_email

    echo "Enter your Github user id and press [ENTER]:"
    read github_user

    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global github.user "$github_user"
fi
