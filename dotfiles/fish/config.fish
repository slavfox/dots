set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GHCUP_INSTALL_BASE_PREFIX "~"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx SHELL (which fish)
set -gx BROWSER /usr/bin/firefox

# ipython
set -gx PYTHONSTARTUP ~/dots/scripts/python_startup.py

# virtualenvwrapper
set -gx VIRTUALFISH_HOME "$HOME/.virtualenvs"
set -gx WORKON_HOME "$HOME/.virtualenvs"
set -gx VIRTUALFISH_DEFAULT_PYTHON "python"

set -gx FZF_CTRL_T_COMMAND 'ag --hidden --ignore .git -g ""'

add_to_path ~/bin/ ~/dots/bin/ ~/.local/bin/
add_to_path ~/.cargo/bin/
add_to_path ~/.gem/ruby/*/bin/
add_to_path ~/.npm-global/bin/
add_to_path ~/.cabal/bin/
add_to_path ~/.ghcup/bin/

status --is-interactive; and source (pyenv init -|psub)
source ("/usr/bin/starship" init fish --print-full-init | psub)
