"""Gold Energy Storage Unit (module_energy12/13/14): only the centre column and the top head
turn gold (brightness kept). Side panels, frame, blue lights, core and stripes stay as they are.

Parts are picked by where they land in the rendered sprite (so nested transforms don't matter):
each near-grey steel path is rendered alone, and it counts as
- centre column: its box is centred and narrower than 40% of the sprite, or
- top head: its box ends in the top 22% of the sprite.
"""
import glob, re, io, cairosvg
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Modules/energy")
exec(open("tools/gold_energy_booster.py").read().split("rows = [[], []]")[0])  # gold_of()
N = 200

def steel(c):
    r, g, b = (int(c[i:i + 2], 16) for i in (1, 3, 5))
    return max(r, g, b) - min(r, g, b) <= 8 and min(r, g, b) >= 0x70

def box_of(lines, i):
    """Pixel bounding box of path line i rendered alone."""
    L = [l if (j == i or not l.lstrip().startswith("<path")) else "" for j, l in enumerate(lines)]
    im = Image.open(io.BytesIO(cairosvg.svg2png(bytestring="\n".join(L).encode(), output_width=N, output_height=N)))
    return im.getchannel("A").point(lambda a: 255 if a > 40 else 0).getbbox()

def wanted(bb):
    if not bb:
        return False
    x0, y0, x1, y1 = bb
    small = (x1 - x0) < N * 0.2 and (y1 - y0) < N * 0.2      # the steel core cap stays steel
    centre = abs((x0 + x1) / 2 - N / 2) < N * 0.08 and (x1 - x0) < N * 0.40 and not small
    top = y1 < N * 0.22
    return top   # user: only the top head is gold (centre column and block tried, rejected)

def goldify(svg):
    lines, extra = svg.split("\n"), []
    for i, l in enumerate(lines):
        if not l.lstrip().startswith("<path"):
            continue
        cols = re.findall(r'fill="(#[0-9a-fA-F]{6})"', l)
        grads = re.findall(r'fill="url\(#(\w+)\)"', l)
        if not (any(steel(c.lower()) for c in cols) or grads) or not wanted(box_of(lines, i)):
            continue
        lines[i] = re.sub(r'fill="(#[0-9a-fA-F]{6})"',
                          lambda m: f'fill="{gold_of(m[1].lower())}"' if steel(m[1].lower()) else m[0], l)
        for gid in grads:   # gradient fills: copy the gradient with steel stops turned gold
            g = re.search(rf'<(linear|radial)Gradient[^>]*id="{gid}".*?</\1Gradient>', svg, re.S)
            if g and any(steel(c.lower()) for c in re.findall(r'stop-color="(#[0-9a-fA-F]{6})"', g[0])):
                ng = re.sub(r'stop-color="(#[0-9a-fA-F]{6})"',
                            lambda m: f'stop-color="{gold_of(m[1].lower())}"' if steel(m[1].lower()) else m[0], g[0])
                extra.append(ng.replace(f'id="{gid}"', f'id="{gid}_g"'))
                lines[i] = lines[i].replace(f"url(#{gid})", f"url(#{gid}_g)")
    return "\n".join(lines).replace("<defs>", "<defs>" + "".join(extra), 1)

rows = [[], []]
for n in (12, 13, 14):
    src = Path(glob.glob(f"chosen/Modules/*/module_energy{n}.svg")[0]).read_text(encoding="utf-8")
    g = goldify(src)
    (OUT / f"energy{n}_gold.svg").write_text(g, encoding="utf-8")
    cairosvg.svg2png(bytestring=g.encode(), write_to=str(OUT / f"energy{n}_gold.png"), output_width=512, output_height=512)
    for r, s in enumerate((src, g)):
        rows[r].append(Image.open(io.BytesIO(cairosvg.svg2png(bytestring=s.encode(), output_width=260, output_height=260))).convert("RGBA"))
sheet = Image.new("RGBA", (3 * 270, 540), (44, 44, 48, 255))
for r in range(2):
    for i, im in enumerate(rows[r]):
        sheet.paste(im, (i * 270 + 5, r * 270 + 5), im)
sheet.save(OUT / "storage-gold-test.png")
print("ok")

# energy14: the steel block under the core is part of one big body path (#9f9a9a) that also
# covers the side panels, so gold it with a clipped gold copy of that path limited to the block.
def gold_block(svg, line_no=35, px_box=(66, 143, 137, 183), insert_before=50):
    lines = svg.split("\n")
    l = lines[line_no - 1]
    nums = [float(v) for v in re.findall(r"-?\d+\.?\d*", re.search(r' d="([^"]*)"', l)[1])]
    lx0, lx1, ly0, ly1 = min(nums[0::2]), max(nums[0::2]), min(nums[1::2]), max(nums[1::2])
    px0, py0, px1, py1 = box_of(lines, line_no - 1)          # same path, in rendered pixels
    sx, sy = (lx1 - lx0) / (px1 - px0), (ly1 - ly0) / (py1 - py0)
    X0, Y0 = lx0 + (px_box[0] - px0) * sx, ly0 + (px_box[1] - py0) * sy
    X1, Y1 = lx0 + (px_box[2] - px0) * sx, ly0 + (px_box[3] - py0) * sy
    clip = f'<clipPath id="blockClip"><rect x="{X0:.2f}" y="{Y0:.2f}" width="{X1-X0:.2f}" height="{Y1-Y0:.2f}"/></clipPath>'
    gold = l.replace('fill="#9f9a9a"', f'fill="{gold_of("#9f9a9a")}" clip-path="url(#blockClip)"', 1)
    lines.insert(insert_before - 1, gold)   # above the parts that cover the block, below the light's frame
    return "\n".join(lines).replace("<defs>", "<defs>" + clip, 1)

# gold_block() is kept for reference but not applied (rejected by the user).
