autoload -U compinit && compinit
autoload colors && colors
 
source ~/.zsh/setopt.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh

[[ -f ~/.local.zsh ]] && source ~/.local.zsh
