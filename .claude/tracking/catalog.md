# Asset catalog

## Sources in `extracted/`

| Folder | What | Date | Era |
|---|---|---|---|
| `old/flash-2017-03-23/` | Flash web client, 8 SWFs (from the Wayback Machine) | 2017-03-23 | Legacy (last one before transformation) |
| `early-reloaded/supermechs-2.411/` | Unzipped Android APK | 2017-05 | First Reloaded build |
| `transform/supermechs-7.628.4/` | Unzipped Android APK | 2023-05 | Final Reloaded build |
| `data/legacy-items-pack.json` | Community item stats for Legacy (ctrlraul, Workshop) | | Legacy |
| `data/enegg-items.json` | Community item stats for Reloaded, with stats for every tier (Enegg/Item-packs v3) | | Reloaded |

## SWF layout (the same in all builds)
- `bmmClient(CC).swf`: game code (AS3). Talks to the server via `/services/amfphp/gateway.php`.
- `generalLibrary(.Ext).swf`: UI, effects, backgrounds.
- `itemsLibrary1-3.swf`: item art. Mostly **vector** sprites, so export as sprites or shapes, not images.
- `soundsLibrary_sound.swf`, `soundsLibrary_music.swf` (Flash) or `music*.mp3` (APK).

## Key finding: item stats are NOT in the game files
The client only has the art. Names and stats came from Gato's server, so we rely on the community item packs:
- **Legacy pack:** 936 items. **922 of 936 have art in our 2017-03 SWFs.** The 14 missing: `cannon7C2`, `module_cooling1`, and the `leg/torso1002_*` and `1003_*` variants. The community image repo has PNGs for those.
- **Reloaded pack:** 214 items with stats for every tier (common → divine). Only 3 names overlap with the Legacy pack, so the two rosters are almost completely separate.

### Legacy pack breakdown (936)
Side weapons 227 · modules 190 · top weapons 126 · kits 90 · torsos 86 · legs 61 · drones 59 · shields 42 · grappling hooks 21 · teleporters 17 · charge engines 17
Elements: Other 405 · Physical 207 · Explosive 187 · Electric 137

### Reloaded pack breakdown (214)
Side weapons 79 · top weapons 35 · drones 29 · torsos 24 · modules 24 · legs 15 · hooks 3 · teleporters 3 · charge 2
Tier ranges: L–D 117 · E–D 72 · R–D 7 · C–D 6 · R–E 5 · M–D 4 · C–E 2 · L–L 1

