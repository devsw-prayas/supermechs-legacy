"""Render a preview sheet for a batch of families from data/reports/family_walkthrough.json.

usage: python tools/walk_batch.py <start_n> <count> <out.png>
Each row = one family: label "#n", then every sprite in the family.
"""
import json, sys
from PIL import Image, ImageDraw

start, count, out = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3]
rows = [r for r in json.load(open("data/reports/family_walkthrough.json")) if start <= r["n"] < start + count]
sel = {i["id"]: i for i in json.load(open("data/items_selected.json", encoding="utf8"))["items"]}
H, PAD, LBL = 130, 12, 70
lines = []
for r in rows:
    ims = []
    for sid in r["sprites"]:
        im = Image.open("items/" + sel[sid]["sprite"]).convert("RGBA")
        bb = im.getbbox()
        im = im.crop(bb) if bb else im
        im.thumbnail((260, H - 10), Image.LANCZOS)
        ims.append(im)
    lines.append((r, ims))
W = max(LBL + sum(i.width + PAD for i in ims) for _, ims in lines) + PAD
sheet = Image.new("RGBA", (W, len(lines) * (H + PAD) + PAD), (32, 34, 40, 255))
d = ImageDraw.Draw(sheet)
y = PAD
for r, ims in lines:
    d.text((10, y + H // 2 - 6), f"#{r['n']}", fill=(240, 165, 58, 255))
    x = LBL
    for im in ims:
        sheet.paste(im, (x, y + (H - im.height) // 2), im)
        x += im.width + PAD
    y += H + PAD
sheet.save(out)
print(out)
