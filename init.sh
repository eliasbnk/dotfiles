#!/bin/bash

# Prompt user for inputs
read -p "Enter the device name (e.g., macbook-pro) for Nix Flake: " flake_device
export flake_device

read -p "Enter your full name used for GitHub: " fullname
read -p "Enter the email address associated with your GitHub: " email

# Loop until a valid branch name is entered (either "main" or "master")
while true; do
    read -p "Enter your preferred default branch (main/master): " branch
    if [[ "$branch" == "main" || "$branch" == "master" ]]; then
        break  # Exit loop if input is valid
    else
        echo "Invalid input. Please enter 'main' or 'master'."
    fi
done


read -s -p "Password:" password

export EMAIL="$email"
export PASSWORD="$password"

echo "$PASSWORD" | sudo -S chmod +x ~/.config/build.sh ~/.config/setup_ssh_git.sh ~/.config/setup_vscode.sh

# Create required directories
mkdir -p ~/Screenshots ~/College ~/Development ~/dotfiles

# Create .hushlogin to suppress login messages
touch ~/.hushlogin

# Backup the existing .gitconfig if it exists
if [ -f ~/.gitconfig ]; then
    cp ~/.gitconfig ~/.gitconfig_backup_$(date +'%Y%m%d%H%M%S')
fi

# Create .gitconfig
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

# Backup the existing .zshrc if it exists
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc_backup_$(date +'%Y%m%d%H%M%S')
fi

mv ~/.config/zshrc ~/.zshrc
mv ~/.config/gitignore_global ~/.gitignore_global

# Backup existing config files
cp -r ~/.config ~/dotfiles

# Install Rosetta 2 for ARM Macs
echo "$PASSWORD" | sudo -S softwareupdate --install-rosetta --agree-to-license

# Install Xcode Command Line Tools
echo "$PASSWORD" | sudo -S xcode-select --install

# Install Nix package manager
curl -L https://nixos.org/nix/install | sh
echo -e "\nAfter X-Code CLI finishing installing\n"
echo -e "Close this terminal\n"
echo -e "\nOpen a new terminal window and run:\n\n~/.config/build.sh"

rm ~/.config/LICENSE ~/.config/README.md  ~/.config/init.sh
exit 0
