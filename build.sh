#!/bin/bash

build-flake
~/.config/setup_vscode.sh
~/.config/setup_ssh_git.sh
nvm install node
nvm use node
unset EMAIL
unset PASSWORD
echo "Setup complete!"
echo "Uncomment out the first 15 lines in ~/.zshrc"
echo "And then run: source ~/.zshrc"
rm ~/.config/build.sh ~/.config/setup_vscode.sh ~/.config/setup_ssh_git.sh
exit 0
