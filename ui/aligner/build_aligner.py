"""Build ui/aligner/index.html and ui/aligner/publish_files.json.

Reads the sprites under Plans/ and the anchor data in data/items_selected.json, embeds a manifest of
every sprite (size + anchors) into aligner.template.html, and lists which repo files to publish next to it.

Run from the repo root:  python ui/aligner/build_aligner.py
"""
import glob, json, os, re, struct

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
OUT = os.path.join(ROOT, "ui", "aligner")
items = {i["id"]: i for i in json.load(open(os.path.join(ROOT, "data", "items_selected.json")))["items"]}


def size(p):
    with open(p, "rb") as f:
        f.read(16)
        return struct.unpack(">II", f.read(8))


def anchors_for(name):
    n = name
    for s in ("_phys", "_heat", "_elec"):
        if n.endswith(s):
            n = n[: -len(s)]
    for cand in (n, re.sub(r"_\d+$", "", n)):
        a = items.get(cand, {}).get("anchors")
        if a:
            return a
    return None


CATS = {
    "torso": "Plans/Torsos/sprites/*.png",
    "leg": "Plans/Legs/sprites/*.png",
    "top": "Plans/Top Weapons/sprites/*.png",
    "side": "Plans/Side Weapons/final/**/*.png",
}
manifest, files = {}, {}
for cat, pat in CATS.items():
    rows, seen = [], set()
    for p in sorted(glob.glob(os.path.join(ROOT, pat), recursive=True)):
        f = os.path.basename(p)[:-4]
        if f in seen:
            raise SystemExit("duplicate sprite name " + f)
        seen.add(f)
        w, h = size(p)
        a = anchors_for(f)
        if cat == "torso":
            keep = {k: v for k, v in (a or {}).items() if k.startswith(("mcCenter", "mcTop", "mcSide", "mcLeg", "mcDrone"))}
            base = re.sub(r"_(phys|heat|elec)$", "", f)
            rows.append({"f": f, "b": base, "w": w, "h": h, "a": keep})
        else:
            rows.append({"f": f, "b": re.sub(r"_(phys|heat|elec)$", "", f), "w": w, "h": h,
                         "a": {"mcTorso": a["mcTorso"]} if a and "mcTorso" in a else None})
        files["s/%s/%s.png" % (cat, f)] = os.path.relpath(p, ROOT)
    manifest[cat] = rows

# reference: the game's own workshop screenshot; measured earlier at 0.596 native px per torso-PNG px
k = 0.596
ref = {"src": "s/ref/workshop.webp", "x": round(-(487 - 122 * k) / k, 1), "y": round(-(287 - 275 * k) / k, 1),
       "s": round(1 / k, 3), "w": 1902}
files["s/ref/workshop.webp"] = "ui/refs/workshop-item-info.webp"

tpl = open(os.path.join(OUT, "aligner.template.html"), encoding="utf-8").read()
html = tpl.replace("/*MANIFEST*/null", json.dumps(manifest, separators=(",", ":"))).replace("/*REFDEFAULT*/null", json.dumps(ref))
open(os.path.join(OUT, "index.html"), "w", encoding="utf-8").write(html)
json.dump(files, open(os.path.join(OUT, "publish_files.json"), "w"), indent=1)
print("sprites:", {c: len(r) for c, r in manifest.items()}, "files to publish:", len(files) + 1)
print("html bytes:", len(html))
