"""Score how "modern" each item sprite's art is, from its idle SVG.

Metrics per sprite: path count, gradient count, unique fill colors, area.
Each metric is ranked (percentile) against sprites that exist only in Reloaded (same slot),
so an item is judged against current-style art of its own kind.
score = mean percentile (0 = far below Reloaded style, 1 = typical/above).
Writes items/quality.csv and prints a summary. Flag: score < 0.25 = outdated, < 0.45 = borderline.
"""
import csv, os, re, sys, bisect, statistics as st

ROOT = sys.argv[1]
ITEMS = os.path.join(ROOT, "items")
SPR = os.path.join(ROOT, "extracted", "sprites")

def metrics(svg_path):
    s = open(svg_path, encoding="utf8").read()
    paths = len(re.findall(r"<path\b", s))
    grads = len(re.findall(r"<(linear|radial)Gradient\b", s))
    fills = len(set(re.findall(r'fill="(#[0-9a-fA-F]{6})"', s)) | set(re.findall(r'stop-color="(#[0-9a-fA-F]{6})"', s)))
    w = re.search(r'width="([\d.]+)px"', s); h = re.search(r'height="([\d.]+)px"', s)
    area = float(w.group(1)) * float(h.group(1)) if w and h else 0
    # detail density: shapes per 10k px², so big simple parts aren't rewarded for size
    return {"paths": paths, "gradients": grads, "colors": fills, "density": paths / max(area / 1e4, 0.5)}

rows = list(csv.DictReader(open(os.path.join(ITEMS, "index.csv"), encoding="utf8")))
for r in rows:
    sym = r["symbol"]
    era = "legacy" if sym.endswith("_legacy") or r["era"] == "legacy" else "reloaded"
    src = os.path.join(SPR, era, "svg_idle", re.sub(r"_legacy$", "", sym) + ".svg")
    r.update(metrics(src) if os.path.exists(src) else {"paths": 0, "gradients": 0, "colors": 0, "density": 0})
    r["art_era"] = era

KEYS = ("paths", "gradients", "colors", "density")
ref = {}
for r in rows:
    if r["era"] == "reloaded":  # Reloaded-only items = the current art style
        for k in KEYS:
            ref.setdefault((r["slot"], k), []).append(r[k])
for v in ref.values():
    v.sort()

def pct(slot, k, x):
    arr = ref.get((slot, k)) or sorted(r[k] for r in rows if r["art_era"] == "reloaded")
    return bisect.bisect_left(arr, x) / max(len(arr), 1)

for r in rows:
    r["score"] = round(st.mean(pct(r["slot"], k, r[k]) for k in KEYS), 3)
    r["flag"] = "outdated" if r["score"] < 0.25 else "borderline" if r["score"] < 0.45 else "ok"

out = os.path.join(ITEMS, "quality.csv")
with open(out, "w", newline="", encoding="utf8") as fh:
    cols = ["symbol", "slot", "era", "art_era", "name", "file", "score", "flag", "paths", "gradients", "colors", "density"]
    w = csv.DictWriter(fh, fieldnames=cols, extrasaction="ignore")
    w.writeheader()
    for r in sorted(rows, key=lambda r: (r["slot"], r["score"])):
        r["density"] = round(r["density"], 2)
        w.writerow(r)

summary = {}
for r in rows:
    d = summary.setdefault(r["slot"], {"ok": 0, "borderline": 0, "outdated": 0})
    d[r["flag"]] += 1
tot = {f: sum(d[f] for d in summary.values()) for f in ("ok", "borderline", "outdated")}
print("TOTAL", tot)
for s, d in sorted(summary.items()):
    print(f"{s:15} {d}")
by_era = {}
for r in rows:
    by_era.setdefault((r["art_era"], r["flag"]), 0)
    by_era[(r["art_era"], r["flag"])] += 1
print("by art era", dict(sorted(by_era.items())))
