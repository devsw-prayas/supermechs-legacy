"""Charge engine restyle (charge7/charge8): flat base + clean bevels.

1. Flatten: every gradient whose stops are all pink/magenta becomes one flat mid pink,
   and the frame greys become one flat grey per part (their gradients averaged).
2. Bevel: an emboss pass over the rendered sprite (light from the top-left) is blended in
   with 'soft light', so every part edge gets a light top-left rim and a dark bottom-right rim.
"""
import colorsys, glob, io, re, cairosvg
from pathlib import Path
from PIL import Image, ImageChops, ImageFilter, ImageOps

OUT = Path("Plans/Charge Engines/restyle"); OUT.mkdir(parents=True, exist_ok=True)

def _hex(c): return tuple(int(c[i:i + 2], 16) for i in (1, 3, 5))

def flatten(svg):
    def rep(m):
        stops = re.findall(r'stop-color="(#[0-9a-fA-F]{6})"', m[0])
        if not stops: return m[0]
        cols = [_hex(c) for c in stops]
        hls = [colorsys.rgb_to_hls(*(v / 255 for v in c)) for c in cols]
        if not all(x[2] > .3 and (x[0] > .85 or x[0] < .03) for x in hls):
            return m[0]                                   # only the pink panel gradients; steel keeps its shading
        # the panel's overall tone: average of the stops, kept at the original saturation
        avg = tuple(sum(c[i] for c in cols) / len(cols) for i in range(3))
        h, l, _ = colorsys.rgb_to_hls(*(v / 255 for v in avg))
        sat = max(x[2] for x in hls)
        pick = tuple(round(v * 255) for v in colorsys.hls_to_rgb(h, l, sat))
        flat = "#%02x%02x%02x" % pick
        return re.sub(r'stop-color="#[0-9a-fA-F]{6}"', f'stop-color="{flat}"', m[0])
    return re.sub(r'<(linear|radial)Gradient.*?</\1Gradient>', rep, svg, flags=re.S)

def bevel(im, strength=0.55, width=3):
    rgb = im.convert("RGB")
    g = ImageOps.grayscale(rgb).filter(ImageFilter.GaussianBlur(width * .5))
    k = ImageFilter.Kernel((3, 3), [-2, -1, 0, -1, 0, 1, 0, 1, 2], scale=1, offset=128)   # light from top-left
    emb = g.filter(k)
    for _ in range(width - 1):
        emb = emb.filter(ImageFilter.GaussianBlur(.6))
    # neutral at 128: add light above, subtract below (no overall brightening)
    up = Image.eval(emb, lambda v: max(0, int((v - 128) * strength)))
    dn = Image.eval(emb, lambda v: max(0, int((128 - v) * strength)))
    lit = ImageChops.subtract(ImageChops.add(rgb, Image.merge("RGB", [up] * 3)), Image.merge("RGB", [dn] * 3))
    out = lit.convert("RGBA"); out.putalpha(im.getchannel("A"))
    return out

def render(svg, size):
    return Image.open(io.BytesIO(cairosvg.svg2png(bytestring=svg.encode(), output_width=size, output_height=size))).convert("RGBA")

if __name__ == "__main__":
    tiles = []
    for n in ("charge7", "charge8"):
        src = Path(glob.glob(f"chosen/Charge Engines/*/{n}.svg")[0]).read_text(encoding="utf-8")
        new = flatten(src)
        (OUT / f"{n}.svg").write_text(new, encoding="utf-8")
        fin = bevel(render(new, 512)); fin.save(OUT / f"{n}.png")
        tiles.append((render(src, 380), fin.resize((380, 380), Image.LANCZOS)))
    o = Image.new("RGBA", (2 * 390 * 2, 390), (44, 44, 48, 255))
    for i, (a, b) in enumerate(tiles):
        o.paste(a, (i * 780 + 5, 5), a); o.paste(b, (i * 780 + 395, 5), b)
    o.save(OUT / "charge-restyle.png")
    print("ok")
