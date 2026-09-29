"""Hand-drawn gold armor plates, LV1-LV5, in the Reloaded style (drawn from scratch as SVG).

Build: deep-gold bevelled frame -> dark gap -> steel panel -> per-level details.
Frame, gap and panel are the same silhouette inset step by step (miter offset),
so edges stay parallel and every level shares one clean shape.
"""
import math, cairosvg
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/gold-drawn"); OUT.mkdir(parents=True, exist_ok=True)

# ---------- geometry ----------
SHIELD = [(10, 10), (100, 28), (190, 10), (190, 134), (138, 192), (62, 192), (10, 134)]

def area(poly):
    return sum(x1 * y2 - x2 * y1 for (x1, y1), (x2, y2) in zip(poly, poly[1:] + poly[:1])) / 2

def inset(poly, d):
    """Miter offset of a simple polygon, d > 0 moves edges inward."""
    s = 1 if area(poly) > 0 else -1
    n = len(poly)
    lines = []
    for i in range(n):
        (x1, y1), (x2, y2) = poly[i], poly[(i + 1) % n]
        L = math.hypot(x2 - x1, y2 - y1)
        nx, ny = -(y2 - y1) / L * s, (x2 - x1) / L * s   # inward normal
        lines.append(((x1 + nx * d, y1 + ny * d), (x2 + nx * d, y2 + ny * d)))
    out = []
    for i in range(n):
        (p1, p2), (p3, p4) = lines[i - 1], lines[i]
        dx1, dy1 = p2[0] - p1[0], p2[1] - p1[1]
        dx2, dy2 = p4[0] - p3[0], p4[1] - p3[1]
        den = dx1 * dy2 - dy1 * dx2
        t = ((p3[0] - p1[0]) * dy2 - (p3[1] - p1[1]) * dx2) / den
        out.append((p1[0] + dx1 * t, p1[1] + dy1 * t))
    return out

def d(poly):
    return "M" + " L".join(f"{x:.2f},{y:.2f}" for x, y in poly) + " Z"

def lerp(a, b, t):
    return (a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t)

# ---------- shared defs ----------
DEFS = """
<linearGradient id="gold" x1="0" y1="0" x2="0" y2="200" gradientUnits="userSpaceOnUse">
  <stop offset="0" stop-color="#ffd84a"/><stop offset=".45" stop-color="#f4a90e"/><stop offset="1" stop-color="#c47a00"/></linearGradient>
<linearGradient id="goldFace" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0" stop-color="#ffe27a"/><stop offset="1" stop-color="#e59a00"/></linearGradient>
<linearGradient id="sheen" x1="0" y1="0" x2="0" y2="200" gradientUnits="userSpaceOnUse">
  <stop offset="0" stop-color="#fff" stop-opacity=".35"/><stop offset=".5" stop-color="#fff" stop-opacity="0"/>
  <stop offset="1" stop-color="#000" stop-opacity=".18"/></linearGradient>
<radialGradient id="steel" cx="50%" cy="38%" r="70%">
  <stop offset="0" stop-color="#a3a7ac"/><stop offset=".6" stop-color="#7c8086"/><stop offset="1" stop-color="#5c6066"/></radialGradient>
<linearGradient id="steelDark" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0" stop-color="#7b7f85"/><stop offset="1" stop-color="#595d63"/></linearGradient>
<radialGradient id="glow" cx="50%" cy="40%" r="65%">
  <stop offset="0" stop-color="#ffe7a0"/><stop offset=".45" stop-color="#ff9d1c"/><stop offset="1" stop-color="#e2470a"/></radialGradient>
<radialGradient id="bolt" cx="35%" cy="30%" r="75%">
  <stop offset="0" stop-color="#f2f2f2"/><stop offset=".6" stop-color="#9a9da2"/><stop offset="1" stop-color="#55585d"/></radialGradient>
<linearGradient id="grille" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0" stop-color="#d9dbde"/><stop offset=".5" stop-color="#9a9da2"/><stop offset="1" stop-color="#6d7075"/></linearGradient>
"""

