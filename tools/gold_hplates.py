"""Brighten the Legacy gold-frame armor plates (module_HP11..HP15).

- Frame (#c67700, dusty) -> gold gradient sampled from Plans/Modules/refs/gold-armor-reference.webp.
- Accent lights (#ff9900, flat) -> the physical-element light gradient from Reloaded
  (#ffcc00 -> #ff9a00 -> #ff6600, as on module_resistancePhysical*); frame shifted more orange to match.
- Existing highlight/shadow oranges (#ffb444, #ff6600) are lifted slightly to match.
Everything else is the original art.
"""
import glob, re, cairosvg
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/gold-plates"); OUT.mkdir(parents=True, exist_ok=True)
PLATES = ["HP11", "HP12", "HP13", "HP14", "HP15"]
DEFS = (
    '<linearGradient id="gFrame" x1="0" y1="0" x2="0" y2="1">'
    '<stop offset="0" stop-color="#ffa31a"/><stop offset=".45" stop-color="#e58900"/>'
    '<stop offset="1" stop-color="#b3560a"/></linearGradient>'
    '<linearGradient id="gSheen" x1="0" y1="0" x2="0" y2="1">'
    '<stop offset="0" stop-color="#fff" stop-opacity=".12"/><stop offset=".5" stop-color="#fff" stop-opacity="0"/>'
    '<stop offset="1" stop-color="#000" stop-opacity=".2"/></linearGradient>'
    '<linearGradient id="gAccent" x1="0" y1="0" x2="0" y2="1">'
    '<stop offset="0" stop-color="#ffcc00"/><stop offset=".45" stop-color="#ff9a00"/>'
    '<stop offset="1" stop-color="#ff6600"/></linearGradient>'
)
SWAP = {"#c67700": "url(#gFrame)", "#ff9900": "url(#gAccent)", "#ffb444": "#ffcc00", "#ff6600": "#ff6600",
        # panel greys a touch lighter so the gold pops without looking dusty
        "#666666": "#808080", "#4b4b4b": "#5c5c5c", "#7f7f7f": "#949494", "#8c8c8c": "#a0a0a0"}

def src_of(hp):
    return Path(glob.glob(f"chosen/Modules/*/module_{hp}.svg")[0]).read_text(encoding="utf-8")

def bevel(svg):
    """Give the gold frame a real border: dark outline, top sheen, bright rim and inner lip."""
    def add(m):
        path = m[0]
        dd = re.search(r' d="[^"]*"', path)[0]
        return ('<path' + dd + ' fill="none" stroke="#2a1a02" stroke-width="5" stroke-linejoin="round"/>\n'
                + path + '\n'
                + '<path' + dd + ' fill="none" stroke="#ffcc00" stroke-width="1.6" stroke-opacity=".9" stroke-linejoin="round"/>')
    return re.sub(r'<path[^>]*fill="url\(#gFrame\)"[^>]*/>', add, svg)

def drop_glow(svg):
    """Remove the soft white->orange halo over the square centre light (a radial gradient that
    fades to transparent), leaving a crisp recessed light like the reference."""
    glow_ids = [m[1] for m in re.finditer(r'<radialGradient[^>]*id="(\w+)"[^>]*>(.*?)</radialGradient>', svg, re.S)
                if 'stop-color="#ffffff"' in m[2] and 'stop-opacity="0.0"' in m[2]]
    for gid in glow_ids:
        svg = re.sub(rf'\s*<path[^>]*fill="url\(#{gid}\)"[^>]*/>', "", svg)
    return svg

def silver(svg):
    """Flat steel greys -> Reloaded-style lit gradients, same direction as Platinum Plating:
    darker at the top, lighter at the bottom, centred on the original grey."""
    defs = []
    def repl(m):
        c = m[1].lower()
        v = int(c[1:3], 16)
        if not (c[1:3] == c[3:5] == c[5:7] and 0x40 <= v <= 0xa0):
            return m[0]
        hi, lo = min(v + 0x30, 0xf0), max(v - 0x10, 0x20)
        gid = f"s_{c[1:]}"
        if gid not in defs:
            defs.append(gid)
        return f'fill="url(#{gid})"'
    svg = re.sub(r'fill="(#[0-9a-fA-F]{6})"', repl, svg)
    grads = "".join(
        f'<linearGradient id="{g}" x1="0" y1="1" x2="0" y2="0">'
        f'<stop offset="0" stop-color="#{min(int(g[2:4],16)+0x30,0xf0):02x}{min(int(g[2:4],16)+0x30,0xf0):02x}{min(int(g[2:4],16)+0x30,0xf0):02x}"/>'
        f'<stop offset=".55" stop-color="#{g[2:]}"/>'
        f'<stop offset="1" stop-color="#{max(int(g[2:4],16)-0x10,0x20):02x}{max(int(g[2:4],16)-0x10,0x20):02x}{max(int(g[2:4],16)-0x10,0x20):02x}"/>'
        f'</linearGradient>' for g in defs)
    return svg.replace("<defs>", "<defs>" + grads, 1)

