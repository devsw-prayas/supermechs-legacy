"""Legacy resistance modules (style B, module_resistance<Elem>6..10) restyled to Reloaded shading.

- Element colour fills (purple/blue/red/orange) -> per-part vertical gradient: lighter top,
  the original colour in the middle, deeper bottom (like Reloaded's lit accents).
- Flat steel greys -> the Reloaded silver gradient used on Tungsten Carbide
  (darker top -> lighter bottom), via silver() from tools/gold_hplates.py.
- PNG export: dark outline, then depth (soft top-down light + light edge shadows),
  then bevels (bright top-left rim, dark bottom-right rim on every part). PNG only.
"""
import colorsys, glob, io, re, sys, cairosvg
sys.path.insert(0, 'tools')
from vector_shields import insert_shields
from pathlib import Path
from PIL import Image, ImageChops, ImageFilter

OUT = Path("Plans/Modules/resist"); OUT.mkdir(parents=True, exist_ok=True)
ns = {}
exec(open("tools/gold_hplates.py").read().split("\nfor hp in PLATES:")[0], ns)
silver = ns["silver"]

def shade(hexcol, f):
    r, g, b = (int(hexcol[i:i + 2], 16) / 255 for i in (1, 3, 5))
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    l = min(max(l * f, 0), 0.92)
    return "#%02x%02x%02x" % tuple(round(v * 255) for v in colorsys.hls_to_rgb(h, l, s))

def accents(svg):
    """Saturated flat fills -> vertical gradient per part."""
    defs = {}
    def rep(m):
        c = m[1].lower()
        r, g, b = (int(c[i:i + 2], 16) for i in (1, 3, 5))
        if max(r, g, b) - min(r, g, b) < 60 or max(r, g, b) < 0x60:
            return m[0]
        gid = "acc_" + c[1:]
        defs[gid] = (f'<linearGradient id="{gid}" x1="0" y1="0" x2="0" y2="1">'
                     f'<stop offset="0" stop-color="{shade(c, 1.5)}"/><stop offset=".45" stop-color="{c}"/>'
                     f'<stop offset="1" stop-color="{shade(c, 0.5)}"/></linearGradient>')
        return f'fill="url(#{gid})"'
    svg = re.sub(r'fill="(#[0-9a-fA-F]{6})"', rep, svg)
    return svg.replace("<defs>", "<defs>" + "".join(defs.values()), 1)

def outline(im, w=3, col=(22, 22, 26, 255)):
    a = im.getchannel("A").filter(ImageFilter.MaxFilter(w * 2 + 1))
    base = Image.new("RGBA", im.size, col); base.putalpha(a)
    return Image.alpha_composite(base, im)

