from libqtile.widget import base
from xkbgroup import XKeyboard

class KeyboardLang(base.ThreadPoolText, base.MarginMixin, base.PaddingMixin):
    def __init__(self, **config):
        super().__init__("", **config)
        self.add_callbacks(
            {
                "Button1": self.cmd_change_layout,
            }
        )
        self.keyboard = XKeyboard()

    def cmd_change_layout(self):
        symbols = self.keyboard.groups_symbols
        self.keyboard.group_symbol = symbols[
                (symbols.index(self.keyboard.group_symbol) + 1) % len(symbols)
                ]

    def poll(self) -> str:
        return self.keyboard.group_symbol
