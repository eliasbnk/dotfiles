#!/bin/bash


install_rosetta() {
  echo "Installing Rosetta 2..."
  read -s -p "\nPassword:" password
  export PASSWORD="$password"
  echo "$PASSWORD" | sudo -S softwareupdate --install-rosetta --agree-to-license
}

install_homebrew() {
  echo "Checking for Homebrew..."
  if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."

    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Homebrew is already installed."
  fi
}

install_brew_packages() {
  xargs brew install --no-quarantine < ~/.config/formulaes.txt
  brew tap homebrew/cask-fonts
  xargs brew install --no-quarantine --cask <  ~/.config/casks.txt
}

apply_gitignore(){
if [ -f ~/.gitignore_global ]; then
    cp ~/.gitignore_global ~/.gitignore_global_$(date +'%Y%m%d%H%M%S')
fi
mv ~/.config/gitignore_global ~/.gitignore_global
}

suppress_login_message(){
if [ ! -f ~/.hushlogin ]; then
    touch ~/.hushlogin
fi
}

self_destruct(){
    chmod +x ~/.config/build.sh
    rm ~/.config/init.sh ~/.config/README.md ~/.config/LICENSE
    exit 0
}

install_rosetta
install_homebrew
install_brew_packages
apply_zshrc
apply_gitignore
suppress_login_message
install_nix
self_destruct
