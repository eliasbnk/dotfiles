eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export HOMEBREW_CASK_OPTS="--no-quarantine"


ZSH_THEME="spaceship"
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

export NVM_DIR="$HOME/.nvm"
 [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
 [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Key bindings
bindkey "^[b" backward-word
bindkey "^[f" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# History settings
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Aliases
alias ga="git add"
alias gi="git init"
alias gap="git add -p"
alias buc="brew update && brew upgrade && brew cleanup"
alias connect="~/Developer/scripts/connect.sh"
alias transfer="~/Developer/scripts/transfer.sh"
alias assignment="~/Developer/scripts/new_assignment.sh"
alias lecture="~/Developer/scripts/new_lecture.sh"
alias setup="~/Developer/scripts/setup_college.sh"
alias pip="pip3"
alias python="python3"
alias gss="git status -s"
alias gs="git status -uno"
alias gpo="git push origin master"
alias gpl="git pull"
alias gl="git log"
alias gd="git diff"
alias py="python3"
alias pi="pip3"
alias l="ls"
alias ll="ls -lah"
alias oo="open ."
alias o="open"
alias c="clear"
alias cl="clear"
alias e="exit"
alias vsn="code -n"
alias vs="code ."
alias yar="yarn remove"
alias ys="yarn start"
alias ya="yarn add"
alias yi="yarn init -y"
alias gp="git push"
alias ls="eza --icons"
alias gru="git remote update"
alias logisim="java -jar ~/Developer/tools/logisim310.jar"
alias cd="z"
alias speedtest="speedtest-cli --secure"
alias path="echo -e ${PATH//:/\n}"
alias sp="open -a Spotify"
alias sl="open -a Slack"
alias sett="open -a 'System Preferences'"
alias dd="cd /Users/$(whoami)/Developer/repos"
alias S="sudo"
alias gcb="echo -e '\033[1;32m New branch name?' && read branchname && git checkout -b $branchname"
alias gcc="echo -e '\033[1;32m To what branch do you want to switch?' && read branchname && git checkout $branchname"
alias gc="echo -e '\033[1;32m Link to Repository you want to clone/download?' && read link && cd ~/Developer/repos && git clone $link"
alias app="echo -e '\033[1;32m React App Name?' && read name && cd ~/Developer/repos && npx create-react-app $name && cd $name && code . && npm start"
alias gra="echo -e '\033[1;32m Repository Link?' && read link && git remote add origin $link"
alias gfp="echo -e '\033[1;32m To which Repository-Branch do you want to push?' && read branch && git fetch origin $branch && git push -u origin $branch"
alias gcm="echo -e '\033[1;32m What is your commit message (what have you done, changed, or need to do)?' && read message && git commit -m '$message'"

source /opt/homebrew/opt/spaceship/spaceship.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh