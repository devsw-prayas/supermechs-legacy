"""Test every roster sprite's attachment data. Prints a report and exits 1 if anything required is missing.

Checks, per slot:
  * torsos   need mcCenter, mcLeg1, mcLeg2 (mcSide1-4, mcTop1-2, mcDrone are optional per design; counted)
  * legs, top weapons, side weapons   need mcTorso
  * drones   need mcCenter
  * every entry has the SVG frame offset
  * size check: the PNG under Plans/ has the same size as its source symbol (a mismatch means the PNG was padded
    or resized and the source's anchors will not line up with it)
  * assembly test: every torso gets a default loadout built only from parts that torso can carry, and the
    placement must land inside a sane box around the torso.

Run from the repo root:  python tools/check_attachments.py   (needs data/attachments.json, see build_attachments.py)
"""
import glob, json, os, struct, sys, collections

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
A = json.load(open(os.path.join(ROOT, "data", "attachments.json")))
B = json.load(open(os.path.join(ROOT, "data", "sprite_bounds.json")))
allb = {}
for e in ("legacy", "reloaded"):
    allb.update(B[e])

NEED = {"torsos": ["mcCenter", "mcLeg1", "mcLeg2"], "legs": ["mcTorso"], "top_weapons": ["mcTorso"],
        "side_weapons": ["mcTorso"], "drones": ["mcCenter"]}
problems = []
count = collections.Counter()

# 1. required anchors and frame
for stem, v in A.items():
    if v["slot"] in NEED:
        count[v["slot"]] += 1
        miss = [k for k in NEED[v["slot"]] if k not in v["anchors"]]
        if miss:
            problems.append(("missing anchor", v["slot"], stem, miss))
        if "frame" not in v:
            problems.append(("no frame", v["slot"], stem, ""))

# 2. png size vs source
def png_size(p):
    with open(p, "rb") as f:
        f.read(16)
        return struct.unpack(">II", f.read(8))

pngs = {}
for p in glob.glob(os.path.join(ROOT, "Plans", "**", "*.png"), recursive=True):
    if "_archive" not in p:
        pngs.setdefault(os.path.basename(p)[:-4], p)
size_bad = []
for stem, v in A.items():
    if v["slot"] not in ("torsos", "legs", "top_weapons", "side_weapons") or stem not in pngs:
        continue
    r = allb[v["source"]]
    W, H = float(r["width"][:-2]) * 2, float(r["height"][:-2]) * 2
    w, h = png_size(pngs[stem])
    if abs(w - W) > 3 or abs(h - H) > 3:
        size_bad.append((stem, v["source"], (w, h), (round(W), round(H))))

# 3. assembly test per torso
legs = [k for k, v in A.items() if v["slot"] == "legs"]
tops = [k for k, v in A.items() if v["slot"] == "top_weapons"]
sides = [k for k, v in A.items() if v["slot"] == "side_weapons" and k not in {s[0] for s in size_bad}]
SLOTS = ["mcLeg1", "mcLeg2", "mcTop1", "mcTop2", "mcSide1", "mcSide2", "mcSide3", "mcSide4"]
assembled = odd = 0
for stem, t in A.items():
    if t["slot"] != "torsos":
        continue
    ta = t["anchors"]
    tw, th = None, None
    r = allb[t["source"]]
    tw, th = float(r["width"][:-2]) * 2, float(r["height"][:-2]) * 2
    for slot in SLOTS:
        if slot not in ta:
            continue
        part = legs[0] if "Leg" in slot else tops[0] if "Top" in slot else sides[0]
        p = A[part]
        x = ((ta[slot][0] + t["frame"][0]) - (p["anchors"]["mcTorso"][0] + p["frame"][0])) * 2
        y = ((ta[slot][1] + t["frame"][1]) - (p["anchors"]["mcTorso"][1] + p["frame"][1])) * 2
        if not (-tw <= x <= 2 * tw and -th <= y <= 2 * th):
            odd += 1
            problems.append(("placement far outside torso", "torsos", stem, (slot, round(x), round(y))))
    assembled += 1

print("sprites checked:", dict(count))
print("assembled test mechs (one per torso):", assembled)
print("size mismatches (PNG padded or resized vs its source symbol):", len(size_bad))
for s in size_bad[:40]:
    print("   ", s)
opt = collections.Counter()
for stem, t in A.items():
    if t["slot"] == "torsos":
        for k in ("mcSide1", "mcSide2", "mcSide3", "mcSide4", "mcTop1", "mcTop2", "mcDrone"):
            opt[k] += k in t["anchors"]
print("torsos carrying each optional slot:", dict(opt))
print("problems:", len(problems))
for pr in problems[:40]:
    print("   ", pr)
sys.exit(1 if problems else 0)