## Art symbol counts (`symbols/*.txt`)
| Build | Item symbols |
|---|---|
| Legacy 2017-03 | 1127 |
| Reloaded 2.411 | 1130 (almost identical to Legacy: the art didn't change at the switch) |
| Reloaded 7.628.4 | 2554 (Legacy art plus the new Reloaded items, torso and leg variants, enhancers, clan items) |

Symbols by year (from the Wayback Machine): 2013: 736 → 2014: 997 → 2015: 1054 → 2016: 1125 → 2017: 1507 → 2018: 2438 → 2024: 2556.
Only about 13 real Legacy art symbols are missing from 7.628.4 (`leg34`, `torso25B`, `torso54`, and some shadows). So **7.628.4 has almost all art for both eras**.

## Gaps / next
- The Reloaded art (2554 symbols) goes well beyond the 214 items in the stats pack. Some Reloaded items may have no stats data. Check Workshop Unlimited's default pack and other community sources.
- Battle formulas and rules live in the client code. Decompile `bmmClient.swf` with JPEXS (`-export script`) when we write the game plan.
- Sprite export: use JPEXS `-export sprite` on the item libraries. The community already has PNGs: `github.com/ctrlraul/supermechs-item-images` (legacy/png 1102, reloaded/png 220, reloaded/svg 62).

## Sprites exported (2026-09-25)
`extracted/sprites/<legacy|reloaded>/<png|svg>/<symbol>.*`. PNG at 2×, SVG vector. Script: `tools/organize_sprites.py` (it flattens the JPEXS output).
- Legacy: 1110 sprites (PNG 26 MB, SVG 36 MB). Reloaded: 2524 sprites (PNG 68 MB, SVG 71 MB). No multi-frame sprites.
- Companion symbols: `*_shadow` (drop shadows) and `*_mask` (probably tint or damage masks).
- **Tier variants are just recolors:** `torso1002` / `_1` / `_2` / `_3` have the same shape, with only the accent panels changed (gold → orange → red → blue). See `extracted/sprites/_preview_tier_variants.png`. So tier looks can be made by recoloring accent colors (easy on the SVG), with no new drawing.

## Legacy campaign (hard-coded in the 2017-03 client, `BMDataManager.as` around line 7127)
7 zones, **76 missions** (7 of them bosses), 7 item-box reward spots, difficulties Normal / Hard / Insane.
| # | Zone | Regular | Special* | Boss |
|---|---|---|---|---|
| 1 | Desert | 5 | 1 | RAMBOY |
| 2 | Forest | 6 | 4 | EXTERMINATOR |
| 3 | Sea | 6 | 3 | CYBER GOAT |
| 4 | Snow | 6 | 4 | MOLOTOV |
| 5 | Lava | 7 | 3 | SABERTOOTH |
| 6 | Wasteland | 10 | 5 | SENIOR QUADS |
| 7 | Tower | 7 | 2 | BIGBOY |
*Missions with a `false` flag and an extra type number (2 or 3). Likely the special battles against a jeep, tank or turret (the code has `ENEMY_TYPE_JEEP`, `ENEMY_TYPE_TANK` and `missionBaseMap_jeep/tank/turret`). Not confirmed.
Bosses have fixed loadouts (item IDs) and fixed stats via `setFixedProperties(hp…)`. HP grows 200 → 700.
The Reloaded campaign has chapters (`_totalChapters`, `BMMissionDefinitionRepository`), probably loaded from the server. Not extracted yet.

## Paint layer (`mcColor`), found 2026-09-28
- The white areas on many Reloaded sprites (1,266 have an `mcColor` layer, 159 of them `E` looks) are **not white in the game**. They are the **mech paint layer**: `BMDataManager.colorItemGrp` tints `mcColor` with the player's chosen paint colour (`colorsDB`, OVERLAY blend), or with a camo pattern (ID 500+, `ColorPattern<n>`). Our exports show the unpainted base, which is white.
- Paint colours (`colorsDB`): 1 #ea5ca4, 2 #6b54ea, 3 #0180f5, 4 #688d01, 5 #a26d5f, 6 #f5eb00, 7 #c1a418, 8 #e90101, 9 #ffffff, 11 #9aa797, 12 #647869, 13 #716f5a, 14 #816d3b, 15 #a17809, 16 #d3ac43, 17 #e2c22a, 18 #ff9900, 19 #dc2a2a, 20 #940000, 21 #202020.
- The layer is kept separately in `extracted/sprites/reloaded/layers/<id>.mcColor.svg`. Decompiled scripts (temporary): session scratchpad `scripts/`.

## Team campaigns and maps (Reloaded client, found 2026-09-28)
- Reloaded had **story campaigns in 1v1, 2v2 and 3v3**: `BMSinglePlayerManager` story IDs 0 = 1v1, 1 = 2v2, 3 = 3v3, 2 = raid; `MECHS_PER_STORY_ID = [1,2,1,3]` (mechs per player). 3v3 unlocks at player level 20 (`levelRequired3V3`, server-set). Missions and enemy loadouts came **from the server** (`PvPWinsRequiredStoryID<n>Slot<m>` settings), so they are not in the files.
- **World maps** in `generalLibraryExt.swf`: three 7-part maps, `worldMapPart1–7`, `worldMap2Part1–7`, `worldMap3Part1–7` (probably 1v1 / 2v2 / 3v3). Parts 1–6 are 800px wide and part 7 about 1015px (the final zone). All saved to `Plans/Zones/reference/reloaded-worldmaps/`, with contact sheets in `_sheet-map1/2/3.png` (same folder).
- **Extra battle background** `Grp_background_100`: a candy/rainbow fantasy scene (event map?). Reloaded backgrounds 1–9 match Legacy.
- All saved in `Plans/Zones/reference/` (legacy-worldmap, legacy-battle-backgrounds, reloaded-worldmaps, reloaded-battle-backgrounds).
