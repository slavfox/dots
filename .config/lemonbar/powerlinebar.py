#!/usr/bin/env python3
# coding=utf-8
# vim: ai ts=4 sts=4 et sw=4 ft=python
#
# # Released under MIT License
#
# Copyright (c) 2017 Slavfox.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import sys
import time
import subprocess
import json
import psutil

# region constants {{{
SCREEN = sys.argv[1] if len(sys.argv) > 1 else None
HOME = os.getenv("HOME", os.getenv("USERPROFILE"))
WAL_CACHE_DIR = os.path.join(HOME, ".cache", "wal")
COLORSFILE = os.path.join(WAL_CACHE_DIR, "colors")

# Color indices, bitwise OR with BRIGHT to get brighter
BRIGHT = 8
BLACK = 0
RED = 1
GREEN = 2
YELLOW = 3
BLUE = 4
PURPLE = 5
CYAN = 6
WHITE = 7


def get_wal_colors():  # ToDo pass from launch script
    if os.path.isfile(COLORSFILE):
        with open(COLORSFILE) as cf:
            return [line.strip() for line in cf]
    return [
        "#282a2e",
        "#a54242",
        "#8c9440",
        "#de935f",
        "#5f819d",
        "#85678f",
        "#5e8d87",
        "#707880",
        "#373b41",
        "#cc6666",
        "#b5bd68",
        "#f0c674",
        "#81a2be",
        "#b294bb",
        "#8abeb7",
        "#c5c8c6"
    ]


COLOR_PALETTE = get_wal_colors()
# }}} endregion constants


# region lemonbar helpers {{{

class PowerlineBar:
    def __init__(self,
                 left: callable=lambda: [],
                 right: callable=lambda: [],
                 refresh: float=0):
        self.left = left
        self.right = right
        self.refresh = refresh

    @staticmethod
    def colorchange(fg: str=None, bg: str=None):
        """
        Get a lemonbar color change format string.
        :param fg: Foreground color
        :param bg: Background color
        """
        formatstr = ""
        if fg is not None:
            formatstr += "%{{F{}}}".format(fg)
        if bg is not None:
            formatstr += "%{{B{}}}".format(bg)
        return formatstr

    def make_powerline(self, segments: list, right: bool=True):
        """
        Take a list of {"string": str, "colors": (str, str)} dicts, and return
        a properly formatted powerline line.

        :param segments: list[dict["string":str, "colors":(str,str)]] - a list
                         of the segments we want to show.
        :param right: bool: True if we want "a > b > c >", False if
                            "< a < b < c"
        :return: Properly formatted string for lemonbar.
        """
        fullsep = "" if right else ""
        partsep = "" if right else ""

        output = ""

        for i, segment in enumerate(segments):
            if right:
                # If we're going right, we want to display " text >" in each
                # loop rotation, so we need to display the text first:
                output += self.colorchange(
                    fg=segment["colors"][0],
                    bg=segment["colors"][1]
                ) + segment["string"]
                # If this is the last segment, we want to output a final ">"
                # and change the colors to default.
                if i == len(segments) - 1:
                    output += self.colorchange(
                        fg=segment["colors"][1],
                        bg="-"
                    ) + fullsep + self.colorchange(fg="-", bg="-")
                else:
                    # If it's not the last segment, check if the next segment
                    # has the same background color:
                    if segments[i+1]["colors"][1] != segment["colors"][1]:
                        # If it doesn't, output a solid separator with the
                        # left-hand side the same color as the current
                        # segment's bg, and the right-hand side the color of
                        # the next segment's bg.
                        output += self.colorchange(
                            fg=segment["colors"][1],
                            bg=segments[i+1]["colors"][1]
                        ) + fullsep
                    else:
                        # If the next segment has the same bg color, just
                        # output a thin separator (">") with the default fg
                        # color.
                        output += self.colorchange(
                            fg="-",
                            bg=segment["colors"][1]
                        ) + partsep
            else:
                # If we're going from the right side, just do the same thing,
                # but in reverse order.
                if i == 0:
                    output += self.colorchange(
                        fg=segment["colors"][1],
                        bg="-"
                    ) + fullsep
                else:
                    if segments[i-1]["colors"][1] != segment["colors"][1]:
                        output += self.colorchange(
                            fg=segment["colors"][1],
                            bg=segments[i-1]["colors"][1]
                        ) + fullsep
                    else:
                        output += self.colorchange(
                            fg=segment["colors"][0],
                            bg=segment["colors"][1]
                        ) + partsep
                output += self.colorchange(
                    fg=segment["colors"][0],
                    bg=segment["colors"][1]
                ) + segment["string"]
        return output

    def get_left_side(self):
        return self.make_powerline(self.left(), True)

    def get_right_side(self):
        return self.make_powerline(self.right(), False)

    def __str__(self):
        """Return the line for Lemonbar"""
        return '%{{l}}{left}{resetcolors}%{{r}}{right}{resetcolors}'.format(
            left=self.get_left_side(),
            right=self.get_right_side(),
            resetcolors=self.colorchange('-', '-')
        )

    def show(self):
        """Keep showing the bar"""
        while True:
            print(self)
            time.sleep(self.refresh)
