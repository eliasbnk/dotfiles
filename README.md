## 1. Download the Repository

```bash
mkdir -p ~/.config && curl -L https://github.com/eliasbnk/dotfiles/archive/refs/heads/main.zip | bsdtar -xvf- -C ~/.config --strip-components=1
```

## 2. Give the Script Execution Permissions

```bash
chmod +x ~/.config/init.sh
```

## 3. Run the Script

```bash
~/.config/init.sh
```

## What the Script Does

The `init.sh` script automates macOS setup:

- **Install Rosetta 2**.
- **Install Homebrew**.
- **Install Brew Packages** from `formulaes.txt` and `casks.txt`.
- **Apply Zsh Configuration**: Replaces `.zshrc`.
- **Set Up Git Configuration**: User details and default branch in `.gitconfig`.
- **Generate SSH Keys for GitHub, and saves them in Keychains**.
- **Set Up Visual Studio Code**: Replaces `settings.json` and installs extensions.
- **Apply a Global Git Ignore**: Sets up `.gitignore_global`.
- **Suppress Login Message**: Creates `.hushlogin`.
- **Replace Dock Apps**: Updates with apps from `dock_apps.txt`.
- **Set System Preferences**: Adjusts macOS default settings.
- **Self-Destruct**: Deletes all the script files.
