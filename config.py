def is_arch():
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
AWESOME = ["awesomewm"]
FISH = ["fish"]
GIT = ["git"]
NVIM = ["nvim"]
RANGER = ["ranger"]


# preset combinations
class Presets:

    if is_arch():
        bootstrap = ARCH
    else:
        bootstrap = []

    cli_base = bootstrap + FISH + NVIM
    cli_dev = cli_base + GIT
    cli_full = cli_dev + RANGER


# hosts
class Hosts:
    cozyspace = Presets.cli_full
    inanna = Presets.cli_base
    ishtar = Presets.cli_dev + ["ishtar"]