RELOADED_GRILLE = ('<stop offset="0.0" stop-color="#7e7e7e"/><stop offset="0.31" stop-color="#a6a6a6"/>'
                   '<stop offset="0.77" stop-color="#707070"/><stop offset="1.0" stop-color="#696969"/>')

def soft_grilles(svg):
    """The stepped exhaust bars at the bottom (Flash character 71) use a harsh white-stripe
    gradient; swap in the soft steel gradient Reloaded uses on its grille bars (module_HP5)."""
    sprites = set(re.findall(r'characterId="71"[^>]*xlink:href="#(\w+)"', svg))
    shapes = {s for sp in sprites for s in re.findall(r'xlink:href="#(\w+)"', re.search(rf'<g id="{sp}">(.*?)</g>', svg, re.S)[1])}
    grads = {g for sh in shapes for g in re.findall(r'url\(#(\w+)\)', re.search(rf'<g id="{sh}">(.*?)</g>', svg, re.S)[1])}
    for gid in grads:
        svg = re.sub(rf'(<(linear|radial)Gradient[^>]*id="{gid}"[^>]*>).*?(</\2Gradient>)',
                     lambda m: m[1] + RELOADED_GRILLE + m[3], svg, count=1, flags=re.S)
    return svg

def cleanup(svg):
    """Closer to Reloaded: drop the plain grey ball studs (Flash character 60) and the thin
    white 'glass' hairlines on the base plate (the diagonal streaks)."""
    svg = re.sub(r'\s*<use[^>]*characterId="60"[^>]*/>', "", svg)
    base = re.search(r'<g id="shape0">.*?</g>', svg, re.S)[0]
    return svg.replace(base, re.sub(r'\s*<path[^>]*fill="none" stroke="#ffffff"[^>]*/>', "", base))

def shapes_of(svg, char_id):
    sprites = set(re.findall(rf'characterId="{char_id}"[^>]*xlink:href="#(\w+)"', svg))
    return {s for sp in sprites for s in re.findall(r'xlink:href="#(\w+)"', re.search(rf'<g id="{sp}">(.*?)</g>', svg, re.S)[1])}

def gentle(svg):
    """- centre square socket (character 150): smaller (0.5467 -> 0.42 scale), same centre
    - round port rims: softer steel instead of the near-white chrome (#ececec -> #4b4b4b)
    - top accent bars (character 154): Platinum Plating's light gradient (#ff9a00 -> #ff6033)"""
    svg = re.sub(r'(characterId="150"[^>]*transform="matrix\()0\.5467, 0\.0, 0\.0, 0\.5467',
                 r'\g<1>0.42, 0.0, 0.0, 0.42', svg)
    svg = re.sub(r'<stop offset="0\.0" stop-color="#ececec"/>(\s*)<stop offset="1\.0" stop-color="#4b4b4b"/>',
                 r'<stop offset="0.0" stop-color="#b3b3b3"/>\1<stop offset="1.0" stop-color="#626262"/>', svg)
    for sh in shapes_of(svg, 154):
        g = re.search(rf'<g id="{sh}">.*?</g>', svg, re.S)[0]
        svg = svg.replace(g, g.replace('fill="#ff9900"', 'fill="url(#gPlat)"'))
    return svg.replace("<defs>", '<defs><linearGradient id="gPlat" x1="0" y1="0" x2="0" y2="1">'
                       '<stop offset="0" stop-color="#ff9a00"/><stop offset="1" stop-color="#ff6033"/></linearGradient>', 1)

def brighten(svg):
    svg = gentle(cleanup(soft_grilles(drop_glow(svg))))
    svg = re.sub(r'(fill|stop-color)="(#[0-9a-fA-F]{6})"',
                 lambda m: f'{m[1]}="{SWAP.get(m[2].lower(), m[2])}"' if not (m[1] == "stop-color" and SWAP.get(m[2].lower(), "").startswith("url")) else m[0], svg)
    return svg.replace("<defs>", "<defs>" + DEFS, 1) if "<defs>" in svg else svg.replace("</svg>", f"<defs>{DEFS}</defs></svg>")

for hp in PLATES:
    for name, svg in ((f"{hp}_orig", src_of(hp)), (hp, silver(bevel(brighten(src_of(hp)))))):
        (OUT / f"{name}.svg").write_text(svg, encoding="utf-8")
        cairosvg.svg2png(bytestring=svg.encode(), write_to=str(OUT / f"{name}.png"), output_width=512, output_height=512)

sheet = Image.new("RGBA", (len(PLATES) * 270, 540), (44, 44, 48, 255))
for i, hp in enumerate(PLATES):
    for r, name in enumerate((f"{hp}_orig", hp)):
        im = Image.open(OUT / f"{name}.png").convert("RGBA").resize((260, 260), Image.LANCZOS)
        sheet.paste(im, (i * 270 + 5, r * 270 + 5), im)
sheet.save(OUT / "gold-plates.png")
print("ok")
