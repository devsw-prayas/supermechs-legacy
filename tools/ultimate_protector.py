"""Ultimate Protector art: the restyled Enhanced Protector (Plans/Modules/resist/<Elem>10.png)
with its element-coloured frame and bars turned standard gold (same gold family as the other
gold items), shading kept. The steel housing stays steel; the shield keeps its element colour,
so the shield is what tells the elements apart. Modelled on the Physical one, whose orange
already reads as gold (user: "do this").
"""
import colorsys
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/resist")
LO, MID, HI = (0x7a, 0x3e, 0x00), (0xe5, 0x89, 0x00), (0xff, 0xcc, 0x00)   # standard gold family

def gold(l):
    a, b, k = (LO, MID, l / .5) if l < .5 else (MID, HI, (l - .5) / .5)
    return tuple(round(x + (y - x) * min(k, 1)) for x, y in zip(a, b))

def element_values(im):
    """Brightness value (as used for the gold) of every element-coloured pixel."""
    px = im.load(); w, h = im.size; out = []
    for y in range(h):
        for x in range(w):
            r, g, b, a = px[x, y]
            if a >= 30:
                hh, ll, ss = colorsys.rgb_to_hls(r / 255, g / 255, b / 255)
                if ss > .35 and ll > .08:
                    out.append(min(1, max(r, g, b) / 255 * 0.85 + ll * 0.3))
    return sorted(out)

def matcher(ref, own):
    """Map this element's brightness percentiles onto the reference (Explosive) ones, so every
    element gets the same gold gradient as the approved Explosive Ultimate Protector."""
    qs = [i / 20 for i in range(21)]
    pick = lambda v, q: v[min(len(v) - 1, int(q * (len(v) - 1)))]
    src, dst = [pick(own, q) for q in qs], [pick(ref, q) for q in qs]
    def f(v):
        for i in range(1, len(src)):
            if v <= src[i] or i == len(src) - 1:
                a, b = src[i - 1], src[i]
                t = 0 if b == a else min(max((v - a) / (b - a), 0), 1)
                return dst[i - 1] + (dst[i] - dst[i - 1]) * t
    return f

def ultimate(im, fit=lambda v: v):
    im = im.copy(); px = im.load(); w, h = im.size
    shield = (int(w * .36), int(h * .125), int(w * .64), int(h * .34))
    bezel = (int(w * .28), int(h * .055), int(w * .72), int(h * .40))     # screen + bezel area    # screen centre: keep the shield
    for y in range(h):
        for x in range(w):
            r, g, b, a = px[x, y]
            if a < 30 or (shield[0] <= x <= shield[2] and shield[1] <= y <= shield[3]):
                continue
            hh, ll, ss = colorsys.rgb_to_hls(r / 255, g / 255, b / 255)
            if ss > .35 and ll > .08:                                     # element colour, not steel
                if bezel[0] <= x <= bezel[2] and bezel[1] <= y <= bezel[3]:
                    # slivers of the frame peeking around the screen bezel -> steel, like the bezel
                    v = round((r + g + b) / 3 * 0.9)
                    px[x, y] = (v, v, v, a)
                    continue
                v = fit(min(1, max(r, g, b) / 255 * 0.85 + ll * 0.3))    # keep light/shadow, matched to Explosive
                px[x, y] = (*gold(v), a)
    return im

