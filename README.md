download repo:
```bash
mkdir -p ~/.config && curl -L https://github.com/eliasbnk/dotfiles/archive/refs/heads/main.zip | bsdtar -xvf- -C ~/.config
```

run init script:
```bash
chmod +x ~/.config/init.sh && ~/.config/init.sh
```

run build script:
```bash
~/.config/build.sh
```
