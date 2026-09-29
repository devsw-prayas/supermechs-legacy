"""Gold (heavy) heat modules, using exactly the same treatments as their energy twins:
- Heavy Cooling Booster   (module_heat101..105): gold side unit     -> tools/gold_energy_booster.py
- Ultimate Heat Engine    (module_heat3/4/5):    gold light steel    -> tools/gold_energy_engine.py
- Heavy Heat Storage Unit (module_heat12/13/14): gold top head only  -> tools/gold_energy_storage.py
"""
import glob, io, re, cairosvg
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/heat"); OUT.mkdir(parents=True, exist_ok=True)

def load(script, stop):
    ns = {}
    exec(open(script).read().split(stop)[0], ns)
    return ns

booster = load("tools/gold_energy_booster.py", "rows = [[], []]")
engine = load("tools/gold_energy_engine.py", "\nfor n in (3, 4, 5):")
storage = load("tools/gold_energy_storage.py", "\nrows = [[], []]")
SETS = [((101, 102, 103, 104, 105), booster["goldify"]),
        ((3, 4, 5), engine["goldify"]),
        ((12, 13, 14), storage["goldify"])]

sheet_rows = []
for nums, fn in SETS:
    pair = [[], []]
    for n in nums:
        src = Path(glob.glob(f"chosen/Modules/*/module_heat{n}.svg")[0]).read_text(encoding="utf-8")
        g = fn(src)
        (OUT / f"heat{n}_gold.svg").write_text(g, encoding="utf-8")
        cairosvg.svg2png(bytestring=g.encode(), write_to=str(OUT / f"heat{n}_gold.png"), output_width=512, output_height=512)
        for r, s in enumerate((src, g)):
            pair[r].append(Image.open(io.BytesIO(cairosvg.svg2png(bytestring=s.encode(), output_width=200, output_height=200))).convert("RGBA"))
    sheet_rows += pair
sheet = Image.new("RGBA", (5 * 210, len(sheet_rows) * 210), (44, 44, 48, 255))
for r, row in enumerate(sheet_rows):
    for i, im in enumerate(row):
        sheet.paste(im, (i * 210 + 5, r * 210 + 5), im)
sheet.save(OUT / "heat-gold.png")
print("ok")
