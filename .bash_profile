export PATH=/usr/local/bin:$HOME/bin:$PATH
#****************************************alias****************************************************
alias chrome="open /Applications/Google\ Chrome.app/ --args -disable-web-security -allow-file-access-from-files -start-maximized"
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %Cred(Author: %ae)%Creset" --abbrev-commit --date=relative'
alias gst='git status'
alias la='ls -la'
#**************************showing git branches in bash prompt***********************************
function is_git_dirty {
   [[ $(git status -z | grep -v '^\?') != "" ]] && echo "*"
}

function parse_git_branch {
  #Ensure this is only run in git directories
  if [ -d ".git" ] || git rev-parse --git-dir > /dev/null 2>&1 ; then
    #Ensure this is not run in the webkit repo (takes too long)
    if [ ${PWD##*/} != "webkit" ]; then
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(is_git_dirty)]/"
    fi
  fi
}
#*************************Git Completion*********************************************************
function proml {
  local          RED="\[\033[0;31m\]"
  local    LIGHT_RED="\[\033[1;31m\]"
  local       YELLOW="\[\033[0;33m\]"
  local  LIGHT_GREEN="\[\033[1;32m\]"
  local        WHITE="\[\033[1;37m\]"
  local   LIGHT_GRAY="\[\033[0;37m\]"
  local LIGHT_PURPLE="\[\033[1;34m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
$LIGHT_GREEN\w$YELLOW\$(parse_git_branch)\
\n$WHITE ⚡ "
PS2='> '
PS4='+ '
}
proml


# Set git autocompletion
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    . /usr/local/git/contrib/completion/git-completion.bash
fi

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

export TERM="xterm-256color"

cd ~/Coding

#read -p "Would you like to setup bbndk? " -n 1
#if [[ $REPLY =~ ^[Yy]$ ]]; then
    #Set a variable for the BBNDK locations
    export BBNDK=~/SDKs/bbndks/BB10.0.09-2222
    source $BBNDK/bbndk-env.sh
#fi

#read -p "Would you like to setup for webkit?" -n 1
#if [[ $REPLY =~ ^[Yy]$ ]]; then
    source ~/configureWebkit.sh
#fi

##################################
# Put MacPorts after webkit changes to account for things like ctags
#################################
# MacPorts Installer addition on 2011-06-04_at_21:24:00: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#################################
#For DoctorJS/jsctags integration
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH

#################################
#For ADT integration
export ADT=~/Coding/adt-bundle-mac-x86_64-20130219/sdk/
export PATH=${PATH}:$ADT/platform-tools:$ADT/tools
