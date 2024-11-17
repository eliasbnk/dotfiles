#!/bin/bash


install_rosetta() {
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
  echo ""
  export EMAIL="$email"
  export PASSWORD="$password"
  echo "$PASSWORD" | sudo -S softwareupdate --install-rosetta --agree-to-license
}

install_homebrew() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."

    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Homebrew is already installed."
  fi
}

install_brew_packages() {
  xargs brew install --no-quarantine < $HOME/.config/formulaes.txt
  xargs brew install --no-quarantine --cask <  $HOME/.config/casks.txt
}

apply_zshrc(){
if [ -f $HOME/.zshrc ]; then
    cp $HOME/.zshrc $HOME/.zshrc_backup_$(date +'%Y%m%d%H%M%S')
fi
mv $HOME/.config/zshrc $HOME/.zshrc
source  $HOME/.zshrc
}

setup_ssh_git(){
if [ -f $HOME/.gitconfig ]; then
    cp $HOME/.gitconfig $HOME/.gitconfig_$(date +'%Y%m%d%H%M%S')
fi

cat <<EOF >$HOME/.gitconfig
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
	excludesfile = $HOME/.gitignore_global
EOF
chmod +x $HOME/.config/setup_ssh_git.sh
$HOME/.config/setup_ssh_git.sh
unset EMAIL
unset PASSWORD
}

setup_vscode(){
  chmod +x $HOME/.config/setup_vscode.sh
  $HOME/.config/setup_vscode.sh
}

apply_gitignore(){
if [ -f $HOME/.gitignore_global ]; then
    cp $HOME/.gitignore_global $HOME/.gitignore_global_$(date +'%Y%m%d%H%M%S')
fi
mv $HOME/.config/gitignore_global $HOME/.gitignore_global
}

suppress_login_message(){
if [ ! -f $HOME/.hushlogin ]; then
    touch $HOME/.hushlogin
fi
}


set_system_preferences() {

    # 1. NSGlobalDomain settings
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
    defaults write NSGlobalDomain AppleShowAllFiles -bool true
    defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true
    defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
    defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

    # 2. Clock settings (menu extra)
    defaults write com.apple.menuextra.clock ShowSeconds -bool true
    defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
    defaults write com.apple.menuextra.clock ShowDate -int 1
    defaults write com.apple.menuextra.clock ShowAMPM -bool false
    defaults write com.apple.menuextra.clock Show24Hour -bool true

    # 3. Finder settings
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true

    # 4. Screenshot settings
    defaults write com.apple.screencapture type -string "jpg"
    defaults write com.apple.screencapture location -string "$HOME/Screenshots"
    defaults write com.apple.screencapture disable-shadow -bool true
    defaults write com.apple.screencapture include-date -bool false

    # 5. Screensaver settings
    defaults write com.apple.screensaver askForPasswordDelay -int 1
    defaults write com.apple.screensaver askForPassword -bool true

    # 6. WindowManager settings
    defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

    # 7. Loginwindow settings
    sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

    # 8. Input settings for hitoolbox (Apple Fn key usage)
    defaults write com.apple.HIToolbox AppleFnUsageType -string "Show Emoji & Symbols"

    # 9. Software Update settings
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool true

    # 10. Touch ID Sudo Authentication settings
    sudo defaults write /Library/Preferences/com.apple.security.pam enableSudoTouchIdAuth -bool true

    # 11. Startup chime settings
    sudo nvram SystemAudioVolume=" "

    # 12. Set dock effects and preferences
    defaults write com.apple.dock "mineffect" -string "scale"
    defaults write com.apple.dock "autohide-delay" -float "0.0"
    defaults write com.apple.dock "autohide-time-modifier" -float "0.0"
    defaults write com.apple.dock "show-recents" -bool "false"
    defaults write com.apple.dock "autohide" -bool "true"
    defaults write com.apple.dock "orientation" -string "left"
    defaults write com.apple.dock "mru-spaces" -bool "false"
    defaults write com.apple.dock "showhidden" -bool "false"

    # Clear persistent apps first
    defaults write com.apple.dock persistent-apps -array

    # Read the list of applications from ~/.config/dock_apps.txt
    while IFS= read -r dockItem; do
        # Add each application to the dock (quote $dockItem for paths with spaces)
        defaults write com.apple.dock persistent-apps -array-add \
        "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$dockItem</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    done < "$HOME/.config/dock_apps.txt"  # Path to dock_apps.txt in the ~/.config/ directory


    # Apply changes
    killall Finder
    killall SystemUIServer
    killall Dock
}


self_destruct(){
    rm $HOME/.config/README.md $HOME/.config/LICENSE $HOME/.config/setup_ssh_git.sh $HOME/.config/setup_vscode.sh $HOME/.config/dock_apps.txt $HOME/.config/casks.txt $HOME/.config/formulaes.txt $HOME/.config/init.sh
    exit 0
}

install_rosetta
install_homebrew
install_brew_packages
apply_zshrc
apply_gitignore
suppress_login_message
set_system_preferences
setup_vscode
setup_ssh_git
self_destruct
