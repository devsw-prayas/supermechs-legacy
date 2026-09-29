"""Build data/items_raw.json: one record per unique item sprite in items/, with names, stats and families.

Joins:
- items/index.csv + items/quality.csv                     (sprite, slot, era, quality)
- extracted/data/legacy-items-pack.json                   (Legacy name + flat stats, keyed by sprite symbol)
- extracted/data/enegg-items.json                         (Reloaded name + per-tier stats, keyed by item name)
- extracted/data/reloaded-name-to-symbol.json             (Reloaded item name -> sprite, matched by image)
- extracted/sprites/*/anchors.json                        (attachment points)
Families: same symbol stem (tier letters / _N suffix stripped), merged with Legacy name stems
("Physical Resistance Module 1..6", "Mark N", "v3.0").
"""
import csv, json, os, re, sys
from collections import defaultdict

ROOT = sys.argv[1]
J = lambda *p: os.path.join(ROOT, *p)
TIERS = ["common", "rare", "epic", "legendary", "mythical", "divine"]
LETTER = {"C": "common", "R": "rare", "E": "epic", "L": "legendary", "M": "mythical", "D": "divine"}

index = {r["symbol"]: r for r in csv.DictReader(open(J("items/index.csv"), encoding="utf8"))}
quality = {r["symbol"]: r for r in csv.DictReader(open(J("items/quality.csv"), encoding="utf8"))}
anchors = {}
for era in ("legacy", "reloaded"):
    for k, v in json.load(open(J("extracted/sprites", era, "anchors.json"))).items():
        anchors.setdefault(k, v)

# Legacy pack: keyed by sprite symbol
legacy = {}
for it in json.load(open(J("extracted/data/legacy-items-pack.json"), encoding="utf8"))["items"]:
    legacy.setdefault(re.sub(r"^%url%|\.png$", "", it["image"]), []).append(it)

# Reloaded pack: keyed by sprite symbol via image match
norm = lambda s: re.sub(r"[^a-z0-9]", "", s.lower())
match = json.load(open(J("extracted/data/reloaded-name-to-symbol.json")))
name_to_sym = {norm(k): v["symbol"] for k, v in match.items() if v["dist"] < 0.05}
reloaded = {}
for it in json.load(open(J("extracted/data/enegg-items.json"), encoding="utf8"))["items"]:
    sym = name_to_sym.get(norm(it["name"]))
    if sym:
        reloaded.setdefault(sym, it)

def full_tiers(it):
    """Merge Reloaded delta blocks into full stats per tier (base + max)."""
    cur, out = {}, {}
    for t in TIERS:
        if t in it:
            cur = {**cur, **it[t]}
            out[t] = {"base": dict(cur)}
        if "max_" + t in it:
            out.setdefault(t, {"base": dict(cur)})["max"] = {**cur, **it["max_" + t]}
    return out

def stem(sym):
    s = re.sub(r"_legacy$", "", sym)
    s = re.sub(r"_\d+$", "", s)          # torso1002_2 -> torso1002
    s = re.sub(r"(?<=\d)[A-E]\d*$", "", s)  # cannon11A2 -> cannon11, sword3E -> sword3
    s = re.sub(r"(?<=[a-z])[A-E]$", "", s)  # enhancerRepairD -> enhancerRepair
    return s

def name_stem(n):
    n = re.sub(r"\s*(v\d+(\.\d+)?|mark\s*\d+|mk\s*\d+|\d+)$", "", n.strip(), flags=re.I)
    return n.strip().lower()

# union-find over sprite symbols
parent = {s: s for s in index}
def find(x):
    while parent[x] != x:
        parent[x] = parent[parent[x]]
        x = parent[x]
    return x
def union(a, b):
    parent[find(a)] = find(b)
groups = defaultdict(list)
for s in index:
    groups[("stem", index[s]["slot"], stem(s))].append(s)
    for it in legacy.get(re.sub(r"_legacy$", "", s), []):
        groups[("name", index[s]["slot"], name_stem(it["name"]))].append(s)
for members in groups.values():
    for m in members[1:]:
        union(members[0], m)

items = []
for s, r in index.items():
    raw = re.sub(r"_legacy$", "", s)
    lg, rl = legacy.get(raw, []), reloaded.get(raw)
    names = [it["name"] for it in lg] + ([rl["name"]] if rl else [])
    rec = {
        "id": s,
        "sprite": r["file"],
        "slot": r["slot"],
        "era": r["era"],
        "names": sorted(set(names)),
        "element": (rl or (lg[0] if lg else {})).get("element"),
        "tags": (rl or {}).get("tags", []),
        "quality": {"score": float(quality[s]["score"]), "flag": quality[s]["flag"]} if s in quality else None,
        "aliases": r["aliases"].split() if r["aliases"] else [],
        "anchors": anchors.get(raw, {}),
        "stats": {},
        "family": None,
    }
    if rl:
        rec["stats"]["reloaded"] = {"transform_range": rl.get("transform_range"), "tiers": full_tiers(rl)}
    if lg:
        rec["stats"]["legacy"] = [{"name": it["name"], "id": it["id"], "stats": it["stats"]} for it in lg]
    items.append(rec)

fam = defaultdict(list)
for rec in items:
    fam[find(rec["id"])].append(rec["id"])
fam_id = {}
for root, members in fam.items():
    members.sort()
    fid = members[0]
    for m in members:
        fam_id[m] = (fid, len(members))
for rec in items:
    rec["family"], rec["family_size"] = fam_id[rec["id"]]

items.sort(key=lambda r: (r["slot"], r["family"], r["id"]))
os.makedirs(J("data"), exist_ok=True)
json.dump({"version": 1, "count": len(items), "items": items}, open(J("data/items_raw.json"), "w", encoding="utf8"), indent=1)

fams = defaultdict(int)
for rec in items:
    fams[rec["family"]] += 1
print(json.dumps({
    "items": len(items),
    "with_names": sum(1 for r in items if r["names"]),
    "with_legacy_stats": sum(1 for r in items if "legacy" in r["stats"]),
    "with_reloaded_stats": sum(1 for r in items if "reloaded" in r["stats"]),
    "no_stats": sum(1 for r in items if not r["stats"]),
    "families": len(fams),
    "single_item_families": sum(1 for v in fams.values() if v == 1),
    "biggest_families": sorted(fams.items(), key=lambda x: -x[1])[:8],
}, indent=1))
