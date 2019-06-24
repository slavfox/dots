set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PATH "$HOME/dots/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$HOME/.gem/ruby/2.5.0/bin" $PATH
set -gx PATH "$HOME/.gem/ruby/2.6.0/bin" $PATH
set -gx PATH $PATH "$HOME/bin"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx SXHKD_SHELL /usr/bin/bash
set -gx SHELL (which fish)
set -gx GTK_THEME "Arc Darker:dark"
set -gx TERMINAL /usr/bin/tilix
set -gx BROWSER /usr/bin/firefox
set -gx GTK_THEME "Arc Darker:dark"
hub alias -s | source

# ipython
set -gx PYTHONSTARTUP $HOME/dots/python_startup.py

# virtualenvwrapper
set -gx VIRTUALFISH_HOME "$HOME/.virtualenvs"
set -gx WORKON_HOME "$HOME/.virtualenvs"
set -gx VIRTUALFISH_DEFAULT_PYTHON "python"
python -m virtualfish | source

# Lorxulang dev
set -gx RPYTHONPATH ~/pypy/rpython
set -gx LORXUPYTHONPATH ~/Lorxu/venv/bin/pypy
