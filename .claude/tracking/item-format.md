# Unified item format (DRAFT)

## What the source data looks like
**Legacy (936):** one flat `stats` block. Small numbers: Laser Cannon has weight 8, phyDmg 30–30, range 0–2. No tiers.
**Reloaded (214):** per-tier blocks `common…divine` plus `max_<tier>`. Each block only lists the stats that **change** from the previous one, so they have to be merged in order. Big numbers: BackBreaker (Epic) has weight 44 and phyDmg 73–125. It also has `eneCost/heaCost`, `backfire`, movement stats, and `tags` (melee, etc.).

Stat keys that appear in both: weight, health, eneCap/eneReg, heaCap/heaCol, phy/exp/eleRes, phy/exp/ele Dmg, eneDmg, heaDmg, range, push, pull, uses, *ResDmg, *CapDmg, *RegDmg/ColDmg.
Legacy only: bulletsCap, rocketsCap.
Reloaded only: eneCost, heaCost, backfire, walk, jump, retreat, advance, recoil.

**Watch out:** Legacy weapons have `heaDmg`/`eneDmg` but no `heaCost`/`eneCost`. The field names are the same, but in Legacy they may have meant self-cost. Check against the decompiled client before merging.

## Proposed format

```jsonc
{
  "id": "legacy:laser_cannon",       // string ID with an era prefix, so the two packs' numbers can't clash
  "name": "Laser Cannon",
  "era": "legacy",                   // "legacy" | "reloaded" | "custom"
  "slot": "side_weapon",             // torso, legs, side_weapon, top_weapon, drone, module, kit, shield, hook, teleporter, charge
  "element": "physical",             // physical, explosive, electric, combined, none
  "tags": ["melee"],
  "art": { "symbol": "laser1", "attach": { "x": 34, "y": 55 } },

  "tiers": {                         // always present. A Legacy item = one tier (or tiers we design)
    "common": {
      "base": { "weight": 8, "phyDmg": [30, 30], "range": [0, 2] },   // full stat block, already merged
      "max":  { "phyDmg": [36, 36] }                                  // stats at max level (optional)
    }
    // "rare": {...}, "epic": {...} …
  },
  "tierRange": ["common", "common"], // lowest and highest tier the item can reach

  "sources": { "pack": "legacy-items-pack", "originalId": 1 }  // where the data came from
}
```

### Rules
1. **Full stats at every tier:** the converter merges the Reloaded tier changes in order, so the game never has to.
2. **One stat vocabulary.** Keep the community key names (`phyDmg`, `heaCap`…). Ranges stay as `[min, max]`.
3. **Levels between base and max** are worked out in code: linear per level, matching the original game (verify against the client).
4. **Balance is kept separate from data.** Raw imported stats stay untouched. Any rescaling goes in a separate `balance` layer, so we can re-tune without re-importing.

## DECIDED (2026-09-25)
- **Full transformation for every item, Legacy included** (Common → Divine). Campaign difficulty scales up to match.
- Legacy tier ladders are generated from the Reloaded growth curve measured from the Enegg data (median ratios):

| Step | Damage | Health | Weight |
|---|---|---|---|
| common → rare | ~1.9 | 1.90 | ×1 |
| rare → epic | 1.69 | 1.71 | ×1 |
| epic → legendary | 1.62 | 1.55 | ×1 |
| legendary → mythical | 1.51 | 1.45 | ×1 |
| mythical → divine | 1.38 | 1.47 | ×1 |
| base → max within a tier | 1.31–1.63 (smaller at higher tiers) | 1.41–2.0 | |

Weight never changes with tier.

## Still open
- Starting tier for Legacy items. The pack marks all of them "C", which is a placeholder. Idea: assign by power compared with similar items (normalise first, and remember the 5–10× scale gap).
- ~~Legacy-only mechanics~~ **Decided:** no ammo (infinite bullets and rockets); kits are power kits only.
- ~~Legacy `heaDmg`/`eneDmg` meaning~~ **Resolved:** the Legacy client (`BMItemData`) has separate `damageHeat`/`damageEnergy` (applied to the **opponent**, `BMScreenBattle.as:2018`) and `costHeat`/`costEnergy` (the attacker's own cost, `:1967`). The pack's `heaDmg`/`eneDmg` = damage to the enemy, the same meaning as in Reloaded, and it matches the elements (explosive → heat, electric → energy). **Gap:** the Legacy pack has no `costHeat`/`costEnergy`, so Legacy weapon self-costs must be designed (Legacy used bullets/rockets ammo instead).
- Legacy items have `upgradeToItemID`: Legacy variant families were **upgrade chains** (item N upgrades into item N+1 with gold plus power). This confirms the family grouping idea.

## Superseded options
- **Scale gap:** Legacy stats are roughly 5–10× smaller than Reloaded. Options:
  a) Rescale Legacy up to Reloaded scale.
  b) Leave Legacy as early-game gear and let the campaign progression cover the gap.
  c) Give Legacy items their own tier ladders (Legacy items that can transform).
