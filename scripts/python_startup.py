import os

os.environ["PYTHONSTARTUP"] = ""  # Prevent running this again
try:
    import IPython

    IPython.start_ipython()
    raise SystemExit
except ImportError:
    pass
