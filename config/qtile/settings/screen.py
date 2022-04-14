from functools import partial

from libqtile import bar, widget
from libqtile.config import Screen
from .colors import *

from Xlib import display as xdisplay

from .lang_widget import KeyboardLang
from .current_layout_char import CurrentLayoutChar

POWERLINE_FONTSIZE = 23
POWERLINE_LEFT = "\ue0b0"
POWERLINE_RIGHT = "\ue0b2"


class ExecFormatter:
    def __init__(self, fmt: str, func):
        self.fmt: str = fmt
        self.func = func

    def format(self, *argv, **argc):
        self.func()
        return self.fmt.format(*argv, **argc)


def make_separator(
    text: str, color=None, fontsize=None, background_obj=None, foreground_obj=None
) -> widget.GenPollText:
    def poll_function(widget, background_obj, foreground_obj):
        widget.background = color
        widget.foreground = color

        if background := getattr(background_obj, "background", None):
            widget.background = background
        if foreground := getattr(foreground_obj, "background", None):
            widget.foreground = foreground
        return text

    sep = widget.GenPollText(
        padding=0,
        fontsize=fontsize,
        update_interval=0.1,
    )

    sep.func = partial(partial(poll_function, sep, background_obj, foreground_obj))
    return sep


def get_screen_count() -> int:
    screen_count = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            if getattr(monitor, "preferred", False) or getattr(
                monitor, "num_preferred", False
            ):
                screen_count += 1
    except Exception as e:
        return 1
    else:
        return screen_count

def make_bar() -> bar.Bar:
    global systray
    status_colors = [gray, black]
    widgets_left = [
        [CurrentLayoutChar(fontsize=32)],
        [widget.GroupBox()],
        [widget.WindowName()],
    ]
    widgets_right = [
        [
            widget.Mpd2(
                font="Source Code Pro",
                status_format="{play_status} {artist} - {title}",
                update_interval=0.2,
            )
        ],
        [
            widget.TextBox("🔊", fontsize=18, padding=5),
            widget.PulseVolume(
                step=5,
            ),
        ],
        [widget.Net(format="{total}")],
        # [
        #     widget.Memory(
        #         format="{MemUsed: .1f}/{MemTotal:.0f}{mm}",
        #         measure_mem="G",
        #     )
        # ],
        [
            widget.Battery(
                charge_char="🔌",
                discharge_char="🔋",
                unknown_char="🔋",
                update_interval=15,
                notify_below=30 if not systray else None,
                low_percentage=0.25,
                low_background=red,
                low_foreground=whiteff,
                format="{char}{percent:2.0%}",
            )
        ],
        # [widget.Clock(format="%d.%m.%Y %H:%M:%S")],
        [widget.Clock(format="%d.%m.%Y")],
        [widget.Clock(format="%H:%M:%S")],
        [KeyboardLang(update_interval=0.5)],
    ]

    if systray is None:
        systray = [
            widget.Systray(
                icon_size=30,
                background=gray,
            )
        ]
        widgets_right.append(systray)

    widgets = []

    ai = -1
    colors = [gray, black]
    for w in widgets_left:
        sep = widget.TextBox(
            text=POWERLINE_LEFT,
            background=colors[(ai + 1) % 2],
            foreground=colors[ai],
            padding=0,
            fontsize=POWERLINE_FONTSIZE,
        )
        widgets.append(sep)
        for w in w:
            w.background = colors[(ai + 1) % 2]
            w.normal_background = colors[(ai + 1) % 2]
            widgets.append(w)
        ai = (ai + 1) % 2

    for ws in widgets_right:
        sep = widget.TextBox(
            text=POWERLINE_RIGHT,
            background=colors[ai],
            foreground=colors[(ai + 1) % 2],
            padding=0,
            fontsize=POWERLINE_FONTSIZE,
        )

        widgets.append(sep)

        widgets_block_start = len(widgets)

        for w in ws:
            w.background = colors[(ai + 1) % 2]
            w.normal_background = colors[(ai + 1) % 2]
            widgets.append(w)

        for w in ws:
            if type(w) in [widget.Battery]:

                def apply_widget_background(color_widget, widgets, start, end):
                    widgets[start - 1].foreground = color_widget.background
                    for w in widgets[start:end]:
                        w.background = color_widget.background
                    while len(widgets) < end + 1:
                        pass
                    widgets[end].background = color_widget.background

                w.format = ExecFormatter(
                    w.format,
                    partial(
                        apply_widget_background,
                        w,
                        widgets,
                        widgets_block_start,
                        len(widgets),
                    ),
                )

        ai = (ai + 1) % 2

    widgets.append(
        widget.TextBox(
            text=POWERLINE_RIGHT,
            foreground=colors[(ai + 1) % 2],
            background=colors[ai],
            padding=0,
            fontsize=POWERLINE_FONTSIZE,
        )
    )
    return bar.Bar(
        widgets=widgets,
        size=30,
    )


widget_defaults = dict(
    font="Courier Prime Code",
    foreground=white,
    border_normal=black,
    border_focus=gray,
    fontsize=22,
    antialias=True,
    autohint=True,
    padding=0,
)
extension_defaults = widget_defaults.copy()

systray = None

screens = [Screen(top=make_bar()) for _ in range(get_screen_count())][::-1]
