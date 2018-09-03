set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PATH "$HOME/dots/bin" $PATH
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx SXHKD_SHELL /usr/bin/bash
set -gx SHELL (which fish)
set -gx GTK_THEME "Arc Darker:dark"
set -gx TERMINAL /usr/bin/tilix
set -gx BROWSER /usr/bin/firefox
eval (hub alias -s)

