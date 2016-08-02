export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH
#**************************showing git branches in bash prompt***********************************
function is_in_git {
    [ -d ".git" ] || git rev-parse --git-dir &> /dev/null
}

function is_git_dirty {
    [[  -n $(git status -z 2>/dev/null) ]] && echo "*"
}

function parse_git_branch {
    #Ensure this is not run in the webkit repo (takes too long)
    if [[ $(basename "$PWD") != "webkit" ]] && is_in_git; then
        local BRANCH=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null)
        if [ "$BRANCH" == HEAD ]; then
            BRANCH=$(git name-rev --name-only HEAD 2> /dev/null)
            if [ -z "$BRANCH"]; then
                BRANCH="??"
            fi
        fi
        echo -n [$BRANCH$(is_git_dirty)]
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


# Set autocompletion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

export TERM="xterm-256color"

##################################
# Put MacPorts after webkit changes to account for things like ctags
#################################
# MacPorts Installer addition on 2011-06-04_at_21:24:00: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
#################################
#For DoctorJS/jsctags integration
#export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
#################################
#For ANDROID integration
#export ADT=~/Coding/adt-bundle-mac-x86_64-20130219/sdk/
export ANDROID_HOME=/Users/jeffheifetz/Coding/tools/android-sdk-macosx
#export PATH=${PATH}:$ADT/platform-tools:$ADT/tools
export PATH=${PATH}:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
export JAVA8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home/
#################################
#For Maven
export MVN_HOME=/usr/local/maven
export PATH=${MVN_HOME}/bin:${PATH}
export MAVEN_OPTS="-Xms256m -Xmx1024m -XX:MaxPermSize=128m"
#################################
#For Ant
export ANT_HOME=/usr/local/ant
export PATH=${PATH}:${ANT_HOME}/bin
#################################
#For Rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#################################
#For Ec2
export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.7.1.0/libexec"
export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.5.3/libexec"
#################################
#For Postgres.app
export PG_HOME="/Applications/Postgres.app/Contents/Versions/9.3/"
export PATH=${PATH}:${PG_HOME}/bin
#################################
#For Libffi on OSX 10.10
export PKG_CONFIG_PATH=/usr/local/opt/libffi/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH
#################################
#For Heroku
export PATH="/usr/local/heroku/bin:$PATH"
#################################
#For NVM
export NVM_DIR="/Users/jeffheifetz/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#################################
#For Rust
export PATH="/Users/jeffheifetz/.cargo/bin:$PATH"


# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

cd ~/Coding
