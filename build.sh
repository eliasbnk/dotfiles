builf_darwin_flake() {
  echo "Running Nix-Darwin to apply system configuration..."
  nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#macbook-pro
}

apply_zshrc(){
if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile; then
      echo "Updating ~/.zprofile to include Homebrew shell environment."
      cat <<EOF >>~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export HOMEBREW_CASK_OPTS="--no-quarantine"
export NVM_DIR="\$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
EOF
fi
source ~/.zprofile

if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc_backup_$(date +'%Y%m%d%H%M%S')
fi
mv ~/.config/zshrc ~/.zshrc
source  ~/.zshrc
}

setup_ssh_git(){
if [ -f ~/.gitconfig ]; then
    cp ~/.gitconfig ~/.gitconfig_$(date +'%Y%m%d%H%M%S')
fi
read -p "\nEnter your full name used for GitHub: " fullname
read -p "\nEnter the email address associated with your GitHub: " email

# Loop until a valid branch name is entered (either "main" or "master")
while true; do
    read -p "\nEnter your preferred default branch (main/master): " branch
    if [[ "$branch" == "main" || "$branch" == "master" ]]; then
        break  # Exit loop if input is valid
    else
        echo "Invalid input. Please enter 'main' or 'master'."
    fi
done


read -s -p "\nPassword:" password

export EMAIL="$email"
export PASSWORD="$password"

cat <<EOF >~/.gitconfig
[user]
	name = ${fullname}
	email = ${email}
[init]
	defaultBranch = ${branch}
[fetch]
	prune = true

[push]
	default = simple

[color]
	diff = auto
	status = auto
	branch = auto
	ui = true

[core]
	excludesfile = ~/.gitignore_global
EOF
chmod +x ~/.config/setup_ssh_git.sh
~/.config/setup_ssh_git.sh
unset EMAIL
unset PASSWORD
}

setup_vscode(){
  chmod +x ~/.config/setup_vscode.sh
  ~/.config/setup_vscode.sh
}

self_destruct(){
    rm ~/.config/setup_ssh_git.sh ~/.config/setup_vscode.sh ~/.config/build.sh
    exit 0
}


builf_darwin_flake
apply_zshrc
setup_ssh_git
setup_vscode
self_destruct
