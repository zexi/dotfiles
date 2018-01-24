# dotfiles of mine

## use with nvim

```sh
./dothelper install vim
ln -s ~/.vimrc ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim
```

### complete & goto definitions
```sh
pip install python-language-server
```

## HiDPI & monitor
```sh
# use mons is recommend
yaourt -S mons arandr lxrandr
```

Must install gnome to use ** /usr/lib/gnome-settings-daemon/gsd-sound ** and gnome-tweak-tool manage DPI font scale.

## URxvt
```sh
yaourt -S rxvt-unicode urxvt-perls urxvt-font-size-git
```

## i3wm

```sh
yaourt -S i3-gaps-next-git i3-gnome compton feh i3status-rust-git powerline-fonts ttf-font-awesome-4 rofi \
  fcitx fcitx-configtool fcitx-googlepinyin \
  pamixer pnmixer pavucontrol alsa-utils \
  network-manager-applet \
  xorg-xbacklight \
  bluez bluez-utils blueman pulseaudio-bluetooth
```
### system tray
* network: nm-applet
* bluetooth: blueman-applet
* sound: pnmixer, pavucontrol
* input method: fcitx