# ---------- parts ----------
def frame(outer, width=13):
    inner = inset(outer, width)
    gap = inset(outer, width)
    panel = inset(outer, width + 4)
    ring = d(outer) + " " + d(inner)
    s = [
        f'<path d="{d(outer)}" fill="#1b1407" stroke="#1b1407" stroke-width="5" stroke-linejoin="round"/>',
        f'<path d="{ring}" fill="url(#gold)" fill-rule="evenodd"/>',
        f'<path d="{ring}" fill="url(#sheen)" fill-rule="evenodd"/>',
        # outer rim highlight and inner lip shadow
        f'<path d="{d(inset(outer, 1.6))}" fill="none" stroke="#fff1b0" stroke-width="1.6" opacity=".75"/>',
        f'<path d="{d(inset(outer, width - 1.4))}" fill="none" stroke="#8a5200" stroke-width="2"/>',
        f'<path d="{d(gap)}" fill="#1e1f22"/>',
        f'<path d="{d(panel)}" fill="url(#steel)"/>',
        f'<path d="{d(inset(panel, 1))}" fill="none" stroke="#d6d9dc" stroke-width="1.2" opacity=".45"/>',
        # Reloaded-style inner trench running around the panel
        f'<path d="{d(inset(panel, 9))}" fill="none" stroke="#3f4247" stroke-width="3.2" stroke-linejoin="round"/>',
        f'<path d="{d(inset(panel, 10.8))}" fill="none" stroke="#b9bcc0" stroke-width=".9" opacity=".5"/>',
    ]
    # segment notches across the frame, like Reloaded's plated frames
    for i, t in [(0, .5), (1, .5), (3, .12), (3, .9), (6, .1), (6, .88), (4, .5)]:
        a = lerp(outer[i], outer[(i + 1) % len(outer)], t)
        b = lerp(inner[i], inner[(i + 1) % len(inner)], t)
        s.append(f'<path d="M{a[0]:.2f},{a[1]:.2f} L{b[0]:.2f},{b[1]:.2f}" stroke="#8a5200" stroke-width="2.2"/>'
                 f'<path d="M{a[0]+1.3:.2f},{a[1]:.2f} L{b[0]+1.3:.2f},{b[1]:.2f}" stroke="#ffe890" stroke-width="1" opacity=".7"/>')
    return "".join(s), panel

def seam(x1, y1, x2, y2):
    return (f'<path d="M{x1},{y1} L{x2},{y2}" stroke="#55585d" stroke-width="2" stroke-linecap="round"/>'
            f'<path d="M{x1+1.2},{y1} L{x2+1.2},{y2}" stroke="#c9ccd0" stroke-width=".9" opacity=".6"/>')

def bolt(x, y, r=5.5):
    return (f'<circle cx="{x}" cy="{y}" r="{r+2}" fill="#45484d"/>'
            f'<circle cx="{x}" cy="{y}" r="{r}" fill="url(#bolt)"/>'
            f'<circle cx="{x}" cy="{y}" r="{r*.35}" fill="#6a6d72"/>')

def hexlight(cx, cy, w=30, h=13):
    def hx(W, H):
        return (f"M{cx-W/2},{cy} L{cx-W/2+H/2},{cy-H/2} L{cx+W/2-H/2},{cy-H/2} "
                f"L{cx+W/2},{cy} L{cx+W/2-H/2},{cy+H/2} L{cx-W/2+H/2},{cy+H/2} Z")
    return (f'<path d="{hx(w+10, h+10)}" fill="#2a2b2e"/>'
            f'<path d="{hx(w+5, h+5)}" fill="#55585d"/>'
            f'<path d="{hx(w, h)}" fill="url(#glow)"/>'
            f'<path d="M{cx-w/2+h/2+1},{cy-h/2+2} L{cx+w/2-h/2-1},{cy-h/2+2}" stroke="#fff3cf" stroke-width="1.6" opacity=".85"/>')

def poly_light(pts):
    p = "M" + " L".join(f"{x},{y}" for x, y in pts) + " Z"
    return (f'<path d="{p}" fill="#2a2b2e" stroke="#2a2b2e" stroke-width="7" stroke-linejoin="round"/>'
            f'<path d="{p}" fill="#55585d" stroke="#55585d" stroke-width="3" stroke-linejoin="round"/>'
            f'<path d="{p}" fill="url(#glow)"/>')

def mirror(pts):
    return [(200 - x, y) for x, y in pts]

