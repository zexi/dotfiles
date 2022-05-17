if [[ -z $DISPLAY && $(tty) == /dev/tty1 && $XDG_SESSION_TYPE == tty ]]; then
  #XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
  XDG_SESSION_TYPE=wayland dbus-run-session gnome-session
  #XDG_SESSION_TYPE=x11 exec gnome-session
fi
