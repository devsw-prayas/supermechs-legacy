"""Dump each exported sprite SVG's viewBox and the placement of its named clips into data/sprite_bounds.json.

Format note (checked on real exports): JPEXS SVGs carry width/height and an outer frame matrix, not a viewBox.

Why: the mech-attachment anchors (mcLeg1, mcSide1, mcTop1, mcTorso, ...) are placements inside the sprite's own
symbol space, but the PNGs we render start at the art's bounds. To place parts exactly we need, per sprite, the
viewBox origin (what the PNG's top-left corresponds to) and where the `itemGfx` art clip sits.

Run from the project root, where extracted/sprites/<era>/svg/*.svg exist:
    python tools/extract_sprite_bounds.py extracted/sprites
Then commit data/sprite_bounds.json.
"""
import json, os, re, sys

root = sys.argv[1] if len(sys.argv) > 1 else "extracted/sprites"
USE = re.compile(r"<use\b[^>]*>")
ID = re.compile(r'\bid="([^"]+)"')
MATRIX = re.compile(r"matrix\(([^)]*)\)")
VIEWBOX = re.compile(r'viewBox="([^"]+)"')
ATTR = lambda name: re.compile(r'\b' + name + r'="([^"]+)"')

out = {}
for era in ("legacy", "reloaded"):
    d = os.path.join(root, era, "svg")
    if not os.path.isdir(d):
        continue
    out[era] = {}
    for f in sorted(os.listdir(d)):
        if not f.endswith(".svg"):
            continue
        s = open(os.path.join(d, f), encoding="utf8").read()
        head = s[: s.find(">", s.find("<svg")) + 1]
        rec = {}
        m = VIEWBOX.search(head)
        if m:
            rec["viewBox"] = [float(x) for x in re.split(r"[ ,]+", m.group(1).strip())]
        # JPEXS frame exports have no viewBox: the whole drawing sits in one outer <g transform="matrix(...)">
        # whose translation is what puts the art's top-left at the PNG's (0,0). split_layers.py ignored it.
        g = re.search(r"<g\s+transform=\"matrix\(([^)]*)\)\"", s[len(head):])
        if g:
            rec["frame"] = [float(x) for x in g.group(1).split(",")]
        for k in ("width", "height"):
            m = ATTR(k).search(head)
            if m:
                rec[k] = m.group(1)
        # every named clip placement (mc* anchors and itemGfx), with its full matrix
        clips = {}
        for tag in USE.findall(s):
            i = ID.search(tag)
            if not i or not (i.group(1).startswith("mc") or i.group(1) == "itemGfx"):
                continue
            mm = MATRIX.search(tag)
            if mm:
                clips[i.group(1)] = [float(x) for x in mm.group(1).split(",")]
        rec["clips"] = clips
        out[era][f[:-4]] = rec
    print(era, len(out[era]), "sprites")
os.makedirs("data", exist_ok=True)
json.dump(out, open("data/sprite_bounds.json", "w"), separators=(",", ":"))
print("wrote data/sprite_bounds.json")
