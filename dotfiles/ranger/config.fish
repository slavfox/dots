set -gx EDITOR vim
set -gx VISUAL vim
set -gx PATH "$HOME/dots/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH $PATH "$HOME/bin"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx SHELL (which fish)
set -gx BROWSER /usr/bin/firefox
hub alias -s | source

# ipython
set -gx PYTHONSTARTUP ~/dots/python_startup.py

# virtualenvwrapper
set -gx VIRTUALFISH_HOME "$HOME/.virtualenvs"
set -gx WORKON_HOME "$HOME/.virtualenvs"
set -gx VIRTUALFISH_DEFAULT_PYTHON "python"
python -m virtualfish | source