- Do Legacy items get transform paths?
- Drop Legacy-only mechanics (bullets/rockets capacity, kits), or keep them?

## Tiers, tuning and divining (user idea, draft, 2026-09-25)
- Tier ladder: Common → Rare → Epic → Legendary → Mythical → **Ultimate** (replaces Divine as a tier).
- **Levels:** Mythical has 50 upgrade levels. **Ultimate has 100.** Reaching Ultimate is a big jump, and the long upgrade grind is the endgame. Ultimate stats at levels 1 and 100 are not in the data, so we extrapolate them (Mythical→Divine step ≈ ×1.38 as a starting point for the Ultimate base).
- **Ultimate scaling = option A** (the same gain per level as Mythical, over 100 levels, so level 100 is about ×1.7 of maxed Mythical). **Why:** deep in the campaign most enemy bots are Ultimate and tuned, so the player needs that headroom. Enemy gear scales with campaign depth.
- **Ultimate unlocks tuning**, modelled on Asphalt 8's Elite tuning (Elite Mapping):
  - A8 reference: each stat 0 to +8 points, at most 16 points total (for example 2 stats maxed), with a trade-off budget. The car "depletes" after about 4–5 races and needs a tune-up (about 1,750–2,000 credits, fixed price). Racing without one drops the rank sharply, but upgrades are never lost.
  - Ours: a tuning point budget spread across 3–4 stats per item type. A tune depletes after N battles, and a paid tune-up refills it. A depleted tune only turns off the bonus; nothing is lost.
- **Divine = an action:** it permanently locks the current tune (no more depletion). Visual: the Ascended `E` sprite and the `mcGlow` firing glow.
- **Items with no variants** = unique items, always at their top tier (Ultimate), only from event loot boxes.
- **Tuning template, Platinum Plating (draft, 2026-09-26):**
  - Budget 16 points, 0–8 per stat. **Every point is a trade-off.**
  - The user set which way each trade-off goes; the numbers are proposals:
    - **Health:** +1.5% HP per point, costs +0.5 weight
    - **Physical resistance:** +2 per point, costs −0.5% HP and +0.5 weight (heavier, confirmed)
    - **Weight reduction:** −1 weight per point, costs −0.75% HP
  - Example on Ultimate level 100 (540 HP / 40 weight): max HP = 605 HP / 44 weight; max lightness = 508 HP / 32 weight.
  - **Approved by the user (2026-09-26).** "HP 8 + lightness 8" beating untuned on both is fine. Max tuned HP is 605 (HP 8, 44 weight).
- **Platinum Plating ladder (approved):** Legendary 165→221, Mythical (50 levels) 240→315, Ultimate (100 levels) 332→~540, weight 40.
- **Tungsten Carbide Plating (approved 2026-09-26):**
  - The heavy alternative to Platinum Plating, not a replacement.
  - HP = Platinum × 1.35; weight 55 at every tier (Platinum is 40).
  - Sprites `HP11`–`HP15` map to Common, Rare, Epic, Legendary and Mythical/Ultimate.
  - Ladder: Common 40→72, Rare 81→130, Epic 142→196, Legendary 223→298, Mythical (50 levels) 324→425, Ultimate (100 levels) 448→~730.
  - Same tuning template as Platinum; max tuned HP is ~815 at 59 weight.
- **Tuning is written in percentages** so one template fits every weight: main stat +1.5%/point for +1.25% weight; the bonus stat costs −0.5% main stat and +1.25% weight; weight reduction is −2.5% weight/point for −0.75% main stat. The plate numbers are the same rule.
- **Energy Mass Booster (approved 2026-09-26):** regen only, weight 15.
  - Common 6→10, Rare 12→18, Epic 21→29, Legendary 33→45, Mythical 48→63, Ultimate 65→~106.
  - Epic–Divine comes from Reloaded; Common and Rare are extrapolated.