def render(svg, size):
    im = Image.open(io.BytesIO(cairosvg.svg2png(bytestring=svg.encode(), output_width=size, output_height=size))).convert("RGBA")
    pad = Image.new("RGBA", im.size, (0, 0, 0, 0)); pad.paste(im.resize((int(size * .96),) * 2), (int(size * .02),) * 2)
    return outline(pad, max(2, size // 170))

def lit_stops(svg):
    """Colours already inside gradients: brighten the first stop, deepen the last, so
    existing gradient parts get the same top-light / deep-bottom look."""
    def fix(m):
        stops = re.findall(r'stop-color="(#[0-9a-fA-F]{6})"', m[0])
        if len(stops) < 2:
            return m[0]
        g = m[0].replace(f'stop-color="{stops[0]}"', f'stop-color="{shade(stops[0].lower(), 1.25)}"', 1)
        i = g.rfind(f'stop-color="{stops[-1]}"')
        return g[:i] + f'stop-color="{shade(stops[-1].lower(), 0.7)}"' + g[i + len(f'stop-color="{stops[-1]}"'):]
    return re.sub(r'<(linear|radial)Gradient[^>]*id="gradient\d+".*?</Gradient>', fix, svg, flags=re.S)

def depth(im, top=1.08, bottom=0.86, edge=0.18, blur=4):
    """Reloaded-style depth: vertical light falloff + inner shadow along every part edge."""
    w, h = im.size
    a = im.getchannel("A")
    # 1) vertical light
    grad = Image.linear_gradient("L").resize((w, h))
    rgb = im.convert("RGB")
    lit = Image.eval(grad, lambda v: int(255 * (top + (bottom - top) * v / 255) / top))
    rgb = ImageChops.multiply(rgb, Image.merge("RGB", [lit] * 3))
    rgb = Image.eval(rgb, lambda v: min(255, int(v * top)))
    # 2) inner shadow: edges of dark lines/parts get darker nearby (ambient occlusion feel)
    lum = im.convert("L")
    dark = Image.eval(lum, lambda v: 255 if v < 50 else 0)
    ao = dark.filter(ImageFilter.GaussianBlur(blur))
    shade = Image.eval(ao, lambda v: int(255 - v * edge))
    rgb = ImageChops.multiply(rgb, Image.merge("RGB", [shade] * 3))
    out = rgb.convert("RGBA"); out.putalpha(a)
    return out
def bevel(im, w=2, hi=0.5, lo=0.32):
    """Bevel every part: a bright rim along its top-left edge and a dark rim along its
    bottom-right edge, found from the dark outlines between parts (and the sprite edge)."""
    a = im.getchannel("A")
    lum = im.convert("L")
    dark = ImageChops.lighter(Image.eval(lum, lambda v: 255 if v < 50 else 0), Image.eval(a, lambda v: 255 - v))
    body = ImageChops.invert(dark)
    tl = ImageChops.multiply(ImageChops.offset(dark, w, w), body)       # part edge with dark above-left
    br = ImageChops.multiply(ImageChops.offset(dark, -w, -w), body)     # part edge with dark below-right
    tl, br = tl.filter(ImageFilter.GaussianBlur(0.7)), br.filter(ImageFilter.GaussianBlur(0.7))
    rgb = im.convert("RGB")
    white = Image.new("RGB", im.size, (255, 255, 255))
    rgb = Image.composite(white, rgb, Image.eval(tl, lambda v: int(v * hi)))
    black = Image.new("RGB", im.size, (0, 0, 0))
    rgb = Image.composite(black, rgb, Image.eval(br, lambda v: int(v * lo)))
    out = rgb.convert("RGBA"); out.putalpha(a)
    return out


def window_box(im):
    """Bounding box of the black shield window in the top centre of a rendered sprite."""
    w, h = im.size
    m = Image.new("L", im.size, 0); px = im.load(); mp = m.load()
    for y in range(int(h * .02), int(h * .5)):
        for x in range(int(w * .25), int(w * .75)):
            r, g, b, a = px[x, y]
            if a > 200 and r + g + b < 40:
                mp[x, y] = 255
    return m.getbbox()

_shield_cache = {}
def _shield_bbox(im, area):
    """Bounding box of the coloured shield pixels (plus their rims) inside `area`."""
    px = im.load(); m = Image.new("L", im.size, 0); mp = m.load()
    for y in range(area[1], area[3]):
        for x in range(area[0], area[2]):
            r, g, b, a = px[x, y]
            if a > 200 and max(r, g, b) - min(r, g, b) > 60 and max(r, g, b) > 90:
                mp[x, y] = 255
    return m.getbbox()

def screen_box(im):
    """The screen's black interior: flood-fill black pixels from a black seed near the screen
    centre (the grey bezel stops it), and return the filled region's bounding box."""
    w, h = im.size; px = im.load()
    cx, cy = w // 2, round(h * .22)
    seed = None
    for r in range(0, w // 4):
        for dx, dy in ((-r, 0), (r, 0), (0, -r), (0, r), (-r, -r), (r, -r)):
            x, y = cx + dx, cy + dy
            if 0 <= x < w and 0 <= y < h and max(px[x, y][:3]) < 25:
                seed = (x, y); break
        if seed: break
    if not seed:
        return None
    seen, stack = {seed}, [seed]
    while stack:
        x, y = stack.pop()
        for n in ((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)):
            if n not in seen and 0 <= n[0] < w and 0 <= n[1] < h and max(px[n][:3]) < 25:
                seen.add(n); stack.append(n)
    xs, ys = [p[0] for p in seen], [p[1] for p in seen]
    return (min(xs), min(ys), max(xs) + 1, max(ys) + 1)

def reloaded_shield(im, elem):
    """Swap the Legacy shield for Reloaded's, at the Legacy shield's own size and position.
    - Reloaded art: decompiler PNG of module_resistance<elem>5 (renders correctly).
    - The Reloaded shield group (with rims) is scaled so its coloured area matches the Legacy
      shield's coloured area, then pasted over a cleared (black) screen; the grey bezel stays."""
    w, h = im.size
    key = (elem, w)
    if key not in _shield_cache:
        rl = Image.open(glob.glob(f"chosen/Modules/*/module_resistance{elem}5.png")[0]).convert("RGBA").resize((w, h), Image.LANCZOS)
        wb = screen_box(rl)
        col = _shield_bbox(rl, (wb[0] + 3, wb[1] + 3, wb[2] - 3, wb[3] - 3))                              # coloured faces
        pad = round((col[2] - col[0]) * .12)                    # + their steel rims
        grp = (max(col[0] - pad, wb[0]), max(col[1] - pad, wb[1]), min(col[2] + pad, wb[2]), min(col[3] + pad, wb[3]))
        _shield_cache[key] = (rl.crop(grp), (col[0] - grp[0], col[1] - grp[1], col[2] - col[0], col[3] - col[1]))
    patch, (ox, oy, cw, ch) = _shield_cache[key]
    box = screen_box(im)
    if not box:
        return im
    leg = _shield_bbox(im, (box[0] + 3, box[1] + 3, box[2] - 3, box[3] - 3))                                  # the Legacy shield's coloured area
    if not leg:
        return im
    # fit the whole Reloaded shield group (faces + steel rims) into the Legacy shield's space
    k = min((leg[2] - leg[0]) / patch.size[0], (leg[3] - leg[1]) / patch.size[1])
    patch = patch.resize((round(patch.size[0] * k), round(patch.size[1] * k)), Image.LANCZOS)
    cx, cy = (leg[0] + leg[2]) / 2, (leg[1] + leg[3]) / 2
    pos = (round(cx - (ox + cw / 2) * k), round(cy - (oy + ch / 2) * k))
    # no box: only the old Legacy shield's coloured pixels go black, then the Reloaded shields
    # (non-black pixels only) are laid on top at the same place and size
    out = im.copy(); px = out.load()
    for y in range(leg[1], leg[3]):
        for x in range(leg[0], leg[2]):
            r, g, b, a = px[x, y]
            if a > 200 and max(r, g, b) - min(r, g, b) > 60:
                px[x, y] = (0, 0, 0, a)
    pm = patch.convert("L").point(lambda v: 255 if v > 30 else 0)
    out.paste(patch, pos, ImageChops.multiply(pm, patch.getchannel("A")))
    return out

def restyle(svg):
    return silver(accents(lit_stops(svg)))

if __name__ == "__main__":
    import sys
    elems = sys.argv[1:] or ["All", "Electric", "Explosive", "Physical"]
    rows = []
    for e in elems:
        pair = [[], []]
        for n in range(6, 11):
            src = Path(glob.glob(f"chosen/Modules/*/module_resistance{e}{n}.svg")[0]).read_text(encoding="utf-8")
            new = restyle(src)
            (OUT / f"{e}{n}.svg").write_text(new, encoding="utf-8")
            new = insert_shields(new, e)                       # vector Reloaded shields
            final = lambda size: bevel(depth(render(new, size)))
            final(512).save(OUT / f"{e}{n}.png")
            pair[0].append(render(src, 200)); pair[1].append(final(200))
        rows += pair
    sheet = Image.new("RGBA", (5 * 210, len(rows) * 210), (44, 44, 48, 255))
    for r, row in enumerate(rows):
        for i, im in enumerate(row):
            sheet.paste(im, (i * 210 + 5, r * 210 + 5), im)
    sheet.save(OUT / "resist-restyle.png")
    print("ok")