def all_shields(im, scale=0.80):
    """Put Reloaded's three-shield group (decompiler PNG of module_resistanceAll5, which renders
    correctly) into the screen at a smaller size: clear the screen's black area, paste the group's
    non-black pixels centred, clipped to that area."""
    import glob
    w, h = im.size
    sx0, sy0, sx1, sy1 = int(w * .30), int(h * .06), int(w * .70), int(h * .38)
    px = im.load()
    black = Image.new("L", im.size, 0); bp = black.load()
    for y in range(sy0, sy1):          # the screen = dark pixels connected in the centre area
        for x in range(sx0, sx1):
            r, g, b, a = px[x, y]
            if max(r, g, b) < 60 or max(r, g, b) - min(r, g, b) > 60:   # black screen or old shield colour
                bp[x, y] = 255
    # keep only the main screen blob: fill holes by taking its bounding box interior below bezel greys
    strict = Image.new("L", im.size, 0); sp = strict.load()
    for y in range(sy0, sy1):
        for x in range(sx0, sx1):
            if max(px[x, y][:3]) < 25: sp[x, y] = 255
    box = strict.getbbox()             # the screen's own black interior
    out = im.copy()
    clear = Image.new("RGBA", im.size, (0, 0, 0, 255))
    # clear the whole octagonal screen (old shields incl. their grey rims), not just dark pixels
    oct_ = Image.new("L", im.size, 0)
    from PIL import ImageDraw
    x0, y0, x1, y1 = box; c = round((x1 - x0) * .2)
    ImageDraw.Draw(oct_).polygon([(x0 + c, y0), (x1 - c, y0), (x1, y0 + c), (x1, y1 - c), (x1 - c, y1),
                                  (x0 + c, y1), (x0, y1 - c), (x0, y0 + c)], fill=255)
    black = oct_
    out.paste(clear, (0, 0), black)
    ref = Image.open(glob.glob("chosen/Modules/*/module_resistanceAll5.png")[0]).convert("RGBA").resize(im.size, Image.LANCZOS)
    rb = ref.crop((int(w * .35), int(h * .20), int(w * .65), int(h * .47)))   # the shield group
    rbp = rb.load(); gm = Image.new("L", rb.size, 0); gp = gm.load()
    for y in range(rb.size[1]):
        for x in range(rb.size[0]):
            r, g, b, a = rbp[x, y]
            if a > 100 and max(r, g, b) > 60: gp[x, y] = 255
    gb = gm.getbbox(); grp = rb.crop(gb); gmask = gm.crop(gb)
    bw, bh = box[2] - box[0], box[3] - box[1]
    k = min(bw * scale / grp.size[0], bh * scale / grp.size[1])
    size = (round(grp.size[0] * k), round(grp.size[1] * k))
    grp, gmask = grp.resize(size, Image.LANCZOS), gmask.resize(size, Image.LANCZOS)
    pos = (box[0] + (bw - size[0]) // 2, box[1] + (bh - size[1]) // 2)
    clip = black.crop((pos[0], pos[1], pos[0] + size[0], pos[1] + size[1]))
    from PIL import ImageChops
    out.paste(grp, pos, ImageChops.multiply(gmask, clip))
    return out

if __name__ == "__main__":
    # One body for all four: the approved Explosive Ultimate Protector. Each element only swaps in
    # its own shield (the screen area from its Enhanced Protector), so every other pixel is identical.
    body = ultimate(Image.open(OUT / "Explosive10.png").convert("RGBA"))
    w, h = body.size
    screen = (int(w * .36), int(h * .125), int(w * .64), int(h * .34))
    tiles = []
    def screen_mask(im):
        """Exact shape of the screen interior: the black area flood-filled from the screen
        centre, plus everything it encloses (the shields). Stops at the bezel."""
        from collections import deque
        W, H = im.size; px = im.load()
        cx, cy = W // 2, round(H * .22)
        seed = next(((x, y) for r in range(W // 4) for x, y in ((cx - r, cy), (cx + r, cy), (cx, cy - r))
                     if max(px[x, y][:3]) < 25), None)
        S = {seed}; q = deque([seed])
        while q:
            x, y = q.popleft()
            for n in ((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)):
                if n not in S and max(px[n][:3]) < 25: S.add(n); q.append(n)
        x0, y0 = min(p[0] for p in S), min(p[1] for p in S)
        x1, y1 = max(p[0] for p in S), max(p[1] for p in S)
        out = set(); q = deque()                      # pixels reachable from the box edge, outside S
        for x in range(x0, x1 + 1):
            for y in (y0, y1):
                if (x, y) not in S: out.add((x, y)); q.append((x, y))
        for y in range(y0, y1 + 1):
            for x in (x0, x1):
                if (x, y) not in S and (x, y) not in out: out.add((x, y)); q.append((x, y))
        while q:
            x, y = q.popleft()
            for n in ((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)):
                if x0 <= n[0] <= x1 and y0 <= n[1] <= y1 and n not in S and n not in out:
                    out.add(n); q.append(n)
        m = Image.new("L", im.size, 0); mp = m.load()
        for y in range(y0, y1 + 1):
            for x in range(x0, x1 + 1):
                if (x, y) not in out: mp[x, y] = 255
        return m
    for e in ("Electric", "Explosive", "Physical", "All"):
        u = body.copy()
        src = Image.open(OUT / f"{e}10.png").convert("RGBA")
        u.paste(src, (0, 0), screen_mask(src))
        # the meter bars and the strip above keep the element colour (read at a glance in battle):
        # copy the element-coloured pixels of that area from the Enhanced Protector
        W, H = src.size; sp = body.load(); m = Image.new("L", src.size, 0); mp = m.load()   # select by the body's gold bars
        for y in range(round(H * .47), round(H * .78)):
            xl, xr = (.33, .67) if y < H * .60 else (.27, .73)     # strip housing is narrower
            for x in range(round(W * xl), round(W * xr)):
                r, g, b, a = sp[x, y]
                hh, ll, ss = colorsys.rgb_to_hls(r / 255, g / 255, b / 255)
                if a > 30 and ss > .15 and ll > .05:          # incl. the soft gold edge pixels
                    mp[x, y] = 255
        from PIL import ImageFilter
        m = m.filter(ImageFilter.MaxFilter(3))          # one more pixel, so no gold rim is left
        u.paste(src, (0, 0), m)
        u.save(OUT / f"Ultimate{e}.png")
        tiles.append(u.resize((300, 300), Image.LANCZOS))
    sheet = Image.new("RGBA", (4 * 310, 310), (44, 44, 48, 255))
    for i, im in enumerate(tiles):
        sheet.paste(im, (i * 310 + 5, 5), im)
    sheet.save(OUT / "ultimate-protectors.png")
    print("ok")
