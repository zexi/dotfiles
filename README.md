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

## Terminal
```sh
yaourt -S termite termite-terminfo rxvt-unicode urxvt-perls urxvt-font-size-git
```

## i3wm

```sh
yaourt -S i3-gaps-next-git i3-gnome \
  compton feh i3status-rust-git powerline-fonts ttf-font-awesome-4 rofi \
  fcitx fcitx-configtool fcitx-googlepinyin \
  pamixer pnmixer pavucontrol alsa-utils \
  network-manager-applet \
  xorg-xbacklight \
  bluez bluez-utils blueman pulseaudio-bluetooth pulseaudio-bluetooth-a2dp-gdm-fix \
  shutter deepin-screenshot \
  xfce4-power-manager \
  redshift \
  ydcv
```

### system tray
* network: nm-applet
* bluetooth: blueman-applet
* sound: pnmixer, pavucontrol
* input method: fcitx

### power management
* use xfce4-power-manager

```sh
# lock the screen by i3
xfconf-query -c xfce4-session -p /general/LockCommand -s "i3lock" --create -t string

# update the lock command
xfconf-query -c xfce4-session -p /general/LockCommand -s "light-locker-command -l"
```

### others
* franz5
* electronic-wechat, deepin-wechat, deepin-wine-tim, deepin-wine-thunerspeed
* netease-cloud-music, ieaseMusic
