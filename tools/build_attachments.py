"""Build data/attachments.json: everything needed to attach any roster sprite to a mech, in one lookup.

Per sprite (keyed by the file stem under Plans/, e.g. "leg73E_phys", "cannon3C2"):
  source   the original symbol the art and anchors come from (recolours share their source's geometry)
  frame    outer frame translation [fx, fy] of the SVG export. PNG-space anchor = anchor + frame.
  anchors  the mc* attachment points in symbol space (torso: mcCenter, mcLeg1/2, mcSide1-4, mcTop1/2, mcDrone,
           mcHat, mcChargeEngine, mcShutdown; parts: mcTorso, mcFire*, ...)
Placement rule (from BMMechView.buildItem):  part top-left in 2x PNG px =
  ((torso.anchor + torso.frame) - (part.mcTorso + part.frame)) * 2

Inputs: data/items_selected.json, data/sprite_bounds.json (tools/extract_sprite_bounds.py), data/anchor_sources.json
Run from the repo root:  python tools/build_attachments.py
"""
import glob, json, os, re, struct

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
items = json.load(open(os.path.join(ROOT, "data", "items_selected.json")))["items"]
bounds = json.load(open(os.path.join(ROOT, "data", "sprite_bounds.json")))
sources = json.load(open(os.path.join(ROOT, "data", "anchor_sources.json")))
allb = {}
for era in ("legacy", "reloaded"):  # reloaded wins where both exist
    allb.update(bounds[era])


def mat(m):
    return [m[4], m[5]] if len(m) == 6 else list(m)


def resolve(stem):
    if stem in sources:
        return sources[stem]
    n = stem.replace("_legacy", "")
    for c in (n, re.sub(r"_(phys|heat|elec)$", "", n), re.sub(r"_\d+$", "", re.sub(r"_(phys|heat|elec)$", "", n))):
        if c in allb:
            return c
    return None


out, missing = {}, []
for it in items:
    stem = os.path.basename(it["sprite"])[:-4]
    src = resolve(stem)
    r = allb.get(src) if src else None
    if not r or "frame" not in r:
        missing.append((it["slot"], stem))
        continue
    out[stem] = {
        "slot": it["slot"],
        "source": src,
        "frame": [r["frame"][4], r["frame"][5]],
        "anchors": {k: mat(v) for k, v in r["clips"].items() if k.startswith("mc")},
    }
json.dump(out, open(os.path.join(ROOT, "data", "attachments.json"), "w"), separators=(",", ":"))
by = {}
for v in out.values():
    by[v["slot"]] = by.get(v["slot"], 0) + 1
print("wrote data/attachments.json:", len(out), "sprites", by)
need = {"torsos": ["mcCenter", "mcLeg1", "mcLeg2"], "legs": ["mcTorso"], "top_weapons": ["mcTorso"], "side_weapons": ["mcTorso"], "drones": ["mcCenter"]}
bad = [(v["slot"], k) for k, v in out.items() if v["slot"] in need and not all(a in v["anchors"] for a in need[v["slot"]])]
print("entries missing a required anchor:", len(bad), bad[:8])
print("roster sprites with no source at all:", len(missing), missing[:8])
