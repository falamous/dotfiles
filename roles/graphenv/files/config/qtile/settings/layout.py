from typing import List, Tuple, Any

from libqtile import layout
from .colors import black, gray


BORDER_WIDTH = 5

def change_default(defaults: List[Tuple[str, Any, str]], name: str, value: str):
    i = [i for i, d in enumerate(layout.Floating.defaults) if d[0] == name][0]
    defaults[i] = (
        defaults[i][0],
        value,
        defaults[i][2],
    )


change_default(layout.Floating.defaults, "border_focus", gray)
change_default(layout.Floating.defaults, "border_normal", black)
change_default(layout.Floating.defaults, "border_width", 5)

layouts = [
    layout.Columns(
        border_focus=gray,
        border_normal=black,
        border_width=BORDER_WIDTH,
    ),
    layout.Matrix(
        border_focus=gray,
        border_normal=black,
        border_width=BORDER_WIDTH,
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]
