"""Export the chosen roster to chosen/ as a reference folder (for building Obsidian docs).

chosen/
  README.md                      overview + counts
  items.json                     every kept sprite with full data
  <slot>/<NNN Family Name>/
      <sprite>.png  (2x clean idle render)
      <sprite>.svg  (vector, idle)
      info.json     family data: names, element, era, sprites, stats per sprite, notes, flags
      info.md       the same, readable
"""
import json, os, re, shutil, sys

ROOT = sys.argv[1] if len(sys.argv) > 1 else "."
J = lambda *p: os.path.join(ROOT, *p)
OUT = J("chosen")
SLOT_NAME = {"torsos": "Torsos", "legs": "Legs", "side_weapons": "Side Weapons", "top_weapons": "Top Weapons",
             "drones": "Drones", "modules": "Modules", "shields": "Shields", "teleporters": "Teleporters",
             "charge_engines": "Charge Engines", "hooks": "Hooks", "kits": "Kits", "bosses": "Boss Parts"}
STAT = {"weight": "Weight", "health": "HP", "eneCap": "Energy capacity", "eneReg": "Energy regen", "heaCap": "Heat capacity",
        "heaCol": "Cooling", "phyRes": "Physical res", "expRes": "Explosive res", "eleRes": "Electric res",
        "phyDmg": "Physical dmg", "expDmg": "Explosive dmg", "eleDmg": "Electric dmg", "heaDmg": "Heat dmg",
        "eneDmg": "Energy drain", "range": "Range", "push": "Push", "pull": "Pull", "uses": "Uses",
        "eneCost": "Energy cost", "heaCost": "Heat cost", "backfire": "Backfire", "walk": "Walk", "jump": "Jump",
        "phyResDmg": "Physical res drain", "expResDmg": "Explosive res drain", "eleResDmg": "Electric res drain",
        "heaCapDmg": "Heat cap drain", "eneCapDmg": "Energy cap drain", "heaColDmg": "Cooling drain",
        "eneRegDmg": "Energy regen drain", "retreat": "Retreat", "advance": "Advance", "recoil": "Recoil"}

sel = json.load(open(J("data/items_selected.json"), encoding="utf8"))["items"]
walk = json.load(open(J("data/reports/family_walkthrough.json")))
dup = json.load(open(J("data/reports/duplicate_report.json")))
by_id = {i["id"]: i for i in sel}
legacy_pairs, alias = set(dup["legacy_pairs"]), {a: b for a, b in dup["aliases"]}
clash = {}
for n, v in dup["same_name"].items():
    for f, _ in v:
        clash.setdefault(f, []).append(n)

def safe(s):
    return re.sub(r'[<>:"/\\|?*]', "", s).strip().rstrip(".") or "Unnamed"

def fmt(v):
    return "–".join(map(str, v)) if isinstance(v, list) else str(v)

def stat_block(stats):
    lines = []
    for k, v in stats.items():
        lines.append(f"| {STAT.get(k, k)} | {fmt(v)} |")
    return ["| Stat | Value |", "|---|---|"] + lines

if os.path.exists(OUT):
    shutil.rmtree(OUT)
