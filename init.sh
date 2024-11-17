#!/bin/bash

install_rosetta() {
  echo "Installing Rosetta 2..."
  sudo softwareupdate --install-rosetta --agree-to-license
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

install_nix() {
  echo "Installing Nix package manager..."
  if ! command -v nix &>/dev/null; then
    curl -L https://nixos.org/nix/install | sh
  else
    echo "Nix is already installed."
  fi
}

clone_dotfiles(){
    mkdir -p ~/.config && curl -L https://github.com/eliasbnk/dotfiles/archive/refs/heads/main.zip | bsdtar -xvf- -C ~/.config --strip-components=1
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
    rm ~/.config/init.sh
    exit 0
}

install_rosetta
install_homebrew
clone_dotfiles
apply_zshrc
apply_gitignore
suppress_login_message
install_nix
self_destruct
