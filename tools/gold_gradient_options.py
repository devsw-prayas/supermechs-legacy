"""Gradient options for the skeleton-plate gold border, shown on module_HP15."""
import re, cairosvg, importlib.util
from pathlib import Path
from PIL import Image, ImageDraw

spec = importlib.util.spec_from_file_location("g", "tools/gold_hplates.py"); g = importlib.util.module_from_spec(spec)
spec.loader.exec_module(g)
OPTIONS = {
    "A Deep gold":     ["#ffd84a", "#f4a90e", "#c47a00"],
    "B Rich amber":    ["#ffc53d", "#e8920a", "#a85c00"],
    "C Bright honey":  ["#ffe066", "#ffbf1f", "#e08a00"],
    "D Burnished":     ["#f2c14e", "#c98a1a", "#7a4a08"],
    "E Metallic band": ["#fff0a0", "#e6a100", "#ffd24a", "#b86e00"],
    "F Sunset":        ["#ffd54f", "#ff9f1a", "#e0590a"],
}
base = g.bevel(g.brighten(g.src_of("HP15")))
tiles = []
for name, stops in OPTIONS.items():
    st = "".join(f'<stop offset="{i/(len(stops)-1):.2f}" stop-color="{c}"/>' for i, c in enumerate(stops))
    svg = re.sub(r'(<linearGradient id="gFrame"[^>]*>).*?(</linearGradient>)', lambda m: m[1] + st + m[2], base, count=1, flags=re.S)
    im = Image.open(__import__("io").BytesIO(cairosvg.svg2png(bytestring=svg.encode(), output_width=280, output_height=280))).convert("RGBA")
    t = Image.new("RGBA", (290, 315), (44, 44, 48, 255)); t.paste(im, (5, 5), im)
    ImageDraw.Draw(t).text((10, 292), name, fill="white"); tiles.append(t)
sheet = Image.new("RGBA", (3 * 290, 2 * 315), (44, 44, 48, 255))
for i, t in enumerate(tiles):
    sheet.paste(t, ((i % 3) * 290, (i // 3) * 315))
sheet.save("Plans/Modules/gold-plates/gradient-options.png")
print("ok")
