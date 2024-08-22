import secrets

from libqtile.config import Group, ScratchPad, DropDown, Match


scratchpad_id = "term_" + secrets.token_urlsafe(32)

groups = [
    Group(name="1", label="1"),
    Group(name="2", label="2"),
    Group(name="3", label="3"),
    Group(name="4", label="4"),
    Group(name="5", label="5"),
    Group(name="6", label="6"),
    Group(name="7", label="7"),
    Group(name="8", label="8"),
    Group(name="9", label="9"),
    Group(name="e", label="\ue62b"),  # 
    Group(name="w", spawn="firefox", label="\ue658"),  # 
    Group(name="o", label="\ue650"),  # 
    ScratchPad(
        "scratchpad",
        dropdowns=[
            DropDown(
                "kek",
                f"tabbed -c -n {scratchpad_id} alacritty --embed",
                match=Match(wm_class=[scratchpad_id]),
                opacity=1,
                y=0.05,
                x=0.05,
                height=0.9,
                width=0.9,
                on_focus_lost_hide=True,
                warp_pointer=False,
                ),
            ],
        ),
    ]