- **Heavy Energy Booster (gold, approved):** regen ×1.35, weight 22.
  - Common 8→14, Rare 16→24, Epic 28→39, Legendary 45→61, Mythical 65→85, Ultimate 88→~143.
- **Booster tuning (approved):** regen / energy capacity (+3 per point, max +24) / weight reduction, using the percentage template.
  - Max tuned regen: 119 blue, 160 heavy.
  - **Why capacity:** some weapons damage energy capacity directly, so a capacity buffer is a real defensive choice.
- **Energy Engine (approved 2026-09-26):** Epic → Ultimate only, weight 25.
  - Capacity / regen: Epic 32→44 / 14→20, Legendary 48→65 / 22→30, Mythical 68→89 / 32→42, Ultimate 92→~149 / 44→~72.
- **Ultimate Energy Engine (gold, approved):** ×1.35, weight 34.
  - Epic 43→59 / 19→27, Legendary 65→88 / 30→41, Mythical 92→120 / 43→57, Ultimate 124→~201 / 59→~97.
- **Two-stat tuning template (approved):**
  - capacity: +1.5% per point, costs +1.25% weight
  - regen: +1.5% per point, costs −0.5% capacity and +1.25% weight
  - weight reduction: −2.5% per point, costs −0.75% of each main stat
- **Energy Storage Unit (approved 2026-09-26):** capacity only, Legendary → Ultimate, weight 22.
  - Legendary 72→97, Mythical 102→134, Ultimate 141→~229.
  - Tuning: capacity / regen bonus (+1.5 per point) / weight; max tuned capacity ~256.
- **Heavy Energy Storage Unit (gold, approved):** ×1.35, weight 30.
  - Legendary 97→131, Mythical 138→181, Ultimate 190→~309; max tuned capacity ~346.
- **Heat modules (approved 2026-09-26):** identical to energy, with capacity → heat capacity and regen → cooling.
  - Cooling Mass Booster / Heavy Cooling Booster, Heat Engine / Ultimate Heat Engine, Heat Storage Unit / Heavy Heat Storage Unit.
  - Full tables are in `Plans/Modules/Module Roster.md`.
- **Combined modules (saved 2026-09-26):** Mythical drops only, stats 1.6× Reloaded, Heavy (gold) ×1.35 more.
  - Full tables are in `Plans/Modules/Module Roster.md`.
  - **Balance check pending:** simulate stacking once Ultimate weapon stats are set; an equip limit is only needed if stacking wins too easily.
- **Resistances (locked 2026-09-26):**
  - Resistance Module: Epic → Ultimate, weight 28 (All 51). Single Ultimate 63→~102; All 41→~77 each.
  - Enhanced Protector: Mythical drop, 1.6× the module, same weights. Single Ultimate 101→~163; All 66→~123.
  - Fortress: Legendary → Ultimate, weight 40, Ultimate 166→~271 HP + 63→~102. Defence Matrix: weight 60, 183→~335 HP + 41→~77 each.
  - Ultimate Protector (gold, ×1.35 over Enhanced) is agreed; its art and roster entry are pending.
- **Balance data point: Falcon (2026-09-26).**
  - Falcon: physical top weapon, range 8, 1 use.
  - Reloaded Divine: 629–1052. Ultimate level 100 ≈ 1,019–1,704; tuned (+12%, weapon tuning TBD) ≈ 1,141–1,908, about 1,525 on average.
  - Rough maxed Ultimate mech HP ≈ 4,800 (top torso ~2,900 + legs ~800 + 2 Platinum Plating ~1,080), so one Falcon shot ≈ 30% (20–25% with a resistance build).
  - One-shots happen against under-geared or already damaged mechs; that gear gap is the intended late-campaign threat.
  - Stacked Heavy Enhanced Protectors (~440) cut a Falcon hit by only about a third, so high resistance is survival, not immunity.
- Open: budget size, tunable stats per type, battles per tune, costs, currency, whether Divine can be undone, early-game balance of unique items.