# }}} endregion lemonbar helpers


# region bar elements {{{
def get_workspaces_i3():
    json_output = subprocess.run(["i3-msg", "-t", "get_workspaces"],
                                 stdout=subprocess.PIPE)
    if json_output.stdout:
        try:
            loaded = json.loads(json_output.stdout)
        except json.decoder.JSONDecodeError:
            raise ValueError("Incorrect JSON: {}".format(json_output.stdout))
    else:
        return []
    return sorted(
        sorted(loaded,
               key=lambda ws: ws['num']),
        key=lambda ws:ws['focused'],
        reverse=True
    )


def get_cur_screen_workspaces_i3():
    if SCREEN:
        return list(
            filter(lambda ws: ws['output'] == SCREEN, get_workspaces_i3())
        )
    else:
        return get_workspaces_i3()


def i3_workspace_segment(ws: dict):
    """
    Turn a workspace as output by `get_i3_workspaces` into a proper
    powerline segment dict for use by `make_powerline`.
    :param ws: workspace dict from `get_i3_workspaces`
    :return: dict["string": str, "colors": (str, str)] for use by
             `make_powerline`.
    """
    if ":" not in ws['name']:
        ws['name'] = ws['name'] + ': '
    if ws['focused']:
        name = ws['name'].split(':')[1].strip()
        fgcolor = BLACK
        bgcolor = GREEN
    elif ws['visible']:
        name = ''.join(ws['name'].split(':'))
        fgcolor = BLACK
        bgcolor = (RED | BRIGHT) if ws['urgent'] else BLUE
    else:
        name = ''.join(ws['name'].split(':'))
        fgcolor = (RED | BRIGHT) if ws['urgent'] else WHITE
        bgcolor = BLACK
    return {
        "string": " %s " % name,
        "colors": (COLOR_PALETTE[fgcolor], COLOR_PALETTE[bgcolor])
    }


def get_alsa_status():
    """
    Get alsa master status as tuple of:
        volume percentage as int (0..100), and
        mute status as bool (True if on, False if off)

    :return: (int, bool): Tuple of:
                          (alsa Master volume in percent,
                           is Master unmuted)
    """
    amixer = subprocess.run(["amixer", "get", "Master"],
                            stdout=subprocess.PIPE)
    # The last line is formatted like:
    #     Mono: Playback 87 [100%] [0.00dB] [on]
    # And we want the "100" and the "on", so:
    #
    # 1. We `.splitlines()[-1]` to get the last line of the output,
    # 2. We `.split()[3]` to get the "columns"
    last_line = amixer.stdout.splitlines()[-1].split()
    # 3. To get the status, we get the last "column" of the last line ("[on]"),
    # 4. Then check if it's equal to b'[on]'
    status = last_line[-1] == b'[on]'
    # 5. To get the volume, we take the fourth column:
    #        `last_line[3]` -> "[100%]"
    # 6. We want the "100", so we take everything except the last two and
    #    the first character: `s[1:-2]`
    # 7. We now have a bytestring b'100', so we just cast it to `int`.
    volume = int(last_line[3][1:-2])
    return volume, status


def alsa_volume_segment(volume: int, unmuted: bool):
    """
    Get segment representing alsa volume for `make_powerline` from a
    volume percentage and mute status.
    :param volume: int: Volume, in percent.
    :param unmuted: bool: Is the Master channel unmuted
    :return: dict["string": str, "colors": (str, str)] for use by
             `make_powerline`.
    """
    # If we're muted
    if not unmuted:
        return {
            "string": "  muted ",
            "colors": (COLOR_PALETTE[WHITE], COLOR_PALETTE[BLACK | BRIGHT])
        }
    # Else (if we're not muted):
    elif volume == 100:
        icon = ""
        bgcolor = COLOR_PALETTE[BLUE]
    elif volume > 50:
        icon = ""
        bgcolor = COLOR_PALETTE[PURPLE]
    else:
        icon = ""
        bgcolor = COLOR_PALETTE[RED]
    return {
        "string": " {} {}% ".format(icon, volume),
        "colors": (COLOR_PALETTE[BLACK], bgcolor)
    }


