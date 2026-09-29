# Module Decisions

**Modules are DONE (2026-09-27).** Final sprites: `final/<Group>/<Item>/` (104 sprites, 26 items). Tests, samples and rejected versions: `_archive/`. Full stats: [[Module Roster]].

Notes from planning sessions. Sprites are on [[Modules]].

## Ladders

### Armor (HP)
**Names:**
- Path 1 (Reloaded `HP1`–`HP5`) = **Platinum Plating**
- Path 2 (gold skeleton plates `HP11`–`HP15`) = **Tungsten Carbide Plating**
- **Dropped:** the plain H-plates (`HP6`–`HP10`). Armor is complete.

- **Armor Plating line:** Reloaded `module_HP1` → `HP2` → `HP3` → `HP4` → `HP5` (Platinum Plating as the top step).
- **One full path:** Armor Plating → Platinum Plating, as a single upgrade line.
- Use the original Reloaded sprites as they are. No recolors, no edits.
- `module_HP4` (probably Platinum Plating's Epic look) keeps its slanted center bar. That's the original art, and the game file draws it the same way.
- **Gold path:** the Legacy H-shaped gold-frame plates (`module_HP11`–`HP15`) form their own full path.
  - **Final look (approved):**
    - frame gradient in orange-gold (`#ffa31a` → `#e58900` → `#b3560a`), with a dark outline, a `#ffcc00` rim and a faint sheen
    - accent lights use the physical-element gradient from Reloaded (`#ffcc00` → `#ff9a00` → `#ff6600`, as on the physical resistance modules)
    - the glow halo over the square light removed
    - Reloaded-style silver lighting gradients on the steel parts, dark at the top and light at the bottom, like Platinum Plating
    - bottom grille bars use Reloaded's soft steel gradient
    - round gray studs and white hairlines removed; frame sheen removed
    - center square socket shrunk (scale 0.42), with the gold frame showing as a U around it
    - round port rims in muted steel (`#b3b3b3` → `#626262`)
    - top accent bars use Platinum Plating's light gradient (`#ff9a00` → `#ff6033`)
    - Comparison sheet: `gold-plates/platinum-vs-tungsten.png`
  - Reference: `refs/gold-armor-reference.webp`.
  - Art: `gold-plates/gold-plates.png` (original on top, brightened below). Script: `tools/gold_hplates.py`.
- Dropped: the gold-frame recolor of the Reloaded plates, the glowing square core, and extra center details.

### Energy (in progress)
- There are three visual lines:
  - Engine box `energy3/4/5` → **Energy Engine** (balanced)
  - Gold-ring generators `energy11–14` (`energy14` = Reloaded Energy Storage Unit)
  - Battery cells `energy101–105` → **Energy Mass Booster** (regen)
- Energy needs a gold (heavy) option, because heavy energy weapons drain a lot.
- **Heavy Energy Booster:** the gold version of the Energy Mass Booster, as a heavy regen module (more regen, more weight).
- **Gold Energy Mass Booster art (approved):** the gray side unit turns gold (brightness kept); every blue part stays blue, and the cables are gold too.
  - Files: `energy/energy101_gold` … `energy105_gold`. Script: `tools/gold_energy_booster.py`.
- **Energy Engine:** starts at **Epic** (Epic → Legendary → Mythical → Ultimate).
  - Sprites: `energy3` Epic, `energy4` Legendary, `energy5` Mythical/Ultimate.
  - Stats: Reloaded values, weight 25; Ultimate 92→~149 capacity, 44→~72 regen.
- **Ultimate Energy Engine:** the gold heavy version of the Energy Engine.
  - **Art (approved):** the light steel parts turn gold; the gray body and blue cells stay.
  - Files: `energy/energy3_gold` … `energy5_gold`. Script: `tools/gold_energy_engine.py`.
- Stats and tuning for both engines are approved (details in `.claude/tracking/item-format.md`).
- **Energy Storage Unit:** capacity only, starts at Legendary.
  - Sprites: `energy12` Legendary, `energy13` Mythical, `energy14` Ultimate. `energy11` is dropped.
- **Heavy Energy Storage Unit:** the gold version. **Art (approved):** only the top head is gold (a center-column and a lower-block gold version were tried and rejected).
  - Files: `energy/energy12_gold` … `energy14_gold`. Script: `tools/gold_energy_storage.py`.
- **Energy is complete:** Mass Booster / Heavy Energy Booster, Energy Engine / Ultimate Energy Engine, Storage Unit / Heavy Storage Unit.

### Heat (done)
- **Mirrors energy exactly** (user decision): same stats, tiers, weights, tuning and gold treatments.
- Lines:
  - **Cooling Mass Booster** / **Heavy Cooling Booster**: `heat101–105` (Heat Control cells)
  - **Heat Engine** / **Ultimate Heat Engine**: `heat3/4/5`
  - **Heat Storage Unit** / **Heavy Heat Storage Unit**: `heat12/13/14`
- Dropped: `heat2` (Heat Module 1).
- `heat12/13` were filed as "Engine Booster I/II" in the roster; they belong to this line.
- Gold art: `heat/heatN_gold`. Script: `tools/gold_heat.py`. Stats: see [[Module Roster]].

### Combined modules (saved for now)
- Four items, each with a Heavy (gold) version:
  - **Combined Storage Unit** (`regularEnergyHeatCap4/5`)
  - **Combined Engine Unit** (`superEnergyHeatCap4/5`)
  - **Quad Core Booster** (`superEnergyHeatCapReg4/5`)
  - **Overload Preventor** (`superEnergyHeatReg4/5`)
- `regularEnergyHeatCap3` is dropped.
- **Mythical drops only** (Mythical → Ultimate). Earlier look = Mythical, named look = Ultimate.
- **Stats boosted 1.6×** over Reloaded by design. Heavy = ×1.35 more, about 37% heavier.
- **Open check (stacking):**
  - Worry: a mech filled with combined modules could make energy and heat meaningless.
  - The user notes that Ultimate weapons hit very hard, so the numbers may be justified.
  - **Decision:** keep the design as is. Once Ultimate weapon damage and energy/heat costs exist, simulate a fully stacked mech against a normal one. Add an equip limit (e.g. 1 combined per mech) only if the stacked mech wins too easily.
  - Late-game enemies use combined modules too.
- **Heavy versions are Mythical drops too** (confirmed).
- Open: the Heavy names ("Heavy ___" for now).

### Resistances (in progress)
- 76 sprites: 4 element sets (All, Electric, Explosive, Physical) × 4 art styles:
  - **A. Reloaded** `2–5`
  - **B. Legacy** `6–10`
  - **C. Legacy wide** `11–18`
  - **D. Fortress** `HP4/HP5` (Electric Fortress, Plasma Fortress, Platinum Fortress, Defence Matrix)
- **Style B restyle (approved, "amazing"):**
  - accent gradients (lighter top, deeper bottom) and silver steel
  - dark outline
  - depth: gentle top-down light and light edge shadows
  - **bevels**: bright top-left rim, dark bottom-right rim on every part
  - **Reloaded shields** transplanted from `module_resistance<Elem>5`
  - Files: `resist/<Elem>6–10.png` (depth and bevels are baked into the PNGs). Script: `tools/restyle_resist.py`.
- **Ladders (user decision):**
  - **Resistance Module:** Reloaded art unchanged, **Epic → Ultimate**, sprites `2` Epic, `3` Legendary, `4` Mythical, `5` Ultimate.
  - **Enhanced Protector:** restyled style B, **Mythical drop** (Mythical → Ultimate), **one look only: sprite `10`** (full bars).
  - **Fortress / Defence Matrix:** Reloaded art unchanged, **Legendary → Ultimate** (`HP4` Legendary, `HP5` Mythical/Ultimate).
- **LOCKED (2026-09-26):** Resistance Module, Enhanced Protector and Fortress/Defence Matrix, with the stats below.
  - The Enhanced Protector keeps the module weights (28 / 51).
  - All three Fortresses are evened out (Plasma no longer higher).
  - **Style C (11–18) is dropped.**
  - Full tables are in [[Module Roster]].
- Stats:
  - Module, single element: Epic 17→24 … Ultimate 63→~102. All-element: 11→16 … 41→~77.
  - Enhanced Protector: 1.6× the module.
  - Fortress: 166→~271 HP + 63→~102 at Ultimate. Defence Matrix: 183→~335 HP + 41→~77 each.
- Rendering note: the SVG renderer draws the Reloaded All-element body black. Use the decompiler PNGs for Reloaded art.
- **Heavy (gold) Enhanced Protectors: yes** (user, 2026-09-26). Name: **Ultimate Protector** (Electric / Explosive / Physical / All-element).
  - **Why:** Ultimate long-range scope weapons hit very hard (e.g. **1,200+ per hit on Falcon** when the attacker pushes to max range and snipes). Flat resistance of ~220 (or ~440 stacked) only softens those hits, so high resistance is a survival tool, not immunity.
  - Stats: Enhanced ×1.35, heavier, Mythical drop. Ultimate L100 ~220 single element, ~166 each All-element.
  - Still part of the stacking balance check once weapon damage exists.
- **Ultimate Protector art (approved):** one shared gold body (from Explosive), each element's own screen/shields and meter bars in its element colour. Script: `tools/ultimate_protector.py`. Shields are vector Reloaded shields placed per Legacy shield (`tools/vector_shields.py`).
- Open:
  - style C (11–18)
  - confirm the 1.6× Enhanced boost
  - match the Explosive Fortress to the others

## Naming

## Open questions
