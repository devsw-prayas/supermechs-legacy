# Top Weapon Decisions

Status 2026-09-29: **review finished.** 179 roster sprites, 25 designs (each in up to 3 elements). Everything below is the decision log, one section per family. Numbers marked *invented* are ours, not from the game data. Unreviewed leftovers are in [[Unmarked Top Weapons]]; dropped and moved sprites are in `_archive/`.

| Tier band | Families |
|---|---|
| Common → Legendary | Missile Launchers |
| Common → Epic | FireWatch / Metal Bender / ElectroCop |
| Rare → Epic | Straight Shots, Lasers, Repeaters |
| Epic → Legendary | Penetrators |
| Epic → Ultimate | Cockpit, Frantic cannons, Apocalypse, Hornets, Rage blasters, Backfiring scopes, Nova beams, Grenade launchers, Supreme Cannons, Desolation, Distance Closers |
| Legendary → Ultimate | Orb Cannons, Falcon scopes, Snipers, Super lasers, Rocket showers, Spartan Carnage, Bombs |
| Not counted | Rear Hit Electro Mark (kept as in Reloaded) |

Dropped: the ray set (A-ray / Xray / B-ray), the physical bomb, the yellow Desert Fury.


## The ray set: DROPPED (user, 2026-09-29)
A-ray, Xray and B-ray (`blaster15`, `blaster13`, `blaster14`) are removed from the roster: the design feels weird. The early resistance breakers (Common → Epic) and the resistance drain on the Cockpit and Falcon scopes cover the drain-then-burst combo. `Plans/Top Weapons/sprites/blaster13-15` stay on disk only.

## Orb Cannons (decided 2026-09-29)
**Legendary → Ultimate, no Epic.** Look A = Legendary, look B = Mythical + Ultimate. Reloaded names and stats. Mid-range shot that **pulls** the enemy 1 step. Heavy.

|  | Mighty Cannon (physical) | Desert Snake (heat) | SpineFall (electric) |
|---|---|---|---|
| Looks (Leg / Myth+Ult) | ![[Top Weapons/sprites/blaster19A.png\|110]] ![[Top Weapons/sprites/blaster19B.png\|110]] | ![[Top Weapons/sprites/blaster20A.png\|110]] ![[Top Weapons/sprites/blaster20B.png\|110]] | ![[Top Weapons/sprites/blaster18A.png\|110]] ![[Top Weapons/sprites/blaster18B.png\|110]] |
| Legendary | 121–204, pull 1, range 4–8, 24 energy / 24 heat, weight 55 | 98–164, +37 heat, −4 cooling, pull 1, range 4–8, weight 63 | 98–164, −54 energy, −7 regen, pull 1, range 4–8, weight 67 |
| Mythical | 182–311 | 146–250, +54 heat, −7 cooling | 146–250, −80 energy, −13 regen |
| Ultimate (lvl 1 = Divine) | 252–431 | 202–346, +75 heat | 202–346, −111 energy |

- `blaster13` (similar look) stays the **Xray** of the ray set, not part of this family.

## Falcon scopes (decided 2026-09-29)
**Legendary → Ultimate.** D = Legendary, E = Mythical + Ultimate. Reloaded names and stats. Range 8 only, 1 use, one huge shot.
**Falcon is the strongest single hit in the game, on purpose.** Drain the enemy's physical resistance below zero first (resistance breakers, Cockpit drain) and a maxed Falcon can land **~2,000**. That combo is intended.

|  | Falcon (physical) | Flaming Scope (heat) | Lightning Scope (electric) |
|---|---|---|---|
| Looks (Leg / Myth+Ult) | ![[Top Weapons/sprites/topMegaSniper1D.png\|110]] ![[Top Weapons/sprites/topMegaSniper1E.png\|110]] | ![[Top Weapons/sprites/topMegaSniper2D.png\|110]] ![[Top Weapons/sprites/topMegaSniper2E.png\|110]] | ![[Top Weapons/sprites/topMegaSniper3D.png\|110]] ![[Top Weapons/sprites/topMegaSniper3E.png\|110]] |
| Legendary | 303–499, weight 19, 14 energy / 14 heat | 289–371, +111 heat, −9 expl. res., weight 21, costs 98 heat | 289–371, −147 energy, −9 elec. res., weight 23, costs 98 energy |
| Mythical | 455–761 | 434–566, +162 heat, −15 res. | 434–566, −216 energy, −15 res. |
| Ultimate lvl 1 (= Divine) | 629–1,052 | 600–783, +224 heat | 600–783, −299 energy |
| Ultimate lvl 100 | **1,019–1,704** | 871–1,137, +325 heat | 871–1,137, −434 energy |

## Cockpit set (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate. Reloaded names and stats; Epic = Legendary × 0.62 (the median Epic/Legendary damage ratio in the Reloaded data). Range 7, 1 use, **push 1**: the Falcon scopes' little brother, a bit less damage but it knocks the enemy back.

