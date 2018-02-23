#!/usr/bin/env sh

# Terminate already running bar instances
kill $(pgrep -f powerlinebar\.py)
killall -q powerlinebar.py

# Wait until the processes have been shut down
while pgrep -f powerlinebar\.py >/dev/null; do sleep 1; done


lbfont='LiterationMono Nerd Font:size=10'
# Left
python3 ~/.config/lemonbar/powerlinebar.py DP-0 | \
  lemonbar -f "$lbfont" -g1080x17 &
# Center
python3 ~/.config/lemonbar/powerlinebar.py DVI-I-1 | \
  lemonbar -f "$lbfont" -g1920x16+1080 -o-1 &
# Right
python3 ~/.config/lemonbar/powerlinebar.py HDMI-0 | \
  lemonbar -f "$lbfont" -g1080x17+3000  &

