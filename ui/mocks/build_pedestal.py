"""Generate the faceted octagon pedestal SVG and write it into F-bay.html (replaces <svg id="ped">...</svg>).
Run from the repo root:  python ui/mocks/build_pedestal.py
"""
import math, os, re

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = '#05080c'
CX, TOP_Y = 800, 712
BASE = dict(cy=766, rx=306, ry=60, h=50)   # lower tier
TOP = dict(cy=TOP_Y, rx=244, ry=44, h=42)  # upper tier, the mech stands on it


def octo(cx, cy, rx, ry):
    return [(cx + rx * math.cos(math.radians(22.5 + 45 * k)), cy + ry * math.sin(math.radians(22.5 + 45 * k))) for k in range(8)]


def P(pts):
    return 'M' + ' L'.join('%.1f %.1f' % p for p in pts) + ' Z'


def lerp(a, b, t):
    return (a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t)


defs = []


def grad(top, bot):
    n = 'pf%d' % (len(defs) + 1)
    defs.append('<linearGradient id="%s" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="%s"/><stop offset="1" stop-color="%s"/></linearGradient>' % (n, top, bot))
    return 'url(#%s)' % n


def shade(a, b, lvl):
    """Front faces lighter, angled faces darker, like light from the viewer's side."""
    facing = 1 - min(1, abs((a[0] + b[0]) / 2 - CX) / 300)
    dark, light = (0x1a, 0x22, 0x2c), (0x3a, 0x47, 0x58)
    t = (.25 + .75 * facing) * lvl
    c = tuple(int(dark[i] + (light[i] - dark[i]) * t) for i in range(3))
    d = tuple(int(v * .62) for v in c)
    return grad('#%02x%02x%02x' % c, '#%02x%02x%02x' % d)


def tier(cy, rx, ry, h, top, lvl, strip=None, ribs=0):
    pts = octo(CX, cy, rx, ry)
    s = []
    for k in range(8):
        a, b = pts[k], pts[(k + 1) % 8]
        if (a[1] + b[1]) / 2 <= cy + 1:
            continue  # back faces are hidden
        quad = [a, b, (b[0], b[1] + h), (a[0], a[1] + h)]
        s.append('<path d="%s" fill="%s" stroke="%s" stroke-width="4" stroke-linejoin="round"/>' % (P(quad), shade(a, b, lvl), OUT))
        s.append('<path d="M%.1f %.1f L%.1f %.1f" stroke="rgba(200,220,245,.32)" stroke-width="2.5"/>' % (a[0] + 2, a[1] + 4, b[0] - 2, b[1] + 4))
        for r in range(1, ribs + 1):
            p = lerp(a, b, r / (ribs + 1))
            s.append('<path d="M%.1f %.1f L%.1f %.1f" stroke="rgba(0,0,0,.45)" stroke-width="3"/>' % (p[0], p[1] + 8, p[0], p[1] + h - 6))
        if strip:
            y0, y1 = h * .44, h * .64
            q0, q1 = lerp(a, b, .14), lerp(a, b, .86)
            q = [(q0[0], q0[1] + y0), (q1[0], q1[1] + y0), (q1[0], q1[1] + y1), (q0[0], q0[1] + y1)]
            s.append('<path d="%s" fill="%s" stroke="%s" stroke-width="2.5"/>' % (P(q), strip, OUT))
    s.append('<path d="%s" fill="%s" stroke="%s" stroke-width="4" stroke-linejoin="round"/>' % (P(pts), top, OUT))
    s.append('<path d="%s" fill="none" stroke="rgba(0,0,0,.45)" stroke-width="3"/>' % P(octo(CX, cy, rx - 14, ry - 4)))
    front = sorted(p for p in pts if p[1] > cy)
    s.append('<path d="M%s" fill="none" stroke="rgba(200,220,245,.22)" stroke-width="2"/>' % ' L'.join('%.1f %.1f' % (x, y - 3) for x, y in front))
    return s, pts


