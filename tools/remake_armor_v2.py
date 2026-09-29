"""Reloaded-quality remakes of Legacy armor plates, built on the real Reloaded HP5 vector art.

Base: module_HP5.svg (Reloaded). Legacy signature parts (square core gem, orange frame,
round ports, spine lights) are added in the same palette and bevel style.
Line numbers (L..) refer to parts of module_HP5.svg; see scratch map hp5_parts.png.
"""
import glob, re, cairosvg
from pathlib import Path

BASE = Path(glob.glob("chosen/Modules/*/module_HP5.svg")[0]).read_text(encoding="utf-8").split("\n")
OUT = Path("Plans/Modules/remakes"); OUT.mkdir(parents=True, exist_ok=True)

L_LIGHTS = [41, 42, 43, 44, 45, 46]          # the two orange "L" lights + bezels
VENT_LIT = [23, 24, 25, 52, 53, 54]          # side vent strips (orange)
FRAME = [12]                                  # outer light-grey frame
TOP_BLOCKS = [16]
GRILLES = [51, 55]                            # lower grilles

DEFS = """
<linearGradient id="rOrange" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#ffc04d"/><stop offset=".55" stop-color="#f08a12"/><stop offset="1" stop-color="#b35a00"/></linearGradient>
<linearGradient id="rOrangeDk" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#d98a1c"/><stop offset="1" stop-color="#8a4300"/></linearGradient>
<radialGradient id="rGlow" cx="50%" cy="45%" r="60%"><stop offset=".2" stop-color="#ffd27a"/><stop offset=".55" stop-color="#ff9a00"/><stop offset="1" stop-color="#ff6033"/></radialGradient>
<radialGradient id="rDim" cx="50%" cy="45%" r="60%"><stop offset=".2" stop-color="#9f887a"/><stop offset="1" stop-color="#916251"/></radialGradient>
<radialGradient id="rRivet" cx="35%" cy="30%" r="75%"><stop offset="0" stop-color="#ececec"/><stop offset="1" stop-color="#4b4b4b"/></radialGradient>
"""

def core_gem(cx, cy, s=15):
    """Legacy square core, drawn as a Reloaded bevelled socket."""
    o, i = s, s * 0.55
    q = lambda a, b, c, d: f'<path d="M{a[0]},{a[1]} L{b[0]},{b[1]} L{c[0]},{c[1]} L{d[0]},{d[1]} Z" '
    P = lambda dx, dy: (cx + dx, cy + dy)
    return (f'<rect x="{cx-o-3}" y="{cy-o-3}" width="{2*o+6}" height="{2*o+6}" rx="2" fill="#464646"/>'
            + q(P(-o,-o), P(o,-o), P(i,-i), P(-i,-i)) + 'fill="#bbbbbb"/>'
            + q(P(-o,-o), P(-i,-i), P(-i,i), P(-o,o)) + 'fill="#979797"/>'
            + q(P(o,-o), P(o,o), P(i,i), P(i,-i)) + 'fill="#6e6e6e"/>'
            + q(P(-o,o), P(-i,i), P(i,i), P(o,o)) + 'fill="#555555"/>'
            + f'<rect x="{cx-i-1.5}" y="{cy-i-1.5}" width="{2*i+3}" height="{2*i+3}" fill="#3a3a3a"/>'
            + f'<rect x="{cx-i}" y="{cy-i}" width="{2*i}" height="{2*i}" fill="url(#rGlow)"/>'
            + f'<rect x="{cx-i+1.5}" y="{cy-i+1.2}" width="{2*i-3}" height="1.6" fill="#ffe3b0" opacity=".85"/>')

def port(cx, cy, r=9):
    """Legacy round orange port, Reloaded bolt style."""
    return (f'<circle cx="{cx}" cy="{cy}" r="{r+3}" fill="#464646"/>'
            f'<circle cx="{cx}" cy="{cy}" r="{r+1.5}" fill="url(#rRivet)"/>'
            f'<circle cx="{cx}" cy="{cy}" r="{r*0.62+1}" fill="#3a3a3a"/>'
            f'<circle cx="{cx}" cy="{cy}" r="{r*0.62}" fill="url(#rGlow)"/>'
            f'<circle cx="{cx-r*0.2}" cy="{cy-r*0.25}" r="{r*0.18}" fill="#fff1d6" opacity=".8"/>')

