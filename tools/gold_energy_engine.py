"""Gold Energy Engine boxes (module_energy3/4/5) -> Ultimate Energy Engine.

Light steel greys (top plate, side fins, frame trim, corner pieces) turn gold with their
brightness kept; the dark body, the blue energy cells and the hazard stripes stay as they are.
"""
import glob, re, cairosvg
from pathlib import Path

OUT = Path("Plans/Modules/energy")
exec(open("tools/gold_energy_booster.py").read().split("rows = [[], []]")[0])  # gold_of()

def goldify(svg):
    def rep(m):
        c = m[2].lower(); v = int(c[1:3], 16)
        return f'{m[1]}="{gold_of(c)}"' if c[1:3] == c[3:5] == c[5:7] and v >= 0x70 else m[0]
    return re.sub(r'(fill|stop-color)="(#[0-9a-fA-F]{6})"', rep, svg)

for n in (3, 4, 5):
    g = goldify(Path(glob.glob(f"chosen/Modules/*/module_energy{n}.svg")[0]).read_text(encoding="utf-8"))
    (OUT / f"energy{n}_gold.svg").write_text(g, encoding="utf-8")
    cairosvg.svg2png(bytestring=g.encode(), write_to=str(OUT / f"energy{n}_gold.png"), output_width=512, output_height=512)
print("ok")
