#!/bin/bash

SETTINGS_FILE="$HOME/Library/Application Support/Code/User/settings.json"

open -a "Visual Studio Code"


SETTINGS_DIR="$(dirname "$SETTINGS_FILE")"
if [ ! -d "$SETTINGS_DIR" ]; then
    mkdir -p "$SETTINGS_DIR"
fi

if [ ! -f "$SETTINGS_FILE" ]; then
    touch "$SETTINGS_FILE"
fi


mv $HOME/.config/settings.json "$SETTINGS_FILE"
echo "VS Code settings have been updated."


extensions=(
    shyykoserhiy.vscode-spotify
    chakrounanas.turbo-console-log
    pflannery.vscode-versionlens
    shardulm94.trailing-spaces
    wayou.vscode-todo-highlight
    ban.spellright
    pnp.polacode
    streetsidesoftware.code-spell-checker-russian
    rvest.vs-code-prettier-eslint
    ms-python.debugpy
    ziyasal.vscode-open-in-github
    yzhang.markdown-all-in-one
    ghmcadams.lintlens
    zignd.html-css-class-completion
    oderwat.indent-rainbow
    wix.vscode-import-cost
    kisstkondoros.vscode-gutter-preview
    hwencc.html-tag-wrapper
    nicoespeon.hocus-pocus
    dbaeumer.vscode-eslint
    usernamehw.errorlens
    irongeek.vscode-env
    firefox-devtools.vscode-firefox-debug
    paulmolluzzo.convert-css-in-js
    kamikillerto.vscode-colorize
    streetsidesoftware.code-spell-checker
    wmaurer.change-case
    danielpinto8zz6.c-cpp-compile-run
    ms-vscode.cpptools
    aaron-bond.better-comments
    steoates.autoimport
    ferdelamad.styled-snippets
    ms-python.python
    ms-python.vscode-pylance
    esbenp.prettier-vscode
    christian-kohler.path-intellisense
    pkief.material-icon-theme
    xabikos.javascriptsnippets
    pranaygp.vscode-css-peek
    visualstudioexptteam.vscodeintellicode
    jeff-hykin.better-cpp-syntax
    formulahendry.auto-rename-tag
    formulahendry.auto-close-tag
    t7yang.hyper-javascript-snippets
    dsznajder.es7-react-js-snippets
    mikestead.dotenv
    eamodio.gitlens
    amirha.better-comments-2
)

for extension in "${extensions[@]}"; do
    if ! code --install-extension $extension; then
        echo "Error: Failed to install extension $extension." >&2
    fi
done

echo "All extensions have been installed!"
