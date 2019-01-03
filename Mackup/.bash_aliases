alias la='ls -la'
alias ll='ls -la'
alias lll='ls -la'
alias l='ls -CF'
alias chrome="open /Applications/Google\ Chrome.app/ --args -disable-web-security -allow-file-access-from-files -start-maximized"
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %Cred(Author: %ae)%Creset" --abbrev-commit --date=relative'
alias gst='git status'
alias vi='mvim -v'
# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }


