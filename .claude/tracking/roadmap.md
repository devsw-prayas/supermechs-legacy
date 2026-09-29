# Roadmap

## Phase 1: Catalog ✅
Files extracted, sprites exported (idle, layers, anchors), item packs found, Legacy campaign read.

## Phase 2: Item lists (in progress)
1. ✅ Design decisions: tiers up to Ultimate, 100 levels, tuning, divining, variant families, unique event items
2. ⬜ **Stat formula:** base stats per tier, per-level growth, Ultimate 1–100, tuning budget
3. ✅ Legacy `heaDmg`/`eneDmg` = damage to the enemy (self-costs missing from the pack, must be designed)
4. ⬜ **Converter script** → `data/items.json`, the master list (both packs, merged, full tier ladders, sprite and anchor links)
5. ✅ Roster review done: 886 sprites / 351 families kept (`data/items_selected.json`)

## Phase 3: Game plan
1. ⬜ **Zone list:** 19 zones (themes, order, the 7 Legacy zones as a base)
2. ⬜ **Bosses:** 20 bosses (loadouts, stats, what's special), plus variants for 2v2 and 3v3
3. ⬜ Mission layout per zone: regular, huntdowns, boss, rewards
4. ⬜ **Battle rules**, taken from the decompiled client: damage, heat, energy, movement, resistances, AI
5. ⬜ Economy: credits, tokens, drop tables, transform and upgrade costs, tuning upkeep, divine cost
6. ⬜ Enemy gear curve by zone and format; Ultimate mode tuning and divine frequency
7. ⬜ Events and loot boxes (unique items)
9. ⬜ **Test Lab (sandbox mode):** build any mech from every item in the game (all tiers, max level) and fight any bot or boss. Open questions: unlocked from the start or after a zone; which bots are listed (all enemies and bosses met so far, or everything); stat readouts (damage log, DPS, heat/energy over turns); save and share test builds; no rewards and no effect on progress.
8. ⬜ **Balance check: stacked combined modules and stacked resistance** (incl. Heavy Enhanced Protectors vs 1,200+ scope hits) vs a normal mech, once Ultimate weapon damage and energy/heat costs exist. Decide on an equip limit (see Plans/Modules/Module Decisions.md).

## Phase 4: Build (only after the plan is agreed)
1. Project setup: git repo, Next.js app, Neon database, Google and Discord login
2. Data layer: load `items.json`, save schema (inventory, loadouts, progress)
3. Mech builder (hangar)
4. Battle engine (plain TypeScript, tested against the original's rules) + renderer
5. Campaign map, missions, huntdowns
6. Upgrades, transformation, tuning, divining
7. Ultimate mode, events, polish
8. Test Lab: sandbox builder over the full roster + bot picker, reusing the mech builder and battle engine
