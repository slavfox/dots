# dots

Hi. This is my dotfiles repo, which also doubles as an Ansible setup that lets
me spin up my development environment with a single command:

    curl https://raw.githubusercontent.com/slavfox/dots/master/bootstrap.sh | bash

# Usage

`bootstrap.sh`, by default, installs everything. If you want to modify what
gets installed, clone the repo, install Ansible, and then run 
`./sync.sh -t <TAG_OF_WHATEVER_YOU_WANT_TO_INSTALL>`. All the arguments to
`sync.sh` are passed directly to ansible-playbook.

You may want to edit `group_vars/local` and `local_env.yml`, too.

# Credits

The awesomewm theme bases heavily on Powerarrow Dark, from
[lcpz/awesome-copycats](https://github.com/lcpz/awesome-copycats).

The wallpaper comes from [a post by /u/Leogonnagiveittoyou](https://redd.it/cw8gam)
on Reddit, although that's probably not the original source.

The colorscheme was shamelessly lifted off somewhere, but I can't remember
where. It might be one of the colorschemes from [awesome-copycats](https://github.com/lcpz/dots/tree/master/.colors).