|  | Cockpit Piercer (physical) | Cockpit Burner (heat) | Cockpit Electrocuter (electric) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/topMegaSniperB1C.png\|100]] ![[Top Weapons/sprites/topMegaSniperB1D.png\|100]] ![[Top Weapons/sprites/topMegaSniperB1E.png\|100]] | ![[Top Weapons/sprites/topMegaSniperB2C.png\|100]] ![[Top Weapons/sprites/topMegaSniperB2D.png\|100]] ![[Top Weapons/sprites/topMegaSniperB2E.png\|100]] | ![[Top Weapons/sprites/topMegaSniperB3C.png\|100]] ![[Top Weapons/sprites/topMegaSniperB3D.png\|100]] ![[Top Weapons/sprites/topMegaSniperB3E.png\|100]] |
| Epic | ~170–268, −4 phys. res., weight 27 | ~125–203, +58 heat, −5 expl. res. | ~130–206, −70 energy, −4 elec. res. |
| Legendary | 274–432, −6 phys. res., weight 27, 14 energy / 14 heat | 201–327, +93 heat, −8 expl. res., costs 98 heat | 210–332, −113 energy, −6 elec. res., costs 78 energy |
| Mythical | 412–661, −10 res. | 301–499, +135 heat, −12 res. | 316–508, −166 energy, −10 res. |
| Ultimate lvl 1 (= Divine) | 570–915 | 417–669, +187 heat | 473–703, −230 energy |
| Ultimate lvl 100 | ~836–1,327 | ~604–981, +274 heat | ~672–1,037, −334 energy |

## Early resistance breakers: FireWatch / Metal Bender / ElectroCop (decided 2026-09-29)
**Common → Epic.** A = Common (Mark I), B = Rare (Mark II), C = Epic (Mark III, the unused third look). Legacy names; Common/Rare from the Legacy data, Epic scaled up. Range 3–4, 1 use, low damage with a **resistance drain**: the early-game way into the drain-then-burst combo. Nothing replaces them at Legendary+ (the ray set was dropped); the scopes' own resistance drain carries on.

|  | Metal Bender (physical) | FireWatch (heat) | ElectroCop (electric) |
|---|---|---|---|
| Looks (Common / Rare / Epic) | ![[Top Weapons/sprites/blaster23A.png\|100]] ![[Top Weapons/sprites/blaster23B.png\|100]] ![[Top Weapons/sprites/blaster23C.png\|100]] | ![[Top Weapons/sprites/blaster22A.png\|100]] ![[Top Weapons/sprites/blaster22B.png\|100]] ![[Top Weapons/sprites/blaster22C.png\|100]] | ![[Top Weapons/sprites/blaster24A.png\|100]] ![[Top Weapons/sprites/blaster24B.png\|100]] ![[Top Weapons/sprites/blaster24C.png\|100]] |
| Common (Mark I) | 25, −13 phys. res., weight 41 | 25, +15 heat, −4 cooling, −12 expl. res., weight 39 | 25, −15 energy, −4 regen, −12 elec. res., weight 45 |
| Rare (Mark II) | ~38, −20 res., weight 45 | ~38, +23 heat, −6 cooling, −20 res., weight 46 | ~38, −23 energy, −6 regen, −20 res., weight 50 |
| Epic (Mark III) | ~57, −30 res., weight 48 | ~57, +35 heat, −9 cooling, −30 res., weight 49 | ~57, −35 energy, −9 regen, −30 res., weight 53 |

- Legacy Mark II (27 dmg, −13/−14 res.) was barely above Mark I, so Rare is scaled to give a real step. Stats are proposals; tune in the balance pass.

## Frantic cannons (decided 2026-09-29)
**Epic → Ultimate**, by barrel count: 1 barrel = Epic, 2 = Legendary, 4 = Mythical + Ultimate. Reloaded names and stats. Range 3–6, 2 uses, a **gamble cannon** with a huge damage spread. Legacy "Wipeout Mark I–III" name dropped. Roster elements fixed by colour (`_element` in `data/slot_overrides.json`).

|  | Frantic Flame (heat, red) | Frantic Brute (physical, orange) | Frantic Lightning (electric, blue) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/cannon7A.png\|100]] ![[Top Weapons/sprites/cannon7B.png\|100]] ![[Top Weapons/sprites/cannon7C.png\|100]] | ![[Top Weapons/sprites/cannon7A2.png\|100]] ![[Top Weapons/sprites/cannon7B2.png\|100]] ![[Top Weapons/sprites/cannon7C2.png\|100]] | ![[Top Weapons/sprites/cannon7A3.png\|100]] ![[Top Weapons/sprites/cannon7B3.png\|100]] ![[Top Weapons/sprites/cannon7C3.png\|100]] |
| Epic | 25–129, +26 heat, −3 res., weight 50 | 23–171, −4 phys. res., weight 50 | 25–124, −31 energy, −3 res., weight 50 |
| Legendary | 39–226, +40 heat, −6 res. | 36–302, −8 res. | 40–217, −49 energy, −6 res. |
| Mythical | 108–309, +59 heat, −10 res. | 152–382, −12 res. | 108–294, −72 energy, −10 res. |
| Ultimate lvl 1 (= Divine) | 146–417, +80 heat | 205–515 | 146–397, −97 energy |

## Apocalypse set (decided 2026-09-29)
**Epic → Ultimate**, A = Epic, B = Legendary, C = Mythical + Ultimate. Mid-range cannon (range 2–4), **push** (1 at Epic, 2 from Legendary), no use limit. Legacy-only item (75 / 85 / 95 flat), so stats follow the Mighty Cannon ladder. New heat and electric recolours (`tools/recolor_top.py`, added via `_extra`).