def grille(x, y, w=30, n=2):
    s = f'<rect x="{x-2}" y="{y-2}" width="{w+4}" height="{n*9+2}" rx="2" fill="#3d4045"/>'
    for i in range(n):
        s += f'<rect x="{x}" y="{y+i*9}" width="{w}" height="7" rx="1.5" fill="url(#grille)"/>'
    return s

def vents(x, y, n=3, lit=True, flip=False):
    s = f'<rect x="{x-3}" y="{y-3}" width="16" height="{n*9+4}" rx="2" fill="#2a2b2e"/>'
    for i in range(n):
        yy = y + i * 9
        a, b = (x, yy + 5), (x + 10, yy)
        if flip:
            a, b = (x + 10, yy + 5), (x, yy)
        pts = f"M{a[0]},{a[1]} L{b[0]},{b[1]} L{b[0]},{b[1]+4} L{a[0]},{a[1]+4} Z"
        s += f'<path d="{pts}" fill="{"url(#glow)" if lit else "#6d7075"}"/>'
    return s

def visor(y=14):
    top = [(68, y), (132, y), (142, y + 16), (132, y + 34), (68, y + 34), (58, y + 16)]
    return (f'<path d="{d(top)}" fill="#1b1407" stroke="#1b1407" stroke-width="5" stroke-linejoin="round"/>'
            f'<path d="{d(top)}" fill="url(#goldFace)"/>'
            f'<path d="{d(inset(top, 5))}" fill="#2a2b2e"/>'
            + hexlight(100, y + 17, 42, 10))

# ---------- the five levels ----------
def plate(level):
    body, panel = frame(SHIELD)
    det = []
    if level == 1:
        det += [seam(100, 42, 100, 160), bolt(42, 52), bolt(158, 52), bolt(42, 128), bolt(158, 128),
                hexlight(100, 88), grille(85, 138)]
    elif level == 2:
        det += [seam(100, 42, 100, 166), seam(62, 46, 52, 150), seam(138, 46, 148, 150),
                bolt(40, 52), bolt(160, 52), bolt(40, 92), bolt(160, 92), bolt(40, 132), bolt(160, 132),
                hexlight(100, 78), hexlight(100, 104), grille(85, 142)]
    elif level == 3:
        det += [f'<rect x="80" y="44" width="40" height="112" rx="3" fill="url(#steelDark)"/>',
                seam(80, 44, 80, 156), seam(120, 44, 120, 156), seam(46, 96, 80, 96), seam(120, 96, 154, 96),
                bolt(40, 52), bolt(160, 52), bolt(40, 92), bolt(160, 92), bolt(40, 132), bolt(160, 132),
                hexlight(100, 66, 26, 11), hexlight(100, 88, 26, 11), hexlight(100, 110, 26, 11), grille(85, 138)]
    elif level >= 4:
        L = [(78, 74), (90, 84), (90, 118), (82, 124), (82, 90), (74, 82)]
        det += [f'<path d="M96,40 L104,40 L104,168 L96,168 Z" fill="#3d4045"/>',
                seam(62, 66, 62, 128), seam(138, 66, 138, 128),
                bolt(50, 58), bolt(150, 58), poly_light(L), poly_light(mirror(L)),
                grille(60, 136, 28), grille(112, 136, 28),
                vents(34, 104, 3, level == 5), vents(152, 104, 3, level == 5, True)]
        if level == 5:
            det += [bolt(50, 84), bolt(150, 84), visor()]
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">'
            f'<defs>{DEFS}</defs>{body}{"".join(det)}</svg>')

for lv in range(1, 6):
    svg = plate(lv)
    (OUT / f"gold_armor_lv{lv}.svg").write_text(svg, encoding="utf-8")
    cairosvg.svg2png(bytestring=svg.encode(), write_to=str(OUT / f"gold_armor_lv{lv}.png"), output_width=512, output_height=512)

sheet = Image.new("RGBA", (5 * 330, 330), (44, 44, 48, 255))
for i in range(5):
    im = Image.open(OUT / f"gold_armor_lv{i+1}.png").convert("RGBA").resize((320, 320), Image.LANCZOS)
    sheet.paste(im, (i * 330 + 5, 5), im)
sheet.save(OUT / "gold-drawn.png")
print("ok")
