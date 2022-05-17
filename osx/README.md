```bash
brew install iterm2 scroll-reverser

brew install koekeishiya/formulae/skhd
brew services start skhd

brew install koekeishiya/formulae/yabai
brew services start yabai

brew install neovim zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -s $(pwd)/nvim ~/.config/nvim
```

```bash
ln -s $(pwd)/osx/skhdrc ~/.skhdrc
ln -s $(pwd)/osx/yabairc ~/.yabairc
```

```bash
brew install tmux reattach-to-user-namespace clipy fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

```bash
# appstore
# install easyres to adjust monitor resolution
```
