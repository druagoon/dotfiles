#!/bin/bash

### 恢复 Homebrew 原始仓库 ###

git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git
echo "[homebrew]"
git -C "$(brew --repo)" remote -v && echo

git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core
echo "[homebrew-core]"
git -C "$(brew --repo homebrew/core)" remote -v && echo

git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/caskroom/homebrew-cask
echo "[homebrew-cask]"
git -C "$(brew --repo homebrew/cask)" remote -v && echo

gsed -i '/HOMEBREW_BOTTLE_DOMAIN/d' ~/.oh-my-zsh/custom/blazer.zsh
echo "[homebrew-bottles]"
echo $HOMEBREW_BOTTLE_DOMAIN && echo
