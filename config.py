def is_arch():
    try:
        with open("/etc/os-release") as f:
            for line in f:
                if line.startswith("ID="):
                    if "arch" in line or "endeavouros" in line:
                        return True
                    return False
    except OSError:
        return False
        
def is_fedora():
    try:
        with open("/etc/os-release") as f:
            for line in f:
                if line.startswith("ID="):
                    if "arch" in line:
                        return True
                    return False
    except OSError:
        return False

ARCH = ["arch-bootstrap"]
FEDORA = []
AWESOME = ["awesomewm"]
FISH = ["fish"]
GIT = ["git"]
NVIM = ["nvim"]
RANGER = ["ranger"]
REMOTE = ["bootstrap-remote"]


# preset combinations
class Presets:

    if is_arch():
        bootstrap = ARCH
        _desktop_extra = ["arch-desktop"]
    elif is_fedora():
        bootstrap = FEDORA
        _desktop_extra = ["fedora-desktop"] 
    else:
        bootstrap = []
        _desktop_extra = []

    cli_base = bootstrap + FISH + NVIM
    cli_dev = cli_base + GIT
    cli_full = cli_dev + RANGER
    remote = REMOTE + cli_dev
    desktop = cli_full + _desktop_extra + ["alacritty", "logiops"]


# hosts
class Hosts:
    cozyspace = Presets.desktop
    inanna = Presets.desktop
    hq = Presets.desktop
    ishtar = Presets.remote + ["ishtar"]
    fedora = Presets.desktop
