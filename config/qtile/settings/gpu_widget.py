from libqtile.widget import base
from xkbgroup import XKeyboard
import subprocess

class SupergfxGPU(base.ThreadPoolText, base.MarginMixin, base.PaddingMixin):
    """
    A widget to display the current gpu in use with supergxctl.
    """
    gpu_names: dict[str, str]
    gpu_backgrounds: dict[str, str]
    gpu_foregrounds: dict[str, str]
    defaults = [
            ("gpu_names", {}, "Names for different gpu types"),
            ("gpu_backgrounds",  {}, "Background colors for different gpu types"),
            ("gpu_foregrounds",  {}, "Foreground colors for different gpu types"),
            ]
    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(self.defaults)
        self._default_background = self.background
        self._default_foreground = self.foreground

    def _configure(self, qtile, bar):
        if not self._default_background:
            self._default_background = self.background
        if not self._default_foreground:
            self._default_foreground = self.foreground
        base.ThreadPoolText._configure(self, qtile, bar)

    def poll(self) -> str:
        gpu_type = subprocess.check_output(["supergfxctl", "-g"]).decode("ascii").strip()
        self.background = self.gpu_backgrounds.get(gpu_type, self._default_background)
        self.foreground = self.gpu_foregrounds.get(gpu_type, self._default_foreground)
        return self.gpu_names.get(gpu_type, gpu_type)
