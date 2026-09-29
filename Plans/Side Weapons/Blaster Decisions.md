# Blaster and Laser Decisions

## Slot changes
- **`blaster15A/B` (A-ray / Resistance drainer) → Top Weapons** (user, 2026-09-27). The roster (`data/items_selected.json`) still needs the slot updated.
  - It's part of the **ray set** with Xray (`blaster13`) and B-ray (`blaster14`): 15 damage, 1 use, and an **insane resistance drain** (proposed ~−40 per shot). A-ray → physical, Xray → electric, B-ray → explosive. Details in [[Top Weapon Decisions]].

- **Mega Blasters (`sideMegaBlaster1–3 C/D/E`: Lazy Falcon, Half Burnt Scope, Electrocuted Scope) → Top Weapons** (user, 2026-09-27): a set of backfiring scopes, not side weapons. Roster slot to update.

- **Slot check against the item data (2026-09-27):**
  - **→ Top Weapons:** Distance Shredder / Space Invader / Party Crasher (`sideDistanceCloser1–3`), confirmed `TOP_WEAPON` in the Reloaded data.
  - **→ Side Weapons:** Cracked Plasma Cannon / Obsolete Energy Cannon / Unrepaired Laser Cannon (the `cannon11` family, filed under top weapons), confirmed `SIDE_WEAPON`.
  - Rail Gun (`laser42B`) is correctly a side weapon (Legacy). Its name also belongs to a Reloaded **drone**.
  - **Name clash:** "Shockwave" (our sword7 steel sword) is also the name of a Reloaded **drone**. Decide when we do drones.

## Dropped
- **Shredder beams** (`blaster3A/B/C`: Blue / Yellow Shredder beam) (user, 2026-09-27).

## Watch Guards (decided 2026-09-27, buffed 2026-09-28)
**Legendary → Mythical → Ultimate**, with **backfire**. Look `A` = Legendary, `B` = Mythical and Ultimate. Range 1–3.
**Buffed (user): +30% damage and heat/drain, push 2.** Close-range glass cannons: the hardest-hitting blasters, and each hit knocks the enemy 2 cells back.

| | Legendary | Mythical |
|---|---|---|
| **Red Watch Guard** (explosive) | ![[Side Weapons/final/Watch Guards/Red Watch Guard/blaster4A.png\|110]] | ![[Side Weapons/final/Watch Guards/Red Watch Guard/blaster4B.png\|110]] |
| **Blue Watch Guard** (electric) | ![[Side Weapons/final/Watch Guards/Blue Watch Guard/blaster5A.png\|110]] | ![[Side Weapons/final/Watch Guards/Blue Watch Guard/blaster5B.png\|110]] |

| | Legendary (level 1 → max) | Mythical (level 1 → max) | Ultimate (level 1 → 100) |
|---|---|---|---|
| Damage (both) | 145–220 → 195–300 | 215–330 → 290–450 | 300–460 → ~510–790 |
| Red: heat | +55→75 | +80→105 | +110→~180 |
| Blue: drain | +75→100 | +105→140 | +145→~240 |
| Backfire (self-damage) | 90 | 130 | 155 → ~203 (lvl 1 → 100) |
| Cost per shot | red 30 heat + 10 energy; blue swapped | 45 + 15 | 65 + 22 |
| Push / weight | 2 / 36 | 2 / 36 | 2 / 36 |

## Super Blasters + Sweetie (decided 2026-09-27)
**Legendary → Mythical → Ultimate** (Ultimate added after reviewing the projection). Plain Reloaded stats + our Ultimate rule. 3 uses per battle. Look `D` = Legendary, `E` = Mythical and Ultimate.
Sweetie (the physical one, `sideBulletSprayer`) was brought back into this group.

| | Sweetie (physical) | Chaos Bringer (explosive) | BigDaddy (electric) |
|---|---|---|---|
| Looks | ![[Side Weapons/final/Super Blasters/Sweetie/sideBulletSprayer1D.png\|110]] ![[Side Weapons/final/Super Blasters/Sweetie/sideBulletSprayer1E.png\|110]] | ![[Side Weapons/final/Super Blasters/Chaos Bringer/sideSuperBlaster2D.png\|110]] ![[Side Weapons/final/Super Blasters/Chaos Bringer/sideSuperBlaster2E.png\|110]] | ![[Side Weapons/final/Super Blasters/BigDaddy/sideSuperBlaster3D.png\|110]] ![[Side Weapons/final/Super Blasters/BigDaddy/sideSuperBlaster3E.png\|110]] |
| Legendary | 86–128 → 116–173, −6 phys. res. | 114–143 → 153–192, +60→81 heat | 103–132 → 138–177, +79→106 drain |
| Mythical | 129–195 → 169–256, −10 phys. res. | 171–218 → 224–286, +87→114 heat | 155–202 → 202–265, +116→152 drain |
| Ultimate (level 1 → 100) | ~179–271 → ~290–439 | 237–302 → ~384–489, +121→~196 heat | 215–280 → ~348–454, +161→~261 drain |
| Range | 3–6 | 1–2 | 1–2 |
| Cost (Leg / Myth) | 20 / 31 heat | 10 energy + 20 heat / 16 + 31 | 30 energy + 10 heat / 47 + 16 |
| Weight | 42 | 49 | 53 |

