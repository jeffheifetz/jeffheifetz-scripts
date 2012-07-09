export PATH=/usr/local/bin:$PATH

#****************************************alias****************************************************
alias chrome="open /Applications/Google\ Chrome.app/ --args -disable-web-security -start-maximized"
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias gr='git reset'
alias la='ls -la'
#**************************showing git branches in bash prompt***********************************
function is_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  if [ ${PWD##*/} != "webkit" ]; then
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(is_git_dirty)]/"
  fi
}
#*************************Git Completion*********************************************************
function proml {
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local      YELLOW="\[\033[0;33m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
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
\n$WHITE\$ "
PS2='> '
PS4='+ '
}
proml

#PS1='\[\033]0;\u@\h:\w\007\]\[\033[1;32m\]\w\[\033[0;33m\]$(parse_git_branch)\n\[\033[1;37m\]$ '

# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    . /usr/local/git/contrib/completion/git-completion.bash
fi
#GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

export TERM="xterm-256color"

cd ~/Coding

#Changes necessary for building webkit
export RICHMOND_ROOT=$HOME/Coding/browser
export QCONF_OVERRIDE=$RICHMOND_ROOT/qconf-override.mk

#Set a variable for the BBNDK locations
export BBNDK=/Applications/bbndk
source $BBNDK/bbndk-env.sh 

# WebKit Tools and Scripts
export PATH=$PATH:$RICHMOND_ROOT/webkit/WebKitTools/Scripts:$RICHMOND_ROOT/webkit/Tools/Scripts:$RICHMOND_ROOT/platform/tools/pb

#Addition of Desktop Qt for webplatform
export PATH=$PATH:/Users/jeff/QtSDK/Desktop/Qt/4.8.1/gcc/bin

##################################
# Put MacPorts after webkit changes to account for things like ctags
#################################
# MacPorts Installer addition on 2011-06-04_at_21:24:00: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#################################
#For DoctorJS/jsctags integration
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