def support():
    """Hydraulic column under the top tier, two braces and a foot plate on the floor."""
    s = []
    top = TOP['cy'] + TOP['ry'] - 10          # just under the tier's front edge
    foot = 900 + 30                             # runs past the bottom of the screen
    s.append('<ellipse cx="%d" cy="%d" rx="230" ry="30" fill="#000" opacity=".5"/>' % (CX, foot - 60))
    for sgn in (-1, 1):
        x0, x1 = CX + sgn * 190, CX + sgn * 64
        s.append('<path d="M%d %d L%d %d L%d %d L%d %d Z" fill="%s" stroke="%s" stroke-width="4" stroke-linejoin="round"/>'
                 % (x0 - 14, top - 6, x0 + 14, top - 6, x1 + 10 * sgn, foot - 70, x1 - 12 * sgn, foot - 70, grad('#2e3847', '#1a212b'), OUT))
    s.append('<path d="M%d %d L%d %d L%d %d L%d %d Z" fill="%s" stroke="%s" stroke-width="4"/>'
             % (CX - 150, foot - 70, CX + 150, foot - 70, CX + 176, foot, CX - 176, foot, grad('#343f4f', '#1c232d'), OUT))
    cg = 'pf%d' % (len(defs) + 1)
    defs.append('<linearGradient id="%s" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#141a22"/><stop offset=".3" stop-color="#3c4859"/><stop offset=".45" stop-color="#56667c"/><stop offset=".7" stop-color="#2a3341"/><stop offset="1" stop-color="#10151c"/></linearGradient>' % cg)
    s.append('<rect x="%d" y="%d" width="140" height="%d" fill="url(#%s)" stroke="%s" stroke-width="4"/>' % (CX - 70, top, foot - 70 - top, cg, OUT))
    s.append('<rect x="%d" y="%d" width="70" height="40" fill="url(#%s)" stroke="%s" stroke-width="3"/>' % (CX - 35, top - 4, cg, OUT))
    for y in range(top + 44, foot - 70, 28):
        s.append('<rect x="%d" y="%d" width="148" height="9" fill="#1c232d" stroke="%s" stroke-width="3"/>' % (CX - 74, y, OUT))
    s.append('<rect x="%d" y="%d" width="8" height="%d" fill="#ffae2b" stroke="%s" stroke-width="2"/>' % (CX + 44, top + 60, 34, OUT))
    return s


out = support()
t, pts = tier(TOP['cy'], TOP['rx'], TOP['ry'], TOP['h'], grad('#465366', '#2c3645'), 1.0, strip='#ffae2b')
out += t
out.append('<path d="%s" fill="url(#hex)" stroke="%s" stroke-width="3"/>' % (P(octo(CX, TOP_Y, 196, 34)), OUT))
out.append('<path d="%s" fill="none" stroke="#ffae2b" stroke-width="4"/>' % P(octo(CX, TOP_Y, 150, 26)))
out.append('<path d="%s" fill="none" stroke="%s" stroke-width="2"/>' % (P(octo(CX, TOP_Y, 156, 27.5)), OUT))
out.append('<ellipse id="contact" cx="818" cy="716" rx="150" ry="15" fill="#000" opacity=".5"/>')
for (x, y) in pts:
    out.append('<rect x="%.1f" y="%.1f" width="9" height="6" fill="#56697f" stroke="%s" stroke-width="2"/>' % (x - 4.5 + (CX - x) * .08, y - 3 + (TOP_Y - y) * .14, OUT))

# Main pedestal as a reusable group; the side bays reuse it scaled down and dimmed, on a layer behind the side mechs.
import sys
TARGET = sys.argv[1] if len(sys.argv) > 1 else 'F-bay.html'
SIDES = [tuple(map(float, v.split(','))) for v in sys.argv[2:]] or [(282, 702, .5), (1410, 700, .5)]   # (centre x, top y, scale)
svg = ('<svg id="ped" width="1600" height="900" viewBox="0 0 1600 900">\n    <defs>\n'
       '      <pattern id="hex" width="24" height="14" patternUnits="userSpaceOnUse" patternTransform="scale(1,.42)">\n'
       '        <path d="M6 0h12l6 7-6 7H6L0 7z" fill="#1d2530" stroke="#0b0f15" stroke-width="2.5"/>\n      </pattern>\n      '
       + '\n      '.join(defs) + '\n    </defs>\n    <g id="pedMain">\n    ' + '\n    '.join(out) + '\n    </g>\n  </svg>')
side = ('<svg id="pedSide" width="1600" height="900" viewBox="0 0 1600 900">\n'
        + '\n'.join('    <use href="#pedMain" transform="translate(%g %g) scale(%g) translate(%g %g)"/>' % (x, y, k, -CX, -TOP_Y) for x, y, k in SIDES)
        + '\n  </svg>')
p = os.path.join(HERE, TARGET)
s = open(p, encoding='utf-8').read()
s = re.sub(r'<svg id="ped".*?</svg>', lambda m: svg, s, flags=re.S)
if '<svg id="pedSide"' in s:
    s = re.sub(r'<svg id="pedSide".*?</svg>', lambda m: side, s, flags=re.S)
else:
    s = s.replace('<div id="side1"></div>', side + '\n  <div id="side1"></div>', 1)
open(p, 'w', encoding='utf-8').write(s)
print('pedestal written:', len(defs), 'face gradients')