## Lasers: SandStorm / DawnBlaze / UltraBright (decided 2026-09-27)
**Legendary → Mythical → Ultimate**, the same as the other blasters. Three looks, one per tier: `C` = Legendary, `D` = Mythical, `E` = Ultimate.
Reloaded has only DawnBlaze (`sideLaser2`) and UltraBright (`sideLaser3`). **SandStorm** (`sideLaser1`, physical) is new: DawnBlaze recolored from red to physical amber (hue 38°). Sprites: `Side Weapons/lasers/` (script `tools/recolor_sandstorm.py`; the E look was redone 2026-09-28, the first recolor had lost its accents).

|                          | SandStorm (physical, new)                                                                                                              | DawnBlaze (explosive)                                                                                                                     | UltraBright (electric)                                                                                                                    |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Looks (Leg / Myth / Ult) | ![[Side Weapons/final/Lasers/SandStorm/sideLaser1C.png\|90]] ![[Side Weapons/final/Lasers/SandStorm/sideLaser1D.png\|90]] ![[Side Weapons/final/Lasers/SandStorm/sideLaser1E.png\|90]] | ![[Side Weapons/final/Lasers/DawnBlaze/sideLaser2C.png\|90]] ![[Side Weapons/final/Lasers/DawnBlaze/sideLaser2D.png\|90]] ![[Side Weapons/final/Lasers/DawnBlaze/sideLaser2E.png\|90]] | ![[Side Weapons/final/Lasers/UltraBright/sideLaser3C.png\|90]] ![[Side Weapons/final/Lasers/UltraBright/sideLaser3D.png\|90]] ![[Side Weapons/final/Lasers/UltraBright/sideLaser3E.png\|90]] |
| Legendary                | 119–151 → 160–204, −8 phys. res.                                                                                                       | 107–136 → 144–183, +37 heat, −6 expl. res.                                                                                                | 103–132 → 138–177, +49 drain, −3 elec. res.                                                                                               |
| Mythical                 | 178–230 → 233–302, −12 phys. res.                                                                                                      | 160–207 → 210–272, +54→71 heat, −9 expl. res.                                                                                             | 155–202 → 203–265, +72→95 drain, −5 elec. res.                                                                                            |
| Ultimate (level 1 → 100) | 240–311 → ~389–505, −16 phys. res.                                                                                                     | 216–280 → ~351–456, +73→~119 heat, −12 expl. res.                                                                                         | 209–273 → ~339–443, +97→~159 drain, −7 elec. res.                                                                                         |
| Cost (Leg / Myth / Ult)  | 40 / 63 / 90 heat                                                                                                                      | 10+30 / 16+47 / 22+65 energy+heat                                                                                                         | 30+10 / 47+16 / 65+22 energy+heat                                                                                                         |
| Range / weight           | 3–6 / 54                                                                                                                               | 3–6 / 52                                                                                                                                  | 3–6 / 56                                                                                                                                  |

- Ultimate level 1 = Reloaded Divine (×1.35 over Mythical level 1; SandStorm uses the same step), then our Ultimate rule (the Mythical gain per level carried over 100 levels, ×1.35).
- SandStorm: a bit more raw damage (no heat or drain) and a heat-only cost, like Sweetie.
- SandStorm buffed about 8% (user, 2026-09-27): damage and physical resistance drain.

## CorruptLight / MaliceBeam (decided 2026-09-28)
**Legendary → Mythical → Ultimate.** A pair (no physical version). The Reloaded names are used; the Legacy names (Red Rein, Termination Heat, Twin Termination R / Blue Rein, Termination Electro, Twin Termination B) are dropped. Looks: `A` = Legendary, `B` = Mythical, `C` = Ultimate.
Role: they hit weaker than the SandStorm lasers but lower the enemy's **max heat** (CorruptLight) or **max energy** (MaliceBeam).

