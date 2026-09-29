# Zone 8: The Junkyard (draft)

> *Where broken mechs go to die, and where the ones that refuse to stay dead are rebuilt from the pieces.*

## Identity
- **Theme:** a vast scrapyard of wrecked mechs, rusting cranes, crusher presses and burning oil pits. Bots here are **patched together from salvage**: mismatched parts, sparking wires, weapons that barely work.
- **Look:** rust brown and oil black ground, orange sodium lamps, sparks, a magnet crane in the background, piles of broken torsos (reuse Legacy and Reloaded torso sprites as background props).
- **Mood / music:** industrial, clanking, grinding metal.
- **Where it sits:** after the Legacy campaign's early zones, when the player reaches **Epic** gear. Placeholder slot 8.

## Gameplay hook: "It barely works"
Almost every enemy weapon here **backfires, recoils or pushes the user around**. The zone teaches the player to:
- read **self-damage** (enemies weaken themselves, so long fights favour the player);
- handle **forced movement** (enemies jump back, charge in, get pushed by their own shots);
- punish enemies that **overheat themselves** (heat-costly scrap guns).

**Zone rule (flavour):** scrap bots start each fight with **−10% HP** (they're falling apart) but **+1 use** on limited-use weapons.

## Enemy element bias
Mixed, leaning **physical and explosive** (rust and fire). Electric bots appear late in the zone (a short-circuit sub-area).

## Enemy roster (from our side-weapon list)
| Role | Signature weapons |
|---|---|
| Scrap gunners | Unrepaired Laser Cannon, Cracked Plasma Cannon, Obsolete Energy Cannon (step back + backfire) |
| Scrap blasters | Malfunctioning Blaster, Rusty Heat Blaster, Scrapped Energy Blaster (long-range backfire) |
| Wreckers | Sacrifice Cannon, Broken Devourer, Drunk Lightning (one big shot) |
| Hit-and-run | Iron Retreat / Explosive Retreat / Evac Spark Mark I |
| Brawlers | Rock / Magma / Lightning Recoiler, Disintegration / Lava Sparks / Plasma Rain |
| Grinders | Rock Polisher, Basalt Polisher, Lightning Cutter |

Enemy gear: **Epic** at the start of the zone → **Legendary** by the boss (1v1 pass). Later passes (2v2, 3v3) push it up per the enemy gear curve (Phase 3.6).

## Missions (11)
| # | Mission | Type | Notes |
|---|---|---|---|
| 8-1 | The Gate | Regular | 1 scrap gunner, tutorial on backfire |
| 8-2 | Rust Row | Regular | 2 waves of scrap gunners |
| 8-3 | Crusher Lane | Regular | brawlers with recoil shotguns |
| 8-4 | Oil Pits | Regular | explosive-heavy, heat pressure |
| 8-5 | **Junk Jeep** | Special | salvage jeep (Legacy jeep enemy type) |
| 8-6 | The Magnet Crane | Regular | hit-and-run rocket bots |
| 8-7 | Wreckers' Yard | Regular | one-shot Wreckers; teaches spacing |
| 8-8 | Short Circuit | Regular | first electric scrap bots |
| 8-9 | **Scrap Tank** | Special | tank enemy type, heavy backfire blasters |
| 8-10 | The Press | Regular | elite: Mark II retreat rockets + grinders |
| 8-11 | **Boss: SCRAPLORD** | Boss | see below |

## Boss: SCRAPLORD
A towering mech welded from a dozen wrecks. Reuse or recolour a boss torso (see `Boss Parts`); rusted palette.
- **Loadout idea:** Malfunctioning Blaster (backfire, unlimited) + Sacrifice Cannon (big one-shot) + Iron Retreat Mark II (escape) + Rock Polisher (melee).
- **Gimmick: "Spare Parts".** At 50% HP it **repairs itself once** (+25% HP) and swaps to its explosive loadout (Rusty Heat Blaster, Broken Devourer, Explosive Retreat Mark II, Basalt Polisher). The player has to beat it twice in one fight.
- **Fixed stats** like Legacy bosses (`setFixedProperties`), HP to be set with the balance pass.

## Huntdowns (3, repeatable)
| Huntdown | Enemy | Farms |
|---|---|---|
| Scrap Run | scrap gunners | Plasma cannon family (Epic → Mythical parts), credits |
| Wreck Hunt | Wreckers | Demolisher family (Sacrifice Cannon / Broken Devourer / Drunk Lightning) |
| Salvage Contract | mixed brawlers | Recoilers, Disintegration line, **Iron Retreat Mark I** (rare) |

## Rewards
- **Item box (zone clear):** one Legendary scrap weapon of the player's choice.
- **Boss drop:** SCRAPLORD parts (boss torso, 1% for its unique legs), Beam Cannon Legendary (rare).
- **Zone unique:** *Scraplord's Welder* (idea: a unique melee weapon, not designed yet).

## Open questions
- Slot in the campaign (8, or between two Legacy zones)?
- Keep the "−10% HP / +1 use" zone rule?
- Boss art: recolour an existing boss torso, or build one from parts?
