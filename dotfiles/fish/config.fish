set -gx EDITOR vim
set -gx VISUAL vim
set -gx GHCUP_INSTALL_BASE_PREFIX "~"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx SHELL (which fish)
set -gx BROWSER /usr/bin/firefox
hub alias -s | source

# ipython
set -gx PYTHONSTARTUP /home/fox/dots/python_startup.py

# virtualenvwrapper
set -gx VIRTUALFISH_HOME "$HOME/.virtualenvs"
set -gx WORKON_HOME "$HOME/.virtualenvs"
set -gx VIRTUALFISH_DEFAULT_PYTHON "python"
status --is-interactive; and source (pyenv init -|psub)
source ("/usr/bin/starship" init fish --print-full-init | psub)

