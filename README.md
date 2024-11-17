# 1. download the repo:
```bash
mkdir -p ~/.config && curl -L https://github.com/eliasbnk/dotfiles/archive/refs/heads/main.zip | bsdtar -xvf- -C ~/.config --strip-components=1
```

# 2. give the script execution permissions:
```bash
chmod +x ~/.config/init.sh
```

# 3. run the script:
```bash
~/.config/init.sh
```