def cpu_usage_segment():
    """
    Get segment representing cpu usage for `make_powerline`
    :return: dict["string": str, "colors": (str, str)] for use by
             `make_powerline`.
    """
    stat = subprocess.run(
        'mpstat | '
        'grep -A 5 "%idle" | '
        'tail -n 1 | '
        'awk -F " " \'{print 100 -  $ 12}\'a',
        shell=True,
        stdout=subprocess.PIPE)
    cpu_percent = round(int(stat.stdout))
    fgcolor = COLOR_PALETTE[BLACK]
    if cpu_percent > 90:
        bgcolor = COLOR_PALETTE[RED]
    elif cpu_percent > 50:
        bgcolor = COLOR_PALETTE[YELLOW]
    else:
        bgcolor = COLOR_PALETTE[GREEN]
    return {
        "string": "  {}% ".format(cpu_percent),
        "colors": (fgcolor, bgcolor)
    }


def ram_usage_segment():
    """
    Get segment representing ram usage for `make_powerline`
    :return: dict["string": str, "colors": (str, str)] for use by
             `make_powerline`.
    """
    ram_percent = round(psutil.virtual_memory().percent)
    fgcolor = COLOR_PALETTE[BLACK]
    if ram_percent > 90:
        bgcolor = COLOR_PALETTE[RED]
    elif ram_percent > 50:
        bgcolor = COLOR_PALETTE[YELLOW]
    else:
        bgcolor = COLOR_PALETTE[GREEN]

    return {
        "string": "  {}% ".format(ram_percent),
        "colors": (fgcolor, bgcolor)
    }


def date_time_indicator():
    """
    Get current date and time, prettily formatted
    :return: str with prettily formatted date and time
    """

    return "  {datetime} ".format(
        colorreset=PowerlineBar.colorchange("-", "-"),
        datetime=time.strftime("%Y/%m/%d | %H:%M")
    )


def date_segment():
    """
    Make segment for date
    """
    return {
        "string": "  {date} ".format(
            date=time.strftime("%Y/%m/%d")
        ),
        "colors": (COLOR_PALETTE[WHITE], COLOR_PALETTE[BLACK])
    }

def time_segment():
    """
    Make segment for time
    :return:
    """
    return {
        "string": "  {time} ".format(
            time=time.strftime("%H:%M")
        ),
        "colors": (COLOR_PALETTE[WHITE], COLOR_PALETTE[BLACK])
    }

def spotify_song():
    """
    Get tuple of spotify song/artist
    :return: (str, str)
    """
    reply = subprocess.run(
        "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify "
        "/org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:"
        "'org.mpris.MediaPlayer2.Player' "
        "string:'Metadata'", shell=True, stdout=subprocess.PIPE,
        universal_newlines=True
    ).stdout.splitlines()
    artist = None
    song = None
    # The reply is formatted like:
    #
    #     ...
    #     dict entry(
    #         string "xesam:artist"
    #         variant array [
    #             string "Rick Astley"
    #         ]
    #     )
    #     ...
    #     dict entry(
    #         string "xesam:title"
    #         variant array [
    #             string "Never Gonna Give You Up"
    #         ]
    #     )
    #
    # So, we loop over the lines in the reply;
    i = 0
    while i < len(reply):
        if artist is not None and song is not None:
            break
        # if we find the artist tag
        if artist is None and "xesam:artist" in reply[i]:
            j = 1
            # we look for the next occurence of "string"
            while "string" not in reply[i+j]:
                j += 1
            # and get the stuff between the quotation marks.
            artist = reply[i+j].split(maxsplit=1)[1][1:-1]
            # skip over these lines
            i = i + j
        if song is None and "xesam:title" in reply[i]:
            j = 1
            # we look for the next occurence of "string"
            while "string" not in reply[i+j]:
                j += 1
            # and get the stuff between the quotation marks.
            song = reply[i+j].split(maxsplit=2)[2][1:-1]
            # skip over these lines
            i = i + j
        i += 1
    return artist, song


def spotify_song_segment(spotifytrack: tuple):
    """
    Make a tuple from `spotify_song` into a (left-facing) powerline segment
    """
    output = '  '
    # Song title segment
    if spotifytrack[1] is not None:
        output += spotifytrack[1]
        if spotifytrack[0] is not None:
            output += '  '
    # Artist segment
    if spotifytrack[0] is not None:
        output += spotifytrack[0] + ' '
    return {
        "string": output,
        "colors": (COLOR_PALETTE[WHITE], COLOR_PALETTE[BLACK])
    }

# }}} endregion bar elements



if __name__ == "__main__":
    bar = PowerlineBar(
        left=lambda: list(map(i3_workspace_segment,
                            get_cur_screen_workspaces_i3())),
        right=lambda: [
            time_segment(),
            date_segment(),
            ram_usage_segment(),
            cpu_usage_segment(),
            spotify_song_segment(spotify_song()),
            alsa_volume_segment(*get_alsa_status()),
        ]
    )
    import traceback
    try:
        bar.show()
    except Exception as e:
        with open(os.path.join(HOME, "/pybarcrash.log"), "a") as f:
            f.write("CRASH: ")
            f.write(str(e))
            f.write("\n")
            f.write("TRACEBACK: ")
            f.write(traceback.format_exc())
            f.write("\n\n")
