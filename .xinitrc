#!/bin/sh
#
# ~/.xinitrc
# sushixnyan <sushixnyan@gmail.com> [2014]

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set default cursor
xsetroot -cursor_name left_ptr

# source ~/.Xresources
xrdb -merge ~/.Xresources

# set root background via feh
sh ~/.fehbg &

# start rxvt-unicode daemon
/usr/bin/urxvtd -q -f -o

# start sxhkd
sxhkd &

# set up BSPWM FIFO
export PANEL_FIFO="/tmp/panel-fifo"
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"
exec bspwm