|  | Apocalypse (physical) | Molten Hail (heat) | Electrocution (electric) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/cannon1A.png\|100]] ![[Top Weapons/sprites/cannon1B.png\|100]] ![[Top Weapons/sprites/cannon1C.png\|100]] | ![[Top Weapons/sprites/cannon1A_heat.png\|100]] ![[Top Weapons/sprites/cannon1B_heat.png\|100]] ![[Top Weapons/sprites/cannon1C_heat.png\|100]] | ![[Top Weapons/sprites/cannon1A_elec.png\|100]] ![[Top Weapons/sprites/cannon1B_elec.png\|100]] ![[Top Weapons/sprites/cannon1C_elec.png\|100]] |
| Epic | ~75–126, push 1, weight 39 | ~61–102, +23 heat, push 1 | ~61–102, −33 energy, push 1 |
| Legendary | ~121–204, push 2, weight 47 | ~98–164, +37 heat, −4 cooling | ~98–164, −54 energy, −7 regen |
| Mythical | ~182–311, weight 50 | ~146–250, +54 heat | ~146–250, −80 energy |
| Ultimate lvl 1 | ~252–431 | ~202–346, +75 heat | ~202–346, −111 energy |

- Stats are proposals (same numbers as the Orb Cannons, but push instead of pull and shorter range). Tune in the balance pass.

## Hornets (decided 2026-09-29, unreleased Reloaded art)
**Epic → Ultimate**, by barrel count: C (1 barrel) = Epic, D (2) = Legendary, E (3) = Mythical + Ultimate. Never released, so names are new and stats are proposals. A **multi-barrel top blaster**: fires one shot per barrel, lower damage per shot than Vandal Rage, no push. Range 3–5, 2 uses.

|  | Iron Hornet (physical) | Ember Hornet (heat) | Storm Hornet (electric) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/topBlasterB1C.png\|100]] ![[Top Weapons/sprites/topBlasterB1D.png\|100]] ![[Top Weapons/sprites/topBlasterB1E.png\|100]] | ![[Top Weapons/sprites/topBlasterB2C.png\|100]] ![[Top Weapons/sprites/topBlasterB2D.png\|100]] ![[Top Weapons/sprites/topBlasterB2E.png\|100]] | ![[Top Weapons/sprites/topBlasterB3C.png\|100]] ![[Top Weapons/sprites/topBlasterB3D.png\|100]] ![[Top Weapons/sprites/topBlasterB3E.png\|100]] |
| Epic (1 shot) | ~48–62, −4 phys. res., weight 38 | ~40–52, +14 heat | ~40–52, −20 energy |
| Legendary (2 shots) | ~42–54 ×2, −7 res. | ~35–45 ×2, +10 heat per shot | ~35–45 ×2, −14 energy per shot |
| Mythical (3 shots) | ~42–54 ×3, −11 res. | ~35–45 ×3, +12 heat per shot | ~35–45 ×3, −17 energy per shot |
| Ultimate lvl 1 (3 shots) | ~58–73 ×3 | ~48–61 ×3, +16 heat per shot | ~48–61 ×3, −23 energy per shot |

- Totals per turn follow Vandal Rage's ladder (e.g. Mythical ~126–162 total vs Vandal Rage 109–142), spread over several hits.

## Rage blasters (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate. Reloaded stats (Vandal Rage). Range 4–5, 1 use, push 1, one heavy shot that also drains resistance and cooling/energy.

|  | Vandal Rage (heat) | Thunder Rage (electric) | Storm Rage (physical) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/topBlaster2C.png\|100]] ![[Top Weapons/sprites/topBlaster2D.png\|100]] ![[Top Weapons/sprites/topBlaster2E.png\|100]] | ![[Top Weapons/sprites/topBlaster3C.png\|100]] ![[Top Weapons/sprites/topBlaster3D.png\|100]] ![[Top Weapons/sprites/topBlaster3E.png\|100]] | ![[Top Weapons/sprites/topBlaster2C_phys.png\|100]] ![[Top Weapons/sprites/topBlaster2D_phys.png\|100]] ![[Top Weapons/sprites/topBlaster2E_phys.png\|100]] |
| Epic | 45–57, +15 heat, −6 expl. res., −7 cooling, push 1, weight 41 | 45–57, −21 energy, −6 elec. res., −7 regen | ~56–71, −8 phys. res. |
| Legendary | 73–94, +23 heat, −12 res., −25 cooling | 73–94, −32 energy, −12 res., −25 regen | ~91–118, −15 res. |
| Mythical | 109–142, +33 heat, −20 res., −46 cooling | 109–142, −46 energy, −20 res., −46 regen | ~136–178, −25 res. |
| Ultimate lvl 1 (= Divine) | 147–192, +45 heat | 147–192, −63 energy | ~184–240 |

- Thunder Rage = unreleased `topBlaster3` (blue); its E look had leftover red trim, recoloured blue (original kept as `topBlaster3E_orig.png`).
- Storm Rage = recolour from the queue (`topBlaster2*_phys.png`), ×1.25 damage like other physical versions with no side effect.

## Backfiring scopes (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate. Reloaded names and stats; Epic = Legendary × 0.62. Range 8 only, **no use limit**, the shooter takes **backfire** damage every shot. Moved here from side weapons (`sideMegaBlaster1–3`).

