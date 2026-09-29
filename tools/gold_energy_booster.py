"""Gold side unit for the Energy Mass Booster cells (module_energy101..105).

Only the grey steel parts of the left-hand unit (screen housing, box, trims) turn gold, with
their brightness kept; every blue part (casing, side tab, indicator, lightning) stays blue.
Parts are picked by their original grey fill, restricted to paths on the left half.
"""
import glob, re, io, cairosvg
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/energy"); OUT.mkdir(parents=True, exist_ok=True)
GREYS = {"#9f9a9a", "#7f7f7f", "#d2d2d2", "#b1b1b1", "#cccccc", "#777474", "#515151"}

def gold_of(hexcol):
    v = int(hexcol[1:3], 16) / 255
    lo, mid, hi = (0x7a, 0x3e, 0x00), (0xe5, 0x89, 0x00), (0xff, 0xcc, 0x00)   # physical-gold palette
    a, b, t = (lo, mid, v / 0.6) if v < 0.6 else (mid, hi, (v - 0.6) / 0.4)
    return "#" + "".join(f"{round(x + (y - x) * min(t, 1)):02x}" for x, y in zip(a, b))

def goldify(svg):
    out = []
    for line in svg.split("\n"):
        m = re.search(r'<path[^>]* d="([^"]*)"[^>]*fill="(#[0-9a-fA-F]{6})"', line)
        if m and m[2].lower() in GREYS:
            xs = [float(v) for v in re.findall(r"-?\d+\.?\d*", m[1])][0::2]
            if xs and (min(xs) + max(xs)) / 2 < 95:
                line = line.replace(f'fill="{m[2]}"', f'fill="{gold_of(m[2].lower())}"', 1)
        out.append(line)
    return "\n".join(out)

rows = [[], []]
for n in (101, 102, 103, 104, 105):
    src = Path(glob.glob(f"chosen/Modules/*/module_energy{n}.svg")[0]).read_text(encoding="utf-8")
    gold = goldify(src)
    (OUT / f"energy{n}_gold.svg").write_text(gold, encoding="utf-8")
    cairosvg.svg2png(bytestring=gold.encode(), write_to=str(OUT / f"energy{n}_gold.png"), output_width=512, output_height=512)
    for r, s in enumerate((src, gold)):
        rows[r].append(Image.open(io.BytesIO(cairosvg.svg2png(bytestring=s.encode(), output_width=260, output_height=260))).convert("RGBA"))
sheet = Image.new("RGBA", (5 * 270, 540), (44, 44, 48, 255))
for r in range(2):
    for i, im in enumerate(rows[r]):
        sheet.paste(im, (i * 270 + 5, r * 270 + 5), im)
sheet.save(OUT / "booster-gold-test.png")
print("ok")
