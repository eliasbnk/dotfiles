# 1. download repo:
```bash
mkdir -p ~/.config && curl -L https://github.com/eliasbnk/dotfiles/archive/refs/heads/main.zip | bsdtar -xvf- -C ~/.config
```

# 2. run init script:
```bash
chmod +x ~/.config/init.sh && ~/.config/init.sh
```

# 3. ( in new terminal window, **after init script finishes** )run build script :
```bash
~/.config/build.sh
```
