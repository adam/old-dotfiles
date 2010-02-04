export PATH=~/.rvm/bin:$PATH

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Setup terminal, and turn on colors
export TERM=xterm-color
export LSCOLORS=gxfxcxdxbxegedabagacad
export CLICOLOR=1

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'
 
# Enable color, and better prompt in LESS
export PAGER=less
#export LESS=ce3M
export LESS="-erX"

