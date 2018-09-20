set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PATH "$HOME/dots/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$HOME/.gem/ruby/2.5.0/bin" $PATH
set -gx PATH $PATH "$HOME/bin"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx SXHKD_SHELL /usr/bin/bash
set -gx SHELL (which fish)
set -gx GTK_THEME "Arc Darker:dark"
set -gx TERMINAL /usr/bin/tilix
set -gx BROWSER /usr/bin/firefox
set -gx GTK_THEME "Arc Darker:dark"
eval (hub alias -s)

# virtualenvwrapper
setenv VIRTUALFISH_HOME "$HOME/.virtualenvs"
setenv WORKON_HOME "$HOME/.virtualenvs"
setenv VIRTUALFISH_DEFAULT_PYTHON "python"
eval (python -m virtualfish)
