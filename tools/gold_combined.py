"""Gold (Heavy) combined modules, reusing the energy/heat treatment that matches each art style:
- Combined Storage Unit (regularEnergyHeatCap4/5) and Quad Core Booster (superEnergyHeatCapReg4/5):
  engine-box style   -> gold light steel     (tools/gold_energy_engine.py)
- Combined Engine Unit (superEnergyHeatCap4/5): generator style -> gold top head (tools/gold_energy_storage.py)
- Overload Preventor (superEnergyHeatReg4/5): battery-cell style -> gold centre unit
  (the booster's grey list, without its left-half limit, since here the unit sits in the middle)
"""
import glob, io, re, cairosvg
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/combined"); OUT.mkdir(parents=True, exist_ok=True)

def load(script, stop):
    ns = {}
    exec(open(script).read().split(stop)[0], ns)
    return ns

booster = load("tools/gold_energy_booster.py", "\nrows = [[], []]")
engine = load("tools/gold_energy_engine.py", "\nfor n in (3, 4, 5):")
storage = load("tools/gold_energy_storage.py", "\nrows = [[], []]")

def centre_unit(svg):
    gold_of, greys = booster["gold_of"], booster["GREYS"]
    return re.sub(r'fill="(#[0-9a-fA-F]{6})"',
                  lambda m: f'fill="{gold_of(m[1].lower())}"' if m[1].lower() in greys else m[0], svg)

SETS = [("regularEnergyHeatCap", (4, 5), engine["goldify"]),
        ("superEnergyHeatCap", (4, 5), storage["goldify"]),
        ("superEnergyHeatCapReg", (4, 5), engine["goldify"]),
        ("superEnergyHeatReg", (4, 5), centre_unit)]

tiles = []
for base, nums, fn in SETS:
    for n in nums:
        src = Path(glob.glob(f"chosen/Modules/*/module_{base}{n}.svg")[0]).read_text(encoding="utf-8")
        g = fn(src)
        (OUT / f"{base}{n}_gold.svg").write_text(g, encoding="utf-8")
        cairosvg.svg2png(bytestring=g.encode(), write_to=str(OUT / f"{base}{n}_gold.png"), output_width=512, output_height=512)
        tiles.append([Image.open(io.BytesIO(cairosvg.svg2png(bytestring=s.encode(), output_width=200, output_height=200))).convert("RGBA") for s in (src, g)])
sheet = Image.new("RGBA", (len(tiles) * 210, 420), (44, 44, 48, 255))
for i, (a, b) in enumerate(tiles):
    sheet.paste(a, (i * 210 + 5, 5), a); sheet.paste(b, (i * 210 + 5, 215), b)
sheet.save(OUT / "combined-gold.png")
print("ok")