| | CorruptLight (explosive, `laser30`) | MaliceBeam (electric, `laser32`) |
|---|---|---|
| Looks (Leg / Myth / Ult) | ![[Side Weapons/final/Lasers/CorruptLight/laser30A.png\|90]] ![[Side Weapons/final/Lasers/CorruptLight/laser30B.png\|90]] ![[Side Weapons/final/Lasers/CorruptLight/laser30C.png\|90]] | ![[Side Weapons/final/Lasers/MaliceBeam/laser32A.png\|90]] ![[Side Weapons/final/Lasers/MaliceBeam/laser32B.png\|90]] ![[Side Weapons/final/Lasers/MaliceBeam/laser32C.png\|90]] |
| Legendary | 72–119, +49 heat, −12 max heat | 72–119, +74 drain, −12 max energy |
| Mythical (level 1 → max) | 107–180 → 140–236, +71→93 heat, −24 max heat | 107–180 → 140–236, +104→133 drain, −24 max energy |
| Ultimate (level 1 → 100) | 144–243 → ~233–394, +96→~155 heat, −32 max heat | 144–243 → ~233–394, +140→~218 drain, −32 max energy |
| Cost (Leg / Myth / Ult) | 10+30 / 16+47 / 22+65 energy+heat | 30+10 / 47+16 / 65+22 energy+heat |
| Range / weight | 3–6 / 51 | 3–6 / 55 |

- Reloaded stats; Ultimate = Divine as level 1, then our Ultimate rule.

**Lasers are DONE.**

## Beam Cannons: Malfunctioning / Rusty Heat / Scrapped Energy Blaster (decided 2026-09-28)
**Legendary → Mythical → Ultimate.** `D` = Legendary, `E` = Mythical **and Ultimate**. Reloaded stats plus our Ultimate rule. Long-range glass cannons: range 3–6, **backfire** every shot, very expensive to fire.

| | Malfunctioning Blaster (physical) | Rusty Heat Blaster (explosive) | Scrapped Energy Blaster (electric) |
|---|---|---|---|
| Looks (Leg / Myth–Ult) | ![[Side Weapons/final/Beam Cannons/Malfunctioning Blaster/sideBeamCannon1D.png\|100]] ![[Side Weapons/final/Beam Cannons/Malfunctioning Blaster/sideBeamCannon1E.png\|100]] | ![[Side Weapons/final/Beam Cannons/Rusty Heat Blaster/sideBeamCannon2D.png\|100]] ![[Side Weapons/final/Beam Cannons/Rusty Heat Blaster/sideBeamCannon2E.png\|100]] | ![[Side Weapons/final/Beam Cannons/Scrapped Energy Blaster/sideBeamCannon3D.png\|100]] ![[Side Weapons/final/Beam Cannons/Scrapped Energy Blaster/sideBeamCannon3E.png\|100]] |
| Legendary (level 1 → max) | 125–196 → 168–264, −8 phys. res. | 106–168 → 142–225, +56→75 heat, −5 expl. res. | 106–168 → 142–225, +74→100 drain, −5 elec. res. |
| Mythical (level 1 → max) | 186–298 → 244–391, −13 | 159–256 → 209–336, +81→106 heat, −7 | 159–256 → 209–336, +108→142 drain, −7 |
| Ultimate (level 1 → 100) | 258–413 → ~415–664, −18 | 220–355 → ~355–571, +112→~180 heat, −9 | 220–355 → ~355–571, +150→~242 drain, −9 |
| Backfire (Leg / Myth / Ult lvl 1 → 100) | 108 / 159 / 189 → ~248 | 118 / 173 / 206 → ~270 | 118 / 173 / 206 → ~270 |
| Cost (Leg / Myth / Ult) | 102 / 162 / ~225 heat | 90 / 143 / ~200 heat | 90 / 143 / ~200 energy |
| Uses / weight | unlimited / 28 | 3 / 43 | 3 / 42 |

## Hybrid blasters (decided 2026-09-28)
Each fires one element but **pays with the other resource**: the explosive ones cost only energy, the electric ones cost only heat. They also lower the enemy's max heat / max energy. Pairs, no physical version. Range 3–6. Reloaded stats.

### Flaminator / Hot Flash: Rare → Epic → Legendary → Mythical (early line, no Ultimate)
One look per tier: `B` Rare, `C` Epic, `D` Legendary, `E` Mythical.

