"""Flatten chosen/Side Weapons into one Obsidian note: Plans/Side Weapons/Side Weapons.md.
Sprites go to Plans/Side Weapons/sprites/ (existing files are kept: they may be painted)."""
import json, re, shutil
from pathlib import Path

SRC = Path("chosen/Side Weapons")
OUT = Path("Plans/Side Weapons")
SPR = OUT / "sprites"
SPR.mkdir(parents=True, exist_ok=True)
DONE = re.compile(r"^(sword\d|sideSuperSword|sideAxe|sideHammer|hammer1|sideGrinder|blaster[345]|blaster15|"
                  r"sideSuperBlaster|sideBulletSprayer|sideLaser|laser3[02]|sideMegaBlaster|sideDistanceCloser)")
DROPPED = re.compile(r"^axe\d")

def natkey(s):
    return [int(t) if t.isdigit() else t for t in re.split(r"(\d+)", s)]

def fmt_stats(sp):
    rows = []
    for era, lst in (sp.get("stats") or {}).items():
        if isinstance(lst, dict) and "tiers" in lst:
            for t, v in lst["tiers"].items():
                mx = v.get("max") or v.get("base") or {}
                rows.append(f"Reloaded {t} (max): " + ", ".join(f"{k} {x}" for k, x in mx.items()))
            continue
        for e in lst if isinstance(lst, list) else [lst]:
            st = ", ".join(f"{k} {v}" for k, v in (e.get("stats") or {}).items())
            rows.append(f"{e.get('name','?')} ({era}): {st}")
    return rows

lines = ["# Side Weapons", "",
         "All kept side weapon sprites on one page, in family order. Stats come from the community packs.",
         "✅ = decided ([[Melee Decisions]], [[Blaster Decisions]]), ⬜ = still to plan, ❌ = dropped. "
         "Never-marked weapons: [[All Side Weapons]].", ""]
count = 0
for fam in sorted(SRC.iterdir(), key=lambda p: natkey(p.name)):
    if not fam.is_dir():
        continue
    info = json.loads((fam / "info.json").read_text(encoding="utf-8"))
    ids = [s["sprite"] for s in info["sprites"]]
    mark = "❌" if DROPPED.match(ids[0]) else "✅" if any(DONE.match(i) for i in ids) else "⬜"
    lines += [f"## {mark} {fam.name}", ""]
    for sp in sorted(info["sprites"], key=lambda s: natkey(s["sprite"])):
        png = fam / f"{sp['sprite']}.png"
        if not png.exists():
            continue
        if not (SPR / png.name).exists():
            shutil.copy2(png, SPR / png.name)
        count += 1
        names = ", ".join(sp.get("names") or []) or "unnamed"
        lines.append(f"![[Side Weapons/sprites/{png.name}|96]] **{sp['sprite']}**: {names}")
        for r in fmt_stats(sp):
            lines.append(f"- {r}")
        lines.append("")
(OUT / "Side Weapons.md").write_text("\n".join(lines), encoding="utf-8")
print(count, "sprites")
