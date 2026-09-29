"""Sort every item sprite into items/<slot>/ with deduplication.

Sources: extracted/sprites/<era>/png_idle (clean idle renders).
- Slot comes from the community item packs where the symbol is known, otherwise from the name prefix.
- Duplicates: the same symbol in both eras with identical (or render-noise-only) pixels is kept once (the Reloaded copy).
  Different symbols with identical pixels are kept once (first name wins); the others are listed as aliases.
- Skips shadows, masks and UI/icon symbols.
Writes items/index.csv (symbol, slot, era, name, file, aliases).
"""
import csv, hashlib, json, os, re, shutil, sys
from PIL import Image, ImageChops

ROOT = sys.argv[1]
SPR = os.path.join(ROOT, "extracted", "sprites")
OUT = os.path.join(ROOT, "items")

PACK_SLOT = {"TORSO": "torsos", "LEGS": "legs", "SIDE_WEAPON": "side_weapons", "TOP_WEAPON": "top_weapons",
             "DRONE": "drones", "MODULE": "modules", "KIT": "kits", "SHIELD": "shields",
             "GRAPPLING_HOOK": "hooks", "HOOK": "hooks", "TELEPORTER": "teleporters",
             "CHARGE_ENGINE": "charge_engines", "CHARGE": "charge_engines"}
SKIP = re.compile(r"(_shadow|_mask)$|^(subType_|interface_|missingItemPicture|itemsBox|missionAvatar|clanBossAvatar)")
RULES = [  # (regex on symbol, slot) — first match wins
    (r"^(torsoBoss|legBoss|sideBoss|topBoss)", "bosses"),
    (r"^(torso|hatPerk|perk_hat|perk_torso)", "torsos"),
    (r"^(leg|wheels|jet)", "legs"),
    (r"^top", "top_weapons"),
    (r"^(side|pushSelfShotgun|hand|wand|shieldWeapon)", "side_weapons"),
    (r"^(superDrone|drone)", "drones"),
    (r"^module_", "modules"),
    (r"^kit_", "kits"),
    (r"^shield", "shields"),
    (r"^(harpoon|superHarpoon)", "hooks"),
    (r"^(teleport|superTeleport)", "teleporters"),
    (r"^(charge|engineBooster)", "charge_engines"),
    (r"^enhancer", "enhancers"),
    (r"^perk_", "perks"),
    (r"^(laser|blaster|cannon|rocketLauncher|sword|machineGun|flameThrower|shotgun|grenadeLauncher|hammer|axe)", "side_weapons"),
]

names, slots = {}, {}
lp = json.load(open(os.path.join(ROOT, "extracted/data/legacy-items-pack.json"), encoding="utf8"))
for it in lp["items"]:
    sym = re.sub(r"^%url%|\.png$", "", it["image"])
    names.setdefault(sym, it["name"])
    slots.setdefault(sym, PACK_SLOT.get(it["type"]))

def stem(sym):
    """cannon7A2 -> cannon7, sword3E -> sword3: the family a variant belongs to."""
    return re.sub(r"(?<=\d)[A-E]\d*$", "", re.sub(r"_legacy$", "", sym))

# a variant missing from the packs inherits its family's slot, when the family has exactly one
stem_slots = {}
for k, v in slots.items():
    if v:
        stem_slots.setdefault(stem(k), set()).add(v)

def slot_of(sym):
    if slots.get(sym):
        return slots[sym]
    fam = stem_slots.get(stem(sym))
    if fam and len(fam) == 1:
        return next(iter(fam))
    for rx, s in RULES:
        if re.search(rx, sym):
            return s
    return "_other"

def near_same(a, b):
    """True if two sprites differ only by render noise (<0.2% of pixels changed noticeably)."""
    a, b = Image.open(a).convert("RGBA"), Image.open(b).convert("RGBA")
    if a.size != b.size:
        return False
    diff = ImageChops.difference(a, b)
    return sum(1 for x in diff.getdata() if max(x) > 24) / (a.size[0] * a.size[1]) < 0.002

def pixhash(path):
    im = Image.open(path).convert("RGBA")
    return hashlib.sha1(im.tobytes() + str(im.size).encode()).hexdigest()

if os.path.exists(OUT):
    shutil.rmtree(OUT)
rows, by_hash = {}, {}
stats = {"cross_era_identical": 0, "cross_era_different": 0, "same_image_alias": 0, "skipped": 0}
for era in ("reloaded", "legacy"):  # reloaded first, so it wins identical duplicates
    d = os.path.join(SPR, era, "png_idle")
    for f in sorted(os.listdir(d)):
        if not f.endswith(".png"):
            continue
        sym = f[:-4]
        if SKIP.search(sym):
            stats["skipped"] += 1
            continue
        path = os.path.join(d, f)
        h = pixhash(path)
        if sym in rows:  # same symbol already taken from reloaded
            if rows[sym]["hash"] == h or near_same(rows[sym]["src"], path):
                stats["cross_era_identical"] += 1
                rows[sym]["era"] = "both"
                continue
            stats["cross_era_different"] += 1
            key = sym + "_legacy"
        else:
            key = sym
        if h in by_hash:  # identical art under another name
            rows[by_hash[h]]["aliases"].append(key)
            stats["same_image_alias"] += 1
            continue
        slot = slot_of(sym)
        dest = os.path.join(OUT, slot, key + ".png")
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        shutil.copy2(path, dest)
        by_hash[h] = key
        rows[key] = {"symbol": key, "slot": slot, "era": era, "name": names.get(sym, ""),
                     "file": f"{slot}/{key}.png", "aliases": [], "hash": h, "src": path}

with open(os.path.join(OUT, "index.csv"), "w", newline="", encoding="utf8") as fh:
    w = csv.writer(fh)
    w.writerow(["symbol", "slot", "era", "name", "file", "aliases"])
    for r in sorted(rows.values(), key=lambda r: (r["slot"], r["symbol"])):
        w.writerow([r["symbol"], r["slot"], r["era"], r["name"], r["file"], " ".join(r["aliases"])])

counts = {}
for r in rows.values():
    counts[r["slot"]] = counts.get(r["slot"], 0) + 1
print(json.dumps({"total": len(rows), "by_slot": dict(sorted(counts.items())), **stats}, indent=1))