## Roster review notes (from the user)
- **Unclicked items in a finished slot = not kept.** Torsos are done: 110 keep, 19 drop, 3 maybe, 91 unclicked.
- **Reused art:** Grim Reaper's tier looks (`torso70B→E`) reuse the Legacy torsos **HellFire Armor** (`torso46`) and **Metrolens** (`torso47`). The user kept the originals as their own items and left the Grim Reaper set out. Kept Legacy torsos climb their own ladder like everything else.
- **Special pathway: Brutality → God Mode.** God Mode (`torso1000`) is reached **through Brutality** (`torso52`, whose sprite the pack also names "God Mode"). It is an evolution path, not a normal drop or transform. Details (cost, tier requirement) still to design. **Player-side item, plus bosses:** regular enemy bots never use God Mode, but it **appears on a boss** (the fight that teases the Brutality → God Mode path). It is a **Mythical** torso whose identity is **ultra-high health**. Open: whether it can go beyond Mythical (Ultimate, tuning) or stays capped.
- **Legs reviewed:** 73 keep (updated), 1 drop (Yoshimo Legs), the rest unclicked (not kept). Notes:
  - **Lightning Supporters (`leg73C–E`):** "To be redone for heat and physical". Make **heat and physical element versions** of this electric leg (new variants with recolored art and element stats).
  - GOD MODE legs (`leg1000`) kept, paired with the God Mode torso.
  - Sparked Runners (`wheels66D/E`, electric, blue): full set kept. Needs **heat (red) and physical (yellow) versions**.
  - **Unnamed jump leg (`leg74A–D`)**: kept; the user will name it later. The existing yellow-orange art is the **physical** version. Needs **energy (electric) and heat (explosive) versions** (recolored accents plus element stats), making a full set of 3.
- **Element recolor queue** (after review): Lightning Supporters → heat and physical; `leg74` (physical) → energy and heat; Sparked Runners → heat and physical; The Claw (`leg77D/E`, physical) → heat and energy; **weapons:** Apocalypse Mark III (`cannon1C`) → heat and energy; Wipeout Mark III / Frantic Brute (`cannon7C2`) → heat and energy; Abomination (`sideSuperRocketLauncher2E`) → heat and energy; NightFall (`sideVulcan1E`) → heat and energy; Spartan Carnage (`topSuperMachineGun1E`) → energy and heat; Desert Fury (`topSniper1D/E`) → heat only (Valiant Sniper already covers electric); Vandal Rage (`topBlaster2C–E`) → physical. Color key: physical = yellow, heat/explosive = red/orange, energy/electric = blue.
- **Kits: power kits only (28), on purpose.** HP, resistance, heat and energy are already covered by the many kept modules, so the other kit types (160) are left out.
- **Updated God Mode = `torsoBoss5A–C` + `legBoss5A–C`.** A spiked redesign of God Mode (`torso1000`/`leg1000`) with a skull emblem and 3 color looks (orange, blue, …). Kept in boss parts. Other kept boss sets: `torsoBoss3A–C` (skull-chest humanoid), `sideBoss2/3/4 A–C` (blade arms). Also kept: `torsoBoss4A–C` + `legBoss4A–C` (T-rex boss, yellow/red/blue eyes) and `torsoBoss6A–C` (big dome skull head, yellow/red/blue). Boss parts: 27 kept.
- **Slot fix (2026-09-25):** 24 weapon sprites (Wipeout/Frantic `cannon7*` forms, `cannon11*` Plasma/Energy/Laser Cannons, `blaster22–24C`, `grenadeLauncher1*`, `laser40B3`, `cannon9B`) were wrongly in side weapons and are now top weapons. Variants now inherit their family's slot (`tools/sort_items.py`). Side 501 / top 231.
- **Shared sprite:** `blaster15A/B` was two items: *Resistance drainer* (side) and *A-ray* (top). Kept under side weapons; decide whether to keep both.
- **Enhancers and perks: dropped (user, 2026-09-25).** They don't fit this game. No enhancer or perk slot.
- Maybe torsos (`torso26`, `torso26B`, `torso36`): dropped.
- **Duplicate check (2026-09-25, `data/duplicate_report.json`):** 74 kept sprites carry more than one item name (mostly Legacy "Mark N" upgrade steps sharing art); only `blaster15` spans two slots (A-ray / Resistance drainer). 25 sprites are kept together with their `_legacy` redraw. Identical art reused across eras: Lava Spray (`flameThrower9*`) = Reloaded Super Flamethrower 2D/E and 3D/E; Piercing Shotgun (`shotgun2*`) = Reloaded Super Shotgun 1–3 D/E; Charge Mark = charge bases; Armor Tank = `torso53`/`leg33`. Name clashes: "Shockwave" (drone + sword), "Rail Gun" (drone + laser).
