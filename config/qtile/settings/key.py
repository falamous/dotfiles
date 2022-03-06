from libqtile.config import Click, Drag, Key, ScratchPad
from libqtile.lazy import lazy
from .group import groups
from .system import terminal

mod = "mod4"  # windows key

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key(
        [mod, "shift"], "space", lazy.layout.normalize(), desc="Reset all window sizes"
    ),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key(
        [mod, "shift"], "f", lazy.window.toggle_fullscreen(), desc="Toggle full screen"
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "k", lazy.spawn("xkill"), desc="Spawn xkill"),
    Key([mod], "r", lazy.spawn("flameshot gui"), desc="Take a screenshot"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "p",
        lazy.spawn("rofi -show run"),
        desc="Spawn a command using a prompt widget",
    ),
    Key(
        [mod],
        "c",
        lazy.spawn(
            "rofi -modi 'clipboard:greenclip print'"
            " -show clipboard -run-command '{cmd}'"
        ),
        desc="Choose clipboard entry",
    ),
    # Volume
    Key(
        [mod],
        "equal",
        lazy.widget["pulsevolume"].increase_vol(),
        desc="Increase volume",
    ),
    Key(
        [mod],
        "minus",
        lazy.widget["pulsevolume"].decrease_vol(),
        desc="Decrease volume",
    ),
    Key([mod], "m", lazy.spawn("mpc toggle"), desc="Play/pause music"),
    Key([mod], "n", lazy.spawn("mpc next"), desc="Skip to next track"),
    Key([mod, "shift"], "n", lazy.spawn("mpc prev"), desc="Skip to previous track"),
]

for i in groups:
    if issubclass(type(i), ScratchPad):
        continue
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.label),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )
keys.append(
    Key(
        [mod],
        "grave",
        lazy.group["scratchpad"].dropdown_toggle("kek"),
        desc="Toggle scratchpad",
    )
)

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
