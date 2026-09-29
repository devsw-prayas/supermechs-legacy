"""Build data/items_selected.json from items_raw.json + the review export (data/review_export/reviews/*.json).

Only items marked "keep" are included; the review note/name/art choice travels with each item.
"""
import collections, glob, json, os, sys

ROOT = sys.argv[1] if len(sys.argv) > 1 else "."
J = lambda *p: os.path.join(ROOT, *p)
R = {os.path.basename(f)[:-5]: json.load(open(f)) for f in glob.glob(J("data/review_export/reviews/*.json"))}
raw = json.load(open(J("data/items_raw.json"), encoding="utf8"))["items"]
_O = json.load(open(J("data/slot_overrides.json")))
OVR = {k: v for k, v in _O.items() if not k.startswith("_")}
DROP = set(_O.get("_drop", []))
ADD = set(_O.get("_add", []))
ELEM = _O.get("_element", {})
NAMES = _O.get("_names", {})

keep = []
for it in raw:
    r = R.get(it["id"], {})
    if (r.get("d") == "keep" or it["id"] in ADD) and it["id"] not in DROP:
        it = dict(it)
        for pre, slot in OVR.items():
            if it["id"].startswith(pre):
                it["slot"] = slot
        if it["id"] in NAMES:
            it["names"] = [NAMES[it["id"]]]
        if it["id"] in ELEM:
            it["element"] = ELEM[it["id"]]
        it["review"] = {k: v for k, v in r.items() if k in ("note", "name", "art")}
        keep.append(it)
for e in _O.get("_extra", []):
    keep.append(dict(e, review={}))
json.dump({"version": 1, "count": len(keep), "items": keep},
          open(J("data/items_selected.json"), "w", encoding="utf8"), indent=1)

tot = collections.Counter(i["slot"] for i in raw)
k = collections.Counter(i["slot"] for i in keep)
fam = collections.Counter(i["slot"] for i in {i["family"]: i for i in keep}.values())
print(f"kept {len(keep)} sprites, {len({i['family'] for i in keep})} families, maybe {sum(v.get('d') == 'maybe' for v in R.values())}")
for s in sorted(tot, key=lambda s: -k[s]):
    print(f"  {s:15} {k[s]:4} / {tot[s]:4}   families {fam[s]}")