|  | Lazy Falcon (physical) | Half Burnt Scope (heat) | Electrocuted Scope (electric) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/sideMegaBlaster1C.png\|100]] ![[Top Weapons/sprites/sideMegaBlaster1D.png\|100]] ![[Top Weapons/sprites/sideMegaBlaster1E.png\|100]] | ![[Top Weapons/sprites/sideMegaBlaster2C.png\|100]] ![[Top Weapons/sprites/sideMegaBlaster2D.png\|100]] ![[Top Weapons/sprites/sideMegaBlaster2E.png\|100]] | ![[Top Weapons/sprites/sideMegaBlaster3C.png\|100]] ![[Top Weapons/sprites/sideMegaBlaster3D.png\|100]] ![[Top Weapons/sprites/sideMegaBlaster3E.png\|100]] |
| Epic | ~193–304, backfire ~207, weight 30 | ~159–250, +69 heat, backfire ~198 | ~159–250, −91 energy, backfire ~164 |
| Legendary | 311–491, −6 phys. res., backfire 334 | 256–404, +111 heat, −9 expl. res., backfire 319, costs 63 heat | 256–404, −147 energy, −9 elec. res., backfire 265, costs 39 energy |
| Mythical | 467–749, −10 res., backfire 490 | 384–616, +162 heat, −15 res., backfire 468 | 384–616, −216 energy, −15 res., backfire 389 |
| Ultimate lvl 1 (= Divine) | 646–1,036, backfire ~583 | 531–852, +224 heat, backfire ~557 | 531–852, −299 energy, backfire ~463 |
| Ultimate lvl 100 | ~937–1,503, backfire ~650 | ~771–1,238, +325 heat, backfire ~620 | ~771–1,238, −434 energy, backfire ~515 |

- **Backfire rule (decided 2026-09-29):** up to Mythical it follows the Reloaded data (scales with damage). **After Mythical it grows at half the damage's rate**, so a maxed Lazy Falcon hits ~1,220 on average and costs its user ~737. No use limit.
- **Backfire cap (decided 2026-09-29):** Ultimate backfire is capped at **~650 at level 100** (Lazy Falcon); Half Burnt ~620 and Electrocuted ~515 keep the same ratio. Ultimate level 1 stays as above (~583 / ~557 / ~463). Use ~650 as the ceiling for any backfire item in the side-weapon pass too.

## Snipers (decided 2026-09-29)
**Legendary → Ultimate, no Epic.** D = Legendary, E = Mythical + Ultimate. Range 4–8, **2 uses**: the cheaper, lighter cousin of the Falcon scopes. **No yellow/physical version** in this set: the yellow Desert Fury art is dropped, and Desert Fury becomes the red (heat) recolour (`topSniper1*_heat`).

|  | Desert Fury (heat) | Valiant Sniper (electric) |
|---|---|---|
| Looks (Leg / Myth+Ult) | ![[Top Weapons/sprites/topSniper1D_heat.png\|110]] ![[Top Weapons/sprites/topSniper1E_heat.png\|110]] | ![[Top Weapons/sprites/topSniper3D.png\|110]] ![[Top Weapons/sprites/topSniper3E.png\|110]] |
| Legendary | ~59–85, +26 heat, −11 expl. res., costs 10 heat, weight 29 | 64–91, −98 energy, −11 elec. res., −7 regen, costs 20 energy, weight 51 |
| Mythical | ~88–128, +38 heat, −17 res. | 96–139, −144 energy, −17 res., −13 regen |
| Ultimate lvl 1 (= Divine) | ~121–177, +53 heat | 133–193, −200 energy |
| Ultimate lvl 100 | ~196–287, +77 heat | ~215–313, −290 energy |

- Heat stats are invented: the Reloaded physical Desert Fury × 0.75 damage plus a heat drain (same ratio as Cockpit Burner vs Piercer). Ultimate growth same as the other sets (damage × 1.62, drain × 1.45).

## Nova beams: Infernova / Super Nova / Ultra Nova (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate. Renamed from the Reloaded **Savagery** (now **Infernova**, heat) and **Hysteria** (now **Super Nova**, electric): the Legacy Nova family (`blaster21`) is the same gun, so the Legacy names win and the Reloaded names are gone. **Ultra Nova (physical)** is new: an orange recolour of the red beam (`topBeam2*_phys`), ×1.25 damage and no drain. Stats stay the Reloaded ones. Range 4–8, 1 use, heavy (weight 51–55). The Legacy Nova art and stats (`blaster21`) are not used.

|  | Infernova (heat) | Super Nova (electric) | Ultra Nova (physical) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/topBeam2C.png\|100]] ![[Top Weapons/sprites/topBeam2D.png\|100]] ![[Top Weapons/sprites/topBeam2E.png\|100]] | ![[Top Weapons/sprites/topBeam3C.png\|100]] ![[Top Weapons/sprites/topBeam3D.png\|100]] ![[Top Weapons/sprites/topBeam3E.png\|100]] | ![[Top Weapons/sprites/topBeam2C_phys.png\|100]] ![[Top Weapons/sprites/topBeam2D_phys.png\|100]] ![[Top Weapons/sprites/topBeam2E_phys.png\|100]] |
| Epic | 49–71, +36 heat, −4 cooling, costs 17 heat | 54–78, −42 energy, −3 regen, costs 17 energy | ~61–89 |
| Legendary | 78–116, +56 heat, −15 cooling | 86–126, −67 energy, −12 regen | ~98–145 |
| Mythical | 117–176, +81 heat, −30 cooling | 129–192, −98 energy, −24 regen | ~146–220 |
| Ultimate lvl 1 (= Divine) | 158–238, +109 heat | 174–259, −132 energy | ~198–298 |
| Ultimate lvl 100 | ~256–386, +158 heat | ~282–420, −191 energy | ~320–482 |

## Grenade launchers (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate. Reloaded names and stats. Range 3–6, **pull 1**, 2 uses at Epic and 3 from Legendary. The red version is a new recolour (`topGrenadeLauncher1*_heat`).

