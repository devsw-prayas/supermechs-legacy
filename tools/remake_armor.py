"""Hand-built Reloaded-style remakes of the Legacy 'H' armor plates (module_HP6..HP15)."""
import cairosvg
from pathlib import Path
OUT = Path("Plans/Modules/remakes")

H = "M14,8 L66,8 L76,48 L124,48 L134,8 L186,8 L192,14 L192,148 L168,192 L128,192 L118,156 L82,156 L72,192 L32,192 L8,148 L8,14 Z"

def gem(cx, cy, s=1.0):
    w, h = 26*s, 14*s
    return f'''<g transform="translate({cx},{cy})">
  <path d="M{-w/2-5},0 L{-w/2+3},{-h/2-5} L{w/2-3},{-h/2-5} L{w/2+5},0 L{w/2-3},{h/2+5} L{-w/2+3},{h/2+5} Z" fill="#2a2a2a"/>
  <path d="M{-w/2},0 L{-w/2+5},{-h/2} L{w/2-5},{-h/2} L{w/2},0 L{w/2-5},{h/2} L{-w/2+5},{h/2} Z" fill="url(#glow)"/>
  <path d="M{-w/2+5},{-h/2+2} L{w/2-5},{-h/2+2}" stroke="#ffd9a0" stroke-width="1.5" opacity=".8"/>
</g>'''

def rivet(x, y, r=5):
    return (f'<circle cx="{x}" cy="{y}" r="{r+1.5}" fill="#3a3a3a"/>'
            f'<circle cx="{x}" cy="{y}" r="{r}" fill="url(#rivet)"/>')

def vents(x, y, n=3, w=22):
    return "".join(f'<rect x="{x}" y="{y+i*7}" width="{w}" height="4" rx="1" fill="#4a4a4a"/>'
                   f'<rect x="{x}" y="{y+i*7}" width="{w}" height="1.5" fill="#b5b5b5"/>' for i in range(n))

def lights(x, y, n, vertical=False):
    out = []
    for i in range(n):
        dx, dy = ((0, i*14) if vertical else (i*12, 0))
        out.append(f'<rect x="{x+dx-1}" y="{y+dy-1}" width="{(8 if vertical else 10)+2}" height="{(11 if vertical else 7)+2}" fill="#2a2a2a"/>'
                   f'<rect x="{x+dx}" y="{y+dy}" width="{8 if vertical else 10}" height="{11 if vertical else 7}" fill="url(#glow)"/>')
    return "".join(out)

def plate(name, frame=("#d2d2d2", "#8a8a8a"), extras=""):
    return f'''<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
<defs>
  <clipPath id="c"><path d="{H}"/></clipPath>
  <radialGradient id="panel" cx="50%" cy="40%" r="65%"><stop offset="0" stop-color="#b4b4b4"/><stop offset="1" stop-color="#6c6c6c"/></radialGradient>
  <linearGradient id="frame" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="{frame[0]}"/><stop offset="1" stop-color="{frame[1]}"/></linearGradient>
  <radialGradient id="glow" cx="50%" cy="45%" r="60%"><stop offset="0" stop-color="#ffcf6a"/><stop offset=".55" stop-color="#ff7a1a"/><stop offset="1" stop-color="#c2360a"/></radialGradient>
  <radialGradient id="rivet" cx="35%" cy="30%" r="70%"><stop offset="0" stop-color="#f0f0f0"/><stop offset="1" stop-color="#6a6a6a"/></radialGradient>
</defs>
<path d="{H}" fill="#1c1c1f" stroke="#1c1c1f" stroke-width="6" stroke-linejoin="round"/>
<g clip-path="url(#c)">
  <path d="{H}" fill="url(#panel)"/>
  <path d="M100,56 L100,150 M52,60 L40,140 M148,60 L160,140" stroke="#5a5a5a" stroke-width="2" fill="none"/>
  <path d="M101,56 L101,150 M53,60 L41,140 M149,60 L161,140" stroke="#c8c8c8" stroke-width="1" fill="none" opacity=".6"/>
  <path d="{H}" fill="none" stroke="#3c3c3c" stroke-width="34"/>
  <path d="{H}" fill="none" stroke="url(#frame)" stroke-width="28"/>
  <path d="{H}" fill="none" stroke="#ffffff" stroke-width="3" opacity=".35" transform="translate(0,1)"/>
</g>
{extras}
</svg>'''

base = gem(100, 102, 1.6)
samples = {
    "HP6_remake": plate("HP6", extras=base + rivet(40, 64, 8) + rivet(160, 64, 8)),
    "HP8_remake": plate("HP8", extras=base + rivet(38, 62, 7) + rivet(38, 84, 7) + rivet(162, 62, 7) + rivet(162, 84, 7)
                         + lights(58, 64, 2, True) + lights(136, 64, 2, True)
                         + lights(36, 116, 2) + lights(146, 116, 2) + vents(32, 136, 3, 28) + vents(140, 136, 3, 28)),
    "HP9_remake": plate("HP9", frame=("#ffc15a", "#b0600a"),
                        extras=gem(100, 146, 1.5) + gem(100, 76, 1.1) + rivet(46, 76, 10) + rivet(154, 76, 10)
                        + vents(30, 132, 3, 30) + vents(140, 132, 3, 30)),
    "HP15_remake": plate("HP15", frame=("#ffc15a", "#b0600a"),
                         extras=gem(100, 150, 1.5) + gem(100, 66, 0.9) + gem(100, 88, 0.9) + gem(100, 110, 0.9)
                         + rivet(42, 70, 9) + rivet(158, 70, 9) + rivet(66, 108, 11) + rivet(134, 108, 11)
                         + vents(28, 136, 3, 30) + vents(142, 136, 3, 30)),
}
for k, svg in samples.items():
    (OUT / f"{k}.svg").write_text(svg, encoding="utf-8")
    cairosvg.svg2png(bytestring=svg.encode(), write_to=str(OUT / f"{k}.png"), output_width=400, output_height=400)
print("ok")
