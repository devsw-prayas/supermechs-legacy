"""Vector shield swap for the Legacy resistance modules (style B).

The Reloaded shield paths (from module_resistance<Elem>5.svg) are copied into the Legacy SVG,
one Reloaded shield per Legacy shield, each scaled to fit the Legacy shield's box and centred
on it. The Legacy shield parts are removed. Everything stays vector; no pixel cutting.

Parts (1-based SVG line numbers of paths in the Reloaded file; <use> index in the Legacy sprite0):
- Electric/Explosive: Reloaded paths 42-44 (+52 outline) -> Legacy use #6
- Physical: Reloaded paths 50-52 (+53 outline) -> Legacy use #6
- All-element: Reloaded top 50-52, left 53-55, right 56-58 -> Legacy uses #8 (top), #6 (left), #7 (right)
"""
import glob, io, re
import cairosvg
from PIL import Image

N = 512
RELOADED = {
    "single": [[42, 43, 44, 52]],
    "Physical": [[50, 51, 52, 53]],
    "All": [[50, 51, 52], [53, 54, 55], [56, 57, 58]],
}
LEGACY_USES = {"single": [6], "Physical": [6], "All": [8, 6, 7]}     # matched to RELOADED order (top, left, right)

def _svg(name):
    return open(glob.glob(f"chosen/Modules/*/module_resistance{name}.svg")[0], encoding="utf-8").read()

def _px_bbox(svg):
    im = Image.open(io.BytesIO(cairosvg.svg2png(bytestring=svg.encode(), output_width=N, output_height=N))).convert("RGBA")
    return im.getchannel("A").point(lambda a: 255 if a > 40 else 0).getbbox()

def _only_paths(lines, keep):
    return "\n".join(l if (i + 1 in keep or not l.lstrip().startswith("<path")) else "" for i, l in enumerate(lines))

def _coords_bbox(lines, nums):
    xs, ys = [], []
    for n in nums:
        m = re.search(r' d="([^"]*)"', lines[n - 1])
        v = [float(t) for t in re.findall(r"-?\d+\.?\d*", m[1])]
        xs += v[0::2]; ys += v[1::2]
    return min(xs), min(ys), max(xs), max(ys)

def _root_size(svg):
    w = float(re.search(r'<svg[^>]*width="([\d.]+)', svg)[1])
    h = float(re.search(r'<svg[^>]*height="([\d.]+)', svg)[1])
    return w, h

def insert_shields(legacy_svg, elem):
    kind = elem if elem in ("All", "Physical") else "single"
    rsvg = _svg(f"{elem}5")
    rl = rsvg.split("\n")
    # --- Reloaded: shape-coordinate -> pixel mapping, from the first face path of the first shield
    ref = RELOADED[kind][0][0]
    sx0, sy0, sx1, sy1 = _coords_bbox(rl, [ref])
    px0, py0, px1, py1 = _px_bbox(_only_paths(rl, {ref}))
    a, e = (px1 - px0) / (sx1 - sx0), px0 - sx0 * (px1 - px0) / (sx1 - sx0)
    d, f = (py1 - py0) / (sy1 - sy0), py0 - sy0 * (py1 - py0) / (sy1 - sy0)
    # --- gradients used by the shield paths, renamed so nothing else touches them
    grads = ""
    for group in RELOADED[kind]:
        for n in group:
            for gid in re.findall(r'url\(#(\w+)\)', rl[n - 1]):
                g = re.search(rf'<(linear|radial)Gradient[^>]*id="{gid}".*?</\1Gradient>', rsvg, re.S)[0]
                grads += g.replace(f'id="{gid}"', f'id="rs_{gid}"')
    # --- Legacy: remove its shield uses, note where each one was (pixels)
    body = re.search(r'(<g id="sprite0">)(.*?)(</g>)', legacy_svg, re.S)
    uses = [l for l in body[2].split("\n") if "<use" in l]
    targets = []
    for idx in LEGACY_USES[kind]:
        alone = legacy_svg.replace(body[0], body[1] + "\n" + uses[idx] + "\n" + body[3])
        targets.append(_px_bbox(alone))
    new_body = "\n".join(l for l in body[2].split("\n") if l not in [uses[i] for i in LEGACY_USES[kind]])
    out = legacy_svg.replace(body[0], body[1] + new_body + body[3])
    W, H = _root_size(out)
    groups = ""
    for group, tb in zip(RELOADED[kind], targets):
        rb = _px_bbox(_only_paths(rl, set(group)))                   # this Reloaded shield, pixels
        k = min((tb[2] - tb[0]) / (rb[2] - rb[0]), (tb[3] - tb[1]) / (rb[3] - rb[1]))
        ox = (tb[0] + tb[2]) / 2 - k * (rb[0] + rb[2]) / 2
        oy = (tb[1] + tb[3]) / 2 - k * (rb[1] + rb[3]) / 2
        # shape -> reloaded px (a,e / d,f) -> legacy px (k, ox/oy) -> legacy root units (W/N, H/N)
        A, D = a * k * W / N, d * k * H / N
        E, F = (e * k + ox) * W / N, (f * k + oy) * H / N
        paths = "\n".join(re.sub(r'url\(#(\w+)\)', r'url(#rs_\1)', rl[n - 1]) for n in group)
        groups += f'<g transform="matrix({A:.5f},0,0,{D:.5f},{E:.3f},{F:.3f})">\n{paths}\n</g>\n'
    out = out.replace("</svg>", groups + "</svg>")
    return out.replace("<defs>", "<defs>" + grads, 1)