|  | Night Eagle (physical) | Red Mamba (heat, name is a placeholder) | Grim Cobra (electric) |
|---|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/topGrenadeLauncher1C.png\|100]] ![[Top Weapons/sprites/topGrenadeLauncher1D.png\|100]] ![[Top Weapons/sprites/topGrenadeLauncher1E.png\|100]] | ![[Top Weapons/sprites/topGrenadeLauncher1C_heat.png\|100]] ![[Top Weapons/sprites/topGrenadeLauncher1D_heat.png\|100]] ![[Top Weapons/sprites/topGrenadeLauncher1E_heat.png\|100]] | ![[Top Weapons/sprites/topGrenadeLauncher3C.png\|100]] ![[Top Weapons/sprites/topGrenadeLauncher3D.png\|100]] ![[Top Weapons/sprites/topGrenadeLauncher3E.png\|100]] |
| Epic | 66–102, weight 46, 9 energy / 9 heat | ~57–88, +23 heat, −2 cooling, weight ~55 | 57–88, −31 energy, −2 regen, weight 63 |
| Legendary | 106–168 | ~92–145, +37 heat, −7 cooling | 92–145, −49 energy, −7 regen |
| Mythical | 159–256 | ~138–221, +54 heat, −13 cooling | 138–221, −72 energy, −13 regen |
| Ultimate lvl 1 (= Divine) | 214–345 | ~186–298, +73 heat | 186–298, −97 energy |
| Ultimate lvl 100 | ~347–559 | ~301–483, +106 heat | ~301–483, −141 energy |

- Red Mamba stats are invented: Grim Cobra's damage, heat drain = 0.75 × its energy drain (the Falcon scopes' ratio), cooling = its regen.

## Supreme Cannons (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate. Reloaded name and stats. Range 3–6, **push 1**, 2 uses at Epic and 3 from Legendary, very heavy (weight 66). The electric version is a new blue recolour (`topSuperRocketLauncher2*_elec`).

|  | Supreme Cannon (heat) | Supreme Arc (electric, name is a placeholder) |
|---|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/topSuperRocketLauncher2C.png\|100]] ![[Top Weapons/sprites/topSuperRocketLauncher2D.png\|100]] ![[Top Weapons/sprites/topSuperRocketLauncher2E.png\|100]] | ![[Top Weapons/sprites/topSuperRocketLauncher2C_elec.png\|100]] ![[Top Weapons/sprites/topSuperRocketLauncher2D_elec.png\|100]] ![[Top Weapons/sprites/topSuperRocketLauncher2E_elec.png\|100]] |
| Epic | 65–96, +24 heat, −4 expl. res., costs 16 heat | ~65–96, −32 energy, −4 elec. res., costs 16 energy |
| Legendary | 104–157, +37 heat, −8 res. | ~104–157, −49 energy, −8 res. |
| Mythical | 154–240, +64 heat, −12 res. | ~154–240, −85 energy, −12 res. |
| Ultimate lvl 1 (= Divine) | 210–323, +73 heat | ~210–323, −97 energy |
| Ultimate lvl 100 | ~340–523, +106 heat | ~340–523, −141 energy |

- Supreme Arc stats are invented: same damage, the heat drain becomes an energy drain (heat ÷ 0.75, the Falcon scopes' ratio), same resistance drain.

## Super lasers: Iron Frenzy / Delerium (decided 2026-09-29)
**Legendary → Ultimate**, D = Legendary, E = Mythical + Ultimate. Reloaded names and stats, added as they are. Range 4–8, heavy (weight 52–56), one shot with a stat drain.

|  | Iron Frenzy (heat) | Delerium (electric) |
|---|---|---|
| Looks (Leg / Myth+Ult) | ![[Top Weapons/sprites/topSuperLaser2D.png\|100]] ![[Top Weapons/sprites/topSuperLaser2E.png\|100]] | ![[Top Weapons/sprites/topSuperLaser3D.png\|100]] ![[Top Weapons/sprites/topSuperLaser3E.png\|100]] |
| Legendary | 103–132, +37 heat, −3 expl. res., costs 30 heat | 109–144, −49 energy, −8 elec. res., costs 30 energy |
| Mythical | 155–202, +54 heat, −5 res. | 163–220, −72 energy, −12 res. |
| Ultimate lvl 1 (= Divine) | 215–280, +75 heat | 226–305, −100 energy |
| Ultimate lvl 100 | ~348–454, +109 heat | ~366–494, −145 energy |

## Desolation (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate. Reloaded name and stats. Artillery: range 4–8, 2 uses at Epic and 3 from Legendary, very heavy (weight 66), explosive with a small heat drain.

| | Desolation |
|---|---|
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/topArtillery2C.png\|100]] ![[Top Weapons/sprites/topArtillery2D.png\|100]] ![[Top Weapons/sprites/topArtillery2E.png\|100]] |
| Epic | 67–95, +16 heat, −3 expl. res., costs 20 heat |
| Legendary | 107–155, +25 heat, −6 res., costs 36 heat |
| Mythical | 160–236, +36 heat, −10 res., costs 56 heat |
| Ultimate lvl 1 (= Divine) | 216–319, +49 heat |
| Ultimate lvl 100 | ~350–517, +71 heat |

