"""Armor Plating line (Reloaded module_HP1..HP5, ending in Platinum Plating) plus a gold-frame line.

Gold versions keep the Reloaded art and recolour only the frame:
- FRAME: main frame body -> one vertical gold gradient in the sprite's own 200px space,
  so every frame part shades continuously (no per-part restarts).
- TRIM: edge ticks, top blocks, bottom block: same gradient as the frame; bevel hairlines
  keep their own brightness in gold. No grey gaps, no pieces lighter or darker than the frame.
Line numbers are 1-based SVG lines, found with per-part render maps.
"""
import glob, re, cairosvg
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/armor-line"); OUT.mkdir(parents=True, exist_ok=True)
FRAME = {"HP1": [12], "HP2": [12], "HP3": [12], "HP4": [16], "HP5": [12]}
TRIM = {
    "HP1": [17, 18, 20, 27, 28, 29, 30, 33, 36],
    "HP2": [17, 18, 20, 30, 31, 32, 33, 36, 39],
    "HP3": [18, 19, 21, 29, 30, 31, 32, 38, 41],
    "HP4": [15, 17, 21, 26, 42, 43, 46, 54],
    "HP5": [13, 16, 17, 19, 21, 22, 48, 50, 58],
}
# art fixes applied to both lines. HP4: the centre bar tapered off to the left and stopped
# short of the bottom; make it a straight bar that meets the bottom stub.
FIXES = {}
GOLD = ('<linearGradient id="rGold" gradientUnits="userSpaceOnUse" x1="0" y1="8" x2="0" y2="196">'
        '<stop offset="0" stop-color="#ffd23a"/><stop offset=".5" stop-color="#f2a30c"/>'
        '<stop offset="1" stop-color="#c47400"/></linearGradient>')  # deep gold, not orange

def gold_of(hexcol):
    """Grey -> gold with the same brightness (keeps the art's light/dark bevels)."""
    v = int(hexcol[1:3], 16) / 255
    lo, mid, hi = (0x7a, 0x48, 0x00), (0xf2, 0xa3, 0x0c), (0xff, 0xe6, 0x8a)
    a, b, t = (lo, mid, v / 0.6) if v < 0.6 else (mid, hi, (v - 0.6) / 0.4)
    return "#" + "".join(f"{round(x + (y - x) * min(t, 1)):02x}" for x, y in zip(a, b))

def tint_line(line, defs):
    """Fills -> the shared gold gradient (same colour at the same height everywhere);
    hairline strokes (bevel highlights/shadows) -> gold at their own brightness."""
    line = re.sub(r'fill="(#[0-9a-fA-F]{6}|url\(#gradient\d+\))"', 'fill="url(#rGold)"', line)
    return re.sub(r'stroke="(#[0-9a-fA-F]{6})"', lambda m: f'stroke="{gold_of(m[1])}"', line)

def grey_bolts(line):
    """The frame path also holds the bolt centres as tiny sub-shapes; move those into a
    separate grey path so the bolts stay steel instead of turning gold."""
    m = re.search(r' d="([^"]*)"', line)
    big, small = [], []
    for sub in re.findall(r"M[^M]*", m[1]):
        nums = [float(v) for v in re.findall(r"-?\d+\.?\d*", sub)]
        xs, ys = nums[0::2], nums[1::2]
        (small if 3 < max(xs) - min(xs) < 12 and 3 < max(ys) - min(ys) < 12 else big).append(sub)
    if not small:
        return line
    frame = line.replace(m[0], f' d="{"".join(big)}"')
    bolts = re.sub(r'fill="[^"]*"', 'fill="#8a8a8a"', line.replace(m[0], f' d="{"".join(small)}"'), count=1)
    return frame + "\n" + bolts

def render(svg, name):
    (OUT / f"{name}.svg").write_text(svg, encoding="utf-8")
    cairosvg.svg2png(bytestring=svg.encode(), write_to=str(OUT / f"{name}.png"), output_width=512, output_height=512)

for hp in FRAME:
    src = Path(glob.glob(f"chosen/Modules/*/module_{hp}.svg")[0]).read_text(encoding="utf-8")
    for old, new in FIXES.get(hp, []):
        assert old in src, (hp, old)
        src = src.replace(old, new)
    render(src, f"armor_{hp}")
    L, defs_add = src.split("\n"), []
    for n in FRAME[hp]:
        L[n-1] = grey_bolts(re.sub(r'fill="[^"]*"', 'fill="url(#rGold)"', L[n-1], count=1))
    for n in TRIM[hp]:
        L[n-1] = tint_line(L[n-1], src)
    render("\n".join(L).replace("<defs>", "<defs>" + GOLD + "".join(defs_add), 1), f"armor_{hp}_gold")

# overview sheet: normal line on top, gold line below
c = Image.new("RGBA", (5 * 270, 2 * 270), (44, 44, 48, 255))
for i, hp in enumerate(FRAME):
    for r, suf in enumerate(["", "_gold"]):
        im = Image.open(OUT / f"armor_{hp}{suf}.png").convert("RGBA").resize((260, 260), Image.LANCZOS)
        c.paste(im, (i * 270 + 5, r * 270 + 5), im)
c.save(OUT / "armor-line.png")

# full ladder in one row: normal 1-5, then gold 1-5, numbered as steps
ladder = [f"armor_{hp}" for hp in FRAME] + [f"armor_{hp}_gold" for hp in FRAME]
full = Image.new("RGBA", (len(ladder) * 210, 215), (44, 44, 48, 255))
(OUT / "ladder").mkdir(exist_ok=True)
for i, name in enumerate(ladder):
    im = Image.open(OUT / f"{name}.png").convert("RGBA").resize((200, 200), Image.LANCZOS)
    full.paste(im, (i * 210 + 5, 8), im)
    for ext in ("png", "svg"):
        (OUT / "ladder" / f"{i+1:02d}_{name}.{ext}").write_bytes((OUT / f"{name}.{ext}").read_bytes())
full.save(OUT / "armor-ladder-full.png")
print("ok")