def rivet(cx, cy, r=5):
    return f'<circle cx="{cx}" cy="{cy}" r="{r+1.5}" fill="#464646"/><circle cx="{cx}" cy="{cy}" r="{r}" fill="url(#rRivet)"/>'

def bar(x, y, w=16, h=5):
    return (f'<rect x="{x-1.5}" y="{y-1.5}" width="{w+3}" height="{h+3}" rx="1" fill="#464646"/>'
            f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="url(#rGlow)"/>')

def build(name, hide=(), orange=(), dim=(), extra=""):
    L = list(BASE)
    for n in hide:
        L[n-1] = ""
    for n in orange:
        L[n-1] = re.sub(r'fill="[^"]*"', 'fill="url(#rOrange)"', L[n-1], count=1)
    for n in dim:
        L[n-1] = re.sub(r'fill="[^"]*"', 'fill="url(#rDim)"', L[n-1], count=1)
    s = "\n".join(L)
    s = s.replace("<defs>", "<defs>" + DEFS, 1)
    # extras drawn inside the 200x200 shape space, on top of the base art
    s = s.replace('    </g>\n    <g id="shape0">', '    </g>\n    <g id="shape0">', 1)
    s = re.sub(r'(<g id="shape0">.*?)(\n    </g>)', lambda m: m.group(1) + "\n" + extra + m.group(2), s, count=1, flags=re.S)
    (OUT / f"{name}.svg").write_text(s, encoding="utf-8")
    cairosvg.svg2png(bytestring=s.encode(), write_to=str(OUT / f"{name}.png"), output_width=512, output_height=512)

def light(pts, lit=True):
    """Reloaded-style angled light: dark bezel, glowing fill, thin top highlight."""
    d = "M" + " L".join(f"{x},{y}" for x, y in pts) + " Z"
    return (f'<path d="{d}" fill="#464646" stroke="#464646" stroke-width="5" stroke-linejoin="round"/>'
            f'<path d="{d}" fill="#5a5858" stroke="#5a5858" stroke-width="2" stroke-linejoin="round"/>'
            f'<path d="{d}" fill="url(#{"rGlow" if lit else "rDim"})"/>')

def mirror(pts):
    return [(200 - x, y) for x, y in pts][::-1]

def pair(pts, lit=True):
    return light(pts, lit) + light(mirror(pts), lit)

CHEVRON = [(66, 134), (86, 144), (86, 152), (66, 142)]       # lower angled lights (replace grilles)
SHOULDER = [[(26, 70 + i * 9), (34, 66 + i * 9), (34, 70 + i * 9), (26, 74 + i * 9)] for i in range(3)]
SPINE = [(96, 128), (104, 128), (104, 134), (96, 134)]

# Mk VI: base plate, lights unlit (Legacy HP6: plain)
build("armor_mk6", dim=VENT_LIT + [43, 46])
# Mk VIII: all Reloaded lights on + extra rivets (Legacy HP7/HP8)
build("armor_mk8", extra=rivet(44, 80) + rivet(156, 80))
# Mk XI: orange frame, lower chevron lights replace grilles (Legacy HP9/HP11)
build("armor_mk11", orange=FRAME + TOP_BLOCKS, hide=GRILLES,
      extra=pair(CHEVRON) + rivet(44, 80) + rivet(156, 80))
# Mk XV: orange frame, chevrons, shoulder vents, spine lights (Legacy HP15)
build("armor_mk15", orange=FRAME + TOP_BLOCKS, hide=GRILLES,
      extra=pair(CHEVRON) + "".join(pair(v) for v in SHOULDER)
      + light(SPINE) + light([(x, y + 10) for x, y in SPINE]) + rivet(44, 80) + rivet(156, 80))
print("ok")

# Gold Platinum: untouched Platinum Plating, only the frame recoloured gold
build("armor_gold", orange=FRAME + TOP_BLOCKS)