## Rocket showers: Burning Shower / Red Rain + energy forms (decided 2026-09-29)
**Legendary → Ultimate**, D = Legendary, E = Mythical + Ultimate. Reloaded names and stats for the red ones. **Pull 2.** The blue energy forms are new recolours (`*_elec`) with **invented** stats: same damage, the heat drain becomes an energy drain (heat ÷ 0.75, the Falcon scopes' ratio), the cooling drain becomes a regen drain, and the heat/energy costs swap. Names are placeholders.

|  | Burning Shower (heat) | Static Shower (electric) | Red Rain (heat) | Blue Rain (electric) |
|---|---|---|---|---|
| Looks (Leg / Myth+Ult) | ![[Top Weapons/sprites/topDiagonalRocketLauncher2D.png\|100]] ![[Top Weapons/sprites/topDiagonalRocketLauncher2E.png\|100]] | ![[Top Weapons/sprites/topDiagonalRocketLauncher2D_elec.png\|100]] ![[Top Weapons/sprites/topDiagonalRocketLauncher2E_elec.png\|100]] | ![[Top Weapons/sprites/topDiagonalRocketLauncherB2D.png\|100]] ![[Top Weapons/sprites/topDiagonalRocketLauncherB2E.png\|100]] | ![[Top Weapons/sprites/topDiagonalRocketLauncherB2D_elec.png\|100]] ![[Top Weapons/sprites/topDiagonalRocketLauncherB2E_elec.png\|100]] |
| Range / uses / weight | 4–8, 3, 75 | 4–8, 3, 75 | 2–4, 2, 65 | 2–4, 2, 65 |
| Legendary | 88–172, +45 heat, −8 expl. res., −5 cooling, costs 51 heat | ~88–172, −60 energy, −8 elec. res., −5 regen | 110–170, +56 heat, −10 cooling, costs 19 energy / 51 heat | ~110–170, −75 energy, −10 regen, costs 51 energy / 19 heat |
| Mythical | 132–263, +65 heat, −12 res., −10 cooling | ~132–263, −87 energy, −12 res., −10 regen | 165–260, +81 heat, −19 cooling | ~165–260, −108 energy, −19 regen |
| Ultimate lvl 1 (= Divine) | 183–365, +90 heat | ~183–365, −120 energy | 229–361, +112 heat | ~229–361, −149 energy |
| Ultimate lvl 100 | ~296–591, +131 heat | ~296–591, −174 energy | ~371–585, +162 heat | ~371–585, −216 energy |

## Spartan Carnage set (decided 2026-09-29)
**Legendary → Ultimate**, D = Legendary, E = Mythical + Ultimate. Reloaded name and stats for Spartan Carnage (physical, keeps its orange look). Range 3–6, 3 uses, weight 51. The heat and energy forms are new recolours (`topSuperMachineGun1*_heat/_elec`) with **invented** stats and placeholder names, built the way the Cockpit set does it: damage × 0.75 (heat) / × 0.78 (electric), a heat / energy drain instead of the physical resistance drain.

|  | Spartan Carnage (physical) | Spartan Inferno (heat) | Spartan Voltage (electric) |
|---|---|---|---|
| Looks (Leg / Myth+Ult) | ![[Top Weapons/sprites/topSuperMachineGun1D.png\|110]] ![[Top Weapons/sprites/topSuperMachineGun1E.png\|110]] | ![[Top Weapons/sprites/topSuperMachineGun1D_heat.png\|110]] ![[Top Weapons/sprites/topSuperMachineGun1E_heat.png\|110]] | ![[Top Weapons/sprites/topSuperMachineGun1D_elec.png\|110]] ![[Top Weapons/sprites/topSuperMachineGun1E_elec.png\|110]] |
| Legendary | 115–193, −9 phys. res., 20 energy / 20 heat | ~86–145, +40 heat, −9 expl. res. | ~90–151, −52 energy, −9 elec. res. |
| Mythical | 172–295, −15 res. | ~129–221, +61 heat, −15 res. | ~134–230, −78 energy, −15 res. |
| Ultimate lvl 1 (= Divine) | 238–408 | ~178–306, +85 heat | ~186–318, −108 energy |
| Ultimate lvl 100 | ~386–661 | ~288–496, +123 heat | ~301–515, −157 energy |

## Rear Hit Electro Mark (decided 2026-09-29)
Already done: kept exactly as in Reloaded (`grenadeLauncher1A/B`, names and stats as the Reloaded ones). Nothing to change.

## Bombs: Overloaded EMP / Overheated Heat Bomb (decided 2026-09-29)
**Legendary → Ultimate**, D = Legendary, E = Mythical + Ultimate. Reloaded names and stats. Range 3-6, 1 use. One shot with tiny damage and a huge drain of the enemy's energy or heat; it costs the user about as much as it drains and **backfires**. **The physical bomb (`topPhysicalBombD/E`) is dropped**: no physical resource to drain, not needed.

|  | Overloaded EMP (electric) | Overheated Heat Bomb (heat) |
|---|---|---|
| Looks (Leg / Myth+Ult) | ![[Top Weapons/sprites/topEMPD.png\|110]] ![[Top Weapons/sprites/topEMPE.png\|110]] | ![[Top Weapons/sprites/topHeatBombD.png\|110]] ![[Top Weapons/sprites/topHeatBombE.png\|110]] |
| Weight | 60 | 42 |
| Legendary | 18-32, -204 energy, costs 189 energy, backfire 123 | 18-32, +206 heat, costs 189 heat, backfire 123 |
| Mythical | 26-47, -300 energy, costs 300, backfire 180 | 26-47, +300 heat, costs 300, backfire 180 |
| Ultimate lvl 1 (= Divine) | 36-66, -415 energy, costs 415, backfire 180 | 36-66, +415 heat, costs 415, backfire 180 |
| Ultimate lvl 100 | ~58-107, -602 energy, backfire ~220 | ~58-107, +602 heat, backfire ~220 |

- Ultimate lvl 100 is estimated (drain x 1.45, damage x 1.62, backfire at half the drain's rate).

## Distance Closers (decided 2026-09-29)
**Epic → Ultimate**, C = Epic, D = Legendary, E = Mythical + Ultimate (Epic is invented: Legendary × 0.62, as in the Cockpit set; the Reloaded data starts at Legendary). Reloaded names and stats. Range 4–8, 2 uses, **push 1 and advance 3**: the shot also moves the user 3 steps closer.

|                               | Distance Shredder (physical)                                                                                                                                         | Space Invader (heat)                                                                                                                                                 | Party Crasher (electric)                                                                                                                                             |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Looks (Epic / Leg / Myth+Ult) | ![[Top Weapons/sprites/sideDistanceCloser1C.png\|100]] ![[Top Weapons/sprites/sideDistanceCloser1D.png\|100]] ![[Top Weapons/sprites/sideDistanceCloser1E.png\|100]] | ![[Top Weapons/sprites/sideDistanceCloser2C.png\|100]] ![[Top Weapons/sprites/sideDistanceCloser2D.png\|100]] ![[Top Weapons/sprites/sideDistanceCloser2E.png\|100]] | ![[Top Weapons/sprites/sideDistanceCloser3C.png\|100]] ![[Top Weapons/sprites/sideDistanceCloser3D.png\|100]] ![[Top Weapons/sprites/sideDistanceCloser3E.png\|100]] |
| Weight                        | 42                                                                                                                                                                   | 41                                                                                                                                                                   | 43                                                                                                                                                                   |
| Epic                          | ~72–126, −2 phys. res., costs ~39 heat                                                                                                                               | ~64–104, +12 heat, −2 expl. res.                                                                                                                                     | ~64–108, −16 energy, −2 elec. res.                                                                                                                                   |
| Legendary                     | 116–204, −3 res., costs 63 heat                                                                                                                                      | 103–168, +19 heat, −3 res.                                                                                                                                           | 104–175, −25 energy, −3 res.                                                                                                                                         |
| Mythical                      | 174–311, −5 res., costs 100 heat                                                                                                                                     | 155–257, +27 heat, −5 res.                                                                                                                                           | 155–265, −36 energy, −5 res.                                                                                                                                         |
| Ultimate lvl 1 (= Divine)     | 241–431                                                                                                                                                              | 215–356, +38 heat                                                                                                                                                    | 215–368, −50 energy                                                                                                                                                  |
| Ultimate lvl 100              | ~390–698                                                                                                                                                             | ~348–577, +55 heat                                                                                                                                                   | ~348–596, −73 energy                                                                                                                                                 |

## Penetrators (decided 2026-09-29, from the unmarked sheet)
**Epic → Legendary only.** A look = Epic, B look = Legendary. Legacy names Moon / Sun (physical), Heat Penetrator, Energy Penetrator; here they are one family per element. Short-range push shot (push 1), no use limit. **Invented stats**: Legacy Mark II (`laser40B*`) treated as Rare, × 1.7 for Epic (Rare → Epic ratio), × 1.62 for Legendary; damage as a range of about ±25%; Legacy weights and drains scaled the same. Energy version mirrors the heat one (`laser40B3` had no stats).

|  | Penetrator (physical) | Heat Penetrator | Energy Penetrator |
|---|---|---|---|
| Looks (Epic / Leg) | ![[Top Weapons/sprites/laser40A.png\|110]] ![[Top Weapons/sprites/laser40B.png\|110]] | ![[Top Weapons/sprites/laser40A2.png\|110]] ![[Top Weapons/sprites/laser40B2.png\|110]] | ![[Top Weapons/sprites/laser40A3.png\|110]] ![[Top Weapons/sprites/laser40B3.png\|110]] |
| Weight | 32 | 67 | 67 |
| Epic | ~82–136, push 1 | ~83–138, +60 heat, −7 cooling, push 1 | ~83–138, −60 energy, −7 regen, push 1 |
| Legendary | ~133–221 | ~134–224, +96 heat, −11 cooling | ~134–224, −96 energy, −11 regen |

## Missile Launchers (decided 2026-09-29, from the unmarked sheet)
**Common → Legendary**, four looks: A = Common, B = Rare, C = Epic, D = Legendary. Three types, one per element. The art had no accent colour, so each type lights the **barrel holes**: red (heat), yellow (physical), blue (energy). Range 3, push 1 (Common) then 2. **Invented stats**, built on the Legacy ones: Common = Legacy `22A` (33), Rare = `22B` (49), Epic = `22C` (87, weight 72), Legendary = Epic × 1.62 and the Legacy weight of `22D` (68) (the Legacy `22D` itself hit weaker than `22C`, so it isn't used). Common and Rare are fixed damage, Epic and Legendary a ±25% range. Physical = ×1.25 damage, no drain (like Storm Rage). Energy = same damage as heat, energy drain = heat drain ÷ 0.75.

|  | Missile Launcher (heat) | Shrapnel Launcher (physical) | Arc Launcher (energy) |
|---|---|---|---|
| Looks (Common / Rare / Epic / Leg) | ![[Top Weapons/sprites/rocketLauncher22A_heat.png\|90]] ![[Top Weapons/sprites/rocketLauncher22B_heat.png\|90]] ![[Top Weapons/sprites/rocketLauncher22C_heat.png\|90]] ![[Top Weapons/sprites/rocketLauncher22D_heat.png\|90]] | ![[Top Weapons/sprites/rocketLauncher22A_phys.png\|90]] ![[Top Weapons/sprites/rocketLauncher22B_phys.png\|90]] ![[Top Weapons/sprites/rocketLauncher22C_phys.png\|90]] ![[Top Weapons/sprites/rocketLauncher22D_phys.png\|90]] | ![[Top Weapons/sprites/rocketLauncher22A_elec.png\|90]] ![[Top Weapons/sprites/rocketLauncher22B_elec.png\|90]] ![[Top Weapons/sprites/rocketLauncher22C_elec.png\|90]] ![[Top Weapons/sprites/rocketLauncher22D_elec.png\|90]] |
| Weight | 12 / 30 / 72 / 68 | 12 / 30 / 72 / 68 | 12 / 30 / 72 / 68 |
| Common | 33, +2 heat, push 1 | 41, push 1 | 33, −3 energy, push 1 |
| Rare | 49, +9 heat, push 2 | 61, push 2 | 49, −12 energy, push 2 |
| Epic | ~65–109, +27 heat, push 2 | ~81–136 | ~65–109, −36 energy |
| Legendary | ~106–176, +42 heat, push 2 | ~132–220 | ~106–176, −56 energy |

## Straight Shots (decided 2026-09-29, from the unmarked sheet)
**Rare → Epic**, A look = Rare, B look = Epic. Three types by element: the orange accent lights recoloured red (heat) and blue (energy). Legacy Straight Shot Mark I/II (physical, weight 11-13, damage 38) used as the Common baseline, so **invented stats**: Rare = Legacy × 1.9, Epic = Rare × 1.69 (the ladder in item-format.md), damage as a ±25% range. Physical is the base; heat and energy are ÷ 1.25 damage with a drain (heat = 0.31 × avg damage, energy = 0.42 ×, the Cockpit / Grim Cobra ratios). Range 4, Epic has push 1 (Mark II). Names are placeholders.

|  | Straight Shot (physical) | Scorch Shot (heat) | Arc Shot (energy) |
|---|---|---|---|
| Looks (Rare / Epic) | ![[Top Weapons/sprites/cannon5A.png\|110]] ![[Top Weapons/sprites/cannon5B.png\|110]] | ![[Top Weapons/sprites/cannon5A_heat.png\|110]] ![[Top Weapons/sprites/cannon5B_heat.png\|110]] | ![[Top Weapons/sprites/cannon5A_elec.png\|110]] ![[Top Weapons/sprites/cannon5B_elec.png\|110]] |
| Weight | 11 / 13 | 11 / 13 | 11 / 13 |
| Rare | ~54–90 | ~43–72, +18 heat | ~43–72, −24 energy |
| Epic | ~92–152, push 1 | ~74–122, +30 heat, push 1 | ~74–122, −41 energy, push 1 |

## Lasers and Repeaters (decided 2026-09-29, from the unmarked sheet)
**Rare → Epic**, B look = Rare, C look = Epic. Three types each, by element. No stats or names in any data, so **everything is invented (placeholder names)**, built on the Straight Shot numbers (Rare ~ Legacy × 1.9, Epic × 1.69; physical = ×1.25 damage with no drain, heat/energy = ÷ 1.25 with a heat/energy drain).

**Lasers**: the red and blue are the native art; yellow is a new recolour (`topLaser2*_phys`). Range 5–8, 1 use, weight 30 / 34.

|  | Ember Laser (heat) | Ion Laser (energy) | Amber Laser (physical) |
|---|---|---|---|
| Looks (Rare / Epic) | ![[Top Weapons/sprites/topLaser2B.png\|110]] ![[Top Weapons/sprites/topLaser2C.png\|110]] | ![[Top Weapons/sprites/topLaser3B.png\|110]] ![[Top Weapons/sprites/topLaser3C.png\|110]] | ![[Top Weapons/sprites/topLaser2B_phys.png\|110]] ![[Top Weapons/sprites/topLaser2C_phys.png\|110]] |
| Rare | ~43–72, +18 heat | ~43–72, −24 energy | ~54–90 |
| Epic | ~74–122, +30 heat | ~74–122, −41 energy | ~92–152 |

**Repeaters (machine gun)**: the orange is native physical; red and blue are new recolours. Many small shots: damage × 0.6 of the Straight Shot line, but 2 uses at Rare and 3 at Epic. Range 3–5, weight 22 / 26.

|  | Repeater (physical) | Flame Repeater (heat) | Arc Repeater (energy) |
|---|---|---|---|
| Looks (Rare / Epic) | ![[Top Weapons/sprites/topMachineGun1B.png\|110]] ![[Top Weapons/sprites/topMachineGun1C.png\|110]] | ![[Top Weapons/sprites/topMachineGun1B_heat.png\|110]] ![[Top Weapons/sprites/topMachineGun1C_heat.png\|110]] | ![[Top Weapons/sprites/topMachineGun1B_elec.png\|110]] ![[Top Weapons/sprites/topMachineGun1C_elec.png\|110]] |
| Rare | ~32–54, 2 uses | ~26–43, +11 heat, 2 uses | ~26–43, −14 energy, 2 uses |
| Epic | ~55–91, 3 uses | ~44–73, +18 heat, 3 uses | ~44–73, −25 energy, 3 uses |

## Slot fixes (2026-09-27, applied to the roster 2026-09-28)
- **Moving in:** Distance Shredder, Space Invader, Party Crasher (`sideDistanceCloser1–3`), confirmed top weapons.
- **Moving out to side weapons:** the `cannon11` family (Cracked Plasma Cannon, Obsolete Energy Cannon, Unrepaired Laser Cannon), confirmed side weapons.