os.makedirs(OUT)
index_rows, counts = [], {}
for r in walk:
    members = [by_id[s] for s in r["sprites"]]
    title = r["names"][0] if r["names"] else f"Unnamed {r['family']}"
    folder = os.path.join(OUT, SLOT_NAME[r["slot"]], f"{r['n']:03d} {safe(title)}")
    os.makedirs(folder, exist_ok=True)
    counts[r["slot"]] = counts.get(r["slot"], 0) + 1
    fam_sprites = []
    for it in members:
        sid = it["id"]
        shutil.copy2(J("items", it["sprite"]), os.path.join(folder, sid + ".png"))
        era = "legacy" if sid.endswith("_legacy") or it["era"] == "legacy" else "reloaded"
        svg = J("extracted/sprites", era, "svg_idle", re.sub(r"_legacy$", "", sid) + ".svg")
        if os.path.exists(svg):
            shutil.copy2(svg, os.path.join(folder, sid + ".svg"))
        flags = []
        if sid in legacy_pairs: flags.append(f"older art of {sid[:-7]}")
        if sid + "_legacy" in by_id: flags.append("an older _legacy drawing also exists")
        if sid in alias: flags.append("identical art to " + ", ".join(sorted(set(alias[sid]))))
        fam_sprites.append({"sprite": sid, "names": it["names"], "era": it["era"], "element": it["element"],
                            "quality": it["quality"], "anchors": it["anchors"], "stats": it["stats"],
                            "review": it["review"], "flags": flags})
    info = {"n": r["n"], "family": r["family"], "slot": r["slot"], "names": r["names"], "element": r["element"],
            "era": r["era"], "warnings": (["Same sprite was both a side weapon (Resistance drainer) and a top weapon (A-ray)."]
                                          if r["family"].startswith("blaster15") else []) +
                                         [f"Name also used by another family: {n}" for n in clash.get(r["family"], [])],
            "sprites": fam_sprites}
    json.dump(info, open(os.path.join(folder, "info.json"), "w", encoding="utf8"), indent=1)

    md = [f"# {title}", "", f"- **Slot:** {SLOT_NAME[r['slot']]}", f"- **Family id:** `{r['family']}` (#{r['n']})",
          f"- **Element (source data):** {r['element'] or 'unknown'}", f"- **Era:** {', '.join(r['era'])}",
          f"- **Original names:** {', '.join(r['names']) or 'none'}", ""]
    for w in info["warnings"]:
        md.append(f"> [!warning] {w}")
    if info["warnings"]:
        md.append("")
    for s in fam_sprites:
        md += [f"## {s['sprite']}", "", f"![[{s['sprite']}.png]]", ""]
        if s["names"]: md.append(f"- **Names:** {', '.join(s['names'])}")
        if s["quality"]: md.append(f"- **Art quality:** {s['quality']['flag']}")
        for fl in s["flags"]: md.append(f"- **Note:** {fl}")
        if s["review"].get("note"): md.append(f"- **Your review note:** {s['review']['note']}")
        md.append("")
        st = s["stats"]
        if "reloaded" in st:
            md.append(f"**Reloaded stats** (tier range {st['reloaded'].get('transform_range')})")
            md.append("")
            for tier, blk in st["reloaded"]["tiers"].items():
                md.append(f"*{tier.title()}*")
                md.append("")
                md += stat_block(blk.get("max", blk["base"]))
                md.append("")
        for lg in st.get("legacy", []):
            md += [f"**Legacy stats: {lg['name']}**", ""] + stat_block(lg["stats"]) + [""]
        if not st:
            md += ["*No stats in the item packs.*", ""]
    open(os.path.join(folder, "info.md"), "w", encoding="utf8").write("\n".join(md))
    index_rows.append((SLOT_NAME[r["slot"]], r["n"], title, len(members), os.path.relpath(folder, OUT).replace("\\", "/")))

json.dump(sel, open(os.path.join(OUT, "items.json"), "w", encoding="utf8"), indent=1)
readme = ["# Chosen items", "", f"{len(walk)} item families, {len(sel)} sprites. Each family folder has the sprites (`.png` 2x, `.svg`), `info.json` and `info.md`.", "",
          "| Slot | Families |", "|---|---|"] + [f"| {SLOT_NAME[s]} | {c} |" for s, c in counts.items()] + ["", "## All families", "",
          "| # | Slot | Name | Sprites |", "|---|---|---|---|"] + \
         [f"| {n} | {slot} | [[{path}/info\\|{name}]] | {k} |" for slot, n, name, k, path in index_rows]
open(os.path.join(OUT, "README.md"), "w", encoding="utf8").write("\n".join(readme))
print(len(walk), "families", len(sel), "sprites ->", OUT)
