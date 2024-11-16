#!/bin/bash

build-flake
~/.config/setup_vscode.sh
~/.config/setup_ssh_git.sh
nvm install node
nvm use node
unset EMAIL
unset PASSWORD
echo "Setup complete!"
echo "Uncomment out: "
echo -e "\n\n\n# source /opt/homebrew/opt/spaceship/spaceship.zsh\n# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh\n# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh\n
# ZSH_THEME=\"spaceship\"\n# plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)\n# eval \"$(zoxide init zsh)\"\n# eval \"$(fzf --zsh)\"\n"
echo "in ~/.zshrc"
rm ~/.config/build.sh ~/.config/setup_vscode.sh ~/.config/setup_ssh_git.sh
exit 0
