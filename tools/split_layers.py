"""Split JPEXS SVG sprite exports into idle art, runtime layers and anchor points.

For each extracted/sprites/<era>/svg/<symbol>.svg:
  - <era>/svg_idle/<symbol>.svg: the idle look, with runtime layers (mcGlow/mcColor/mcLight) removed
  - <era>/layers/<symbol>.<layer>.svg: each runtime layer on its own, same canvas
  - <era>/anchors.json: {symbol: {layer: [x, y]}} for mcTorso, mcFire*, mcHandle... (in SVG px)
PNG rendering is done afterwards with ImageMagick.
"""
import os, re, json, sys

RUNTIME = ("mcGlow", "mcColor", "mcLight")
USE = re.compile(r'<use [^>]*id="([^"]+)"[^>]*/>')
MATRIX = re.compile(r'matrix\(([^)]*)\)')

root = sys.argv[1]
for era in ("legacy", "reloaded"):
    src = os.path.join(root, era, "svg")
    idle_dir = os.path.join(root, era, "svg_idle")
    layer_dir = os.path.join(root, era, "layers")
    os.makedirs(idle_dir, exist_ok=True)
    os.makedirs(layer_dir, exist_ok=True)
    anchors, stats = {}, {"files": 0, "with_runtime_layers": 0}
    for f in os.listdir(src):
        if not f.endswith(".svg"):
            continue
        sym = f[:-4]
        s = open(os.path.join(src, f), encoding="utf8").read()
        uses = [(m.group(0), m.group(1)) for m in USE.finditer(s)]
        # only top-level named placements count (child ids like sprite0 are refs, not layer names)
        named = [(tag, name) for tag, name in uses if name.startswith("mc") or name == "itemGfx"]
        for tag, name in named:
            if name not in RUNTIME and name != "itemGfx":
                m = MATRIX.search(tag)
                if m:
                    a, b, c, d, tx, ty = map(float, m.group(1).split(","))
                    anchors.setdefault(sym, {})[name] = [round(tx, 2), round(ty, 2)]
        runtime = [(t, n) for t, n in named if n in RUNTIME]
        idle = s
        for tag, _ in runtime:
            idle = idle.replace(tag, "")
        open(os.path.join(idle_dir, f), "w", encoding="utf8").write(idle)
        if runtime:
            stats["with_runtime_layers"] += 1
            for keep_tag, keep_name in runtime:
                only = s
                for tag, name in named:
                    if tag != keep_tag:
                        only = only.replace(tag, "")
                open(os.path.join(layer_dir, f"{sym}.{keep_name}.svg"), "w", encoding="utf8").write(only)
        stats["files"] += 1
    json.dump(anchors, open(os.path.join(root, era, "anchors.json"), "w"), indent=1, sort_keys=True)
    print(era, stats, "anchored symbols:", len(anchors))