| | Flaminator (explosive) | Hot Flash (electric) |
|---|---|---|
| Looks (R / E / L / M) | ![[Side Weapons/final/Hybrid Blasters/Flaminator/sideEnergyHeatBlaster2B.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Flaminator/sideEnergyHeatBlaster2C.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Flaminator/sideEnergyHeatBlaster2D.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Flaminator/sideEnergyHeatBlaster2E.png\|90]] | ![[Side Weapons/final/Hybrid Blasters/Hot Flash/sideEnergyHeatBlaster3B.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Hot Flash/sideEnergyHeatBlaster3C.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Hot Flash/sideEnergyHeatBlaster3D.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Hot Flash/sideEnergyHeatBlaster3E.png\|90]] |
| Rare | 29–42, +20 heat | 29–42, +27 drain |
| Epic | 48–71, +32 heat, −3 max heat | 48–71, +47 drain, −3 max energy |
| Legendary | 76–116, +49 heat, −12 max heat | 76–116, +74 drain, −12 max energy |
| Mythical (level 1 → max) | 113–174 → 148–228, +71→93 heat, −24 | 113–174 → 148–228, +108→142 drain, −24 |
| Cost (R / E / L / M) | 20 / 39 / 70 / 110 **energy** | 20 / 39 / 70 / 110 **heat** |
| Weight | 47 | 66 |

### Hybrid Heat Cannon / Hybrid Energy Cannon: Legendary → Mythical → Ultimate (late line)
`D` = Legendary, `E` = Mythical **and Ultimate**.

| | Hybrid Heat Cannon (explosive) | Hybrid Energy Cannon (electric) |
|---|---|---|
| Looks (Leg / Myth–Ult) | ![[Side Weapons/final/Hybrid Blasters/Hybrid Heat Cannon/sideEnergyHeatBlasterB2D.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Hybrid Heat Cannon/sideEnergyHeatBlasterB2E.png\|90]] | ![[Side Weapons/final/Hybrid Blasters/Hybrid Energy Cannon/sideEnergyHeatBlasterB3D.png\|90]] ![[Side Weapons/final/Hybrid Blasters/Hybrid Energy Cannon/sideEnergyHeatBlasterB3E.png\|90]] |
| Legendary | 81–135, +55 heat, −17 max heat | 81–135, +73 drain, −20 max energy |
| Mythical (level 1 → max) | 121–205 → 159–269, +80→105 heat, −33 | 121–205 → 159–269, +106→139 drain, −39 |
| Ultimate (level 1 → 100) | 168–285 → ~271–458, +111→~178 heat, −45 | 168–285 → ~271–458, +147→~236 drain, −53 |
| Cost (Leg / Myth / Ult) | 66 / 104 / ~146 **energy** | 66 / 104 / ~146 **heat** |
| Weight | 47 | 66 |

## Movement lasers: Perimeter Protector / Distance Controller / Distance Generator (decided 2026-09-28)
**Epic → Legendary → Mythical, no Ultimate** (user). `A` = Epic, `B` = Legendary, `C` = Mythical. Reloaded drawings only (`_legacy` redraws dropped); Reloaded names and stats (Epic scaled down). Added from the never-marked list.
Close range 1–2, 2 uses. After firing: Perimeter Protector and Distance Generator **jump the shooter back 6**; Distance Controller **charges forward 6**.

| | Perimeter Protector (physical) | Distance Controller (explosive) | Distance Generator (electric) |
|---|---|---|---|
| Looks (Epic / Leg / Myth) | ![[Side Weapons/final/Movement Lasers/Perimeter Protector/laser48A.png\|90]] ![[Side Weapons/final/Movement Lasers/Perimeter Protector/laser48B.png\|90]] ![[Side Weapons/final/Movement Lasers/Perimeter Protector/laser48C.png\|90]] | ![[Side Weapons/final/Movement Lasers/Distance Controller/laser48A3.png\|90]] ![[Side Weapons/final/Movement Lasers/Distance Controller/laser48B3.png\|90]] ![[Side Weapons/final/Movement Lasers/Distance Controller/laser48C3.png\|90]] | ![[Side Weapons/final/Movement Lasers/Distance Generator/laser48A2.png\|90]] ![[Side Weapons/final/Movement Lasers/Distance Generator/laser48B2.png\|90]] ![[Side Weapons/final/Movement Lasers/Distance Generator/laser48C2.png\|90]] |
| Epic | 48–85, −2 phys. res. | 43–76, +14 heat, −2 expl. res. | 43–76, +19 drain, −2 elec. res. |
| Legendary (level 1 → max) | 78–137 → 105–184, −3 | 69–122 → 93–164, +23→31 heat, −3 | 69–122 → 93–164, +30→41 drain, −3 |
| Mythical (level 1 → max) | 116–208 → 152–273, −5 | 103–184 → 135–241, +33→44 heat, −5 | 103–184 → 135–241, +44→63 drain, −5 |
| Cost (Epic / Leg / Myth) | 15 / 24 / 38 heat | 15 / 24 / 38 heat | 15 / 24 / 38 heat |
| Weight | 31 | 34 | 35 |
