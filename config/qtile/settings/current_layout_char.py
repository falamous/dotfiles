from libqtile.widget import base
from libqtile import bar, hook

LAYOUT_CHARS = {
        "columns": "@",
        "matrix": "#",
        "max": "M",
        }


class CurrentLayoutChar(base._TextBox):
    """
    Display the name of the current layout of the current group of the screen,
    the bar containing the widget, is on.
    """

    def __init__(self, width=bar.CALCULATED, **config):
        base._TextBox.__init__(self, "", width, **config)

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        layout_id = self.bar.screen.group.current_layout
        self.text = LAYOUT_CHARS[self.bar.screen.group.layouts[layout_id].name]
        self.setup_hooks()

        self.add_callbacks(
            {
                "Button1": qtile.cmd_next_layout,
                "Button2": qtile.cmd_prev_layout,
            }
        )

    def setup_hooks(self):
        def hook_response(layout, group):
            if group.screen is not None and group.screen == self.bar.screen:
                self.text = LAYOUT_CHARS[layout.name]
                self.bar.draw()

        hook.subscribe.layout_change(hook_response)
