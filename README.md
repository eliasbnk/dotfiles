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

The `init.sh` script automates several tasks to prepare your macOS environment:

- **Install Rosetta 2**.
- **Install Homebrew**.
- **Install Brew Packages**: listed in `formulaes.txt` and `casks.txt`.
- **Apply Zsh Configuration**: by replaces your existing `.zshrc` file with the one provided in the repository.
- **Set Up Git Configuration**: configures your Git user details and preferred default branch.
- **Set Up Visual Studio Code**: applies specified settings, themes, and extensions for VSCode.
- **Apply a Global Git Ignore File**: sets up a global `.gitignore` file.
- **Suppress the Login Message**: creates a `.hushlogin` file to suppress terminal login messages.
- **Set System Preferences**: adjusts various default macOS settings.
- **Self-Destruct**: cleans up by removing itself and unnecessary files after execution.
