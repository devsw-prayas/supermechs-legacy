# Decisions

- **Scope:** long single-player campaign that merges the pre-transformation and transformation-era items.
- **Hosting:** Next.js.
- **Database:** Neon (Postgres).
- **Login:** Google and Discord.
- **Process:** catalog, then items, then plan, then code. No code before the plan is agreed.
- **Transformation:** every item (Legacy too) transforms Common → Divine. Levels and enemies get harder to match. Details in item-format.md.
- **No ammo system:** bullets and rockets are infinite. The `bulletsCap`/`rocketsCap` stats, bullet/rocket modules and kits are dropped. Legacy weapons that used ammo get heat/energy costs instead (see item-format.md). The per-battle `uses` limit on special weapons is a separate thing and is kept unless decided otherwise.
- **Late campaign:** most enemy bots use Ultimate, tuned gear, so the player faces much more firepower. The Ultimate 100-level climb (option A) is what keeps the player competitive.
- **Campaign structure:** 19 zones.
  - **Main campaign:** played 3 times, in 1v1 → 2v2 → 3v3. Enemy gear goes **up to Mythical** only.
  - **Huntdowns:** in the 3 main campaigns, each zone has **2–3 huntdowns**. These are repeatable farming missions, played many times for item drops, tokens and credits. **Unlimited replays:** no energy or stamina and no daily caps. **Ultimate mode has no huntdowns.** Its regular missions are the grind, and they are hard enough already.
  - **Ultimate mode:** the full campaign again. Every bot is maxed at Ultimate and tuned, and some are **Divined**. This is the endgame for the Ultimate 100-level climb, tuning and divining.
  - Assumed: Ultimate mode covers all three formats (1v1/2v2/3v3), so 6 passes and about 1,320 missions at about 11 per zone. Still to confirm.

# Research notes
- Community names for the eras: pre-transformation = **"Legacy"**, transformation era = **"Reloaded"**, which launched in 2017. Tiers: Common, Rare, Epic, Legendary, Mythical, and later Divine.
- **Disproved:** 2.411 (May 2017) already has transform screens, mythical crafting and fusion in its code (`BMScreenHangerTransformPreview`, `craftMythicals`, `epicToMythical`). So it is Reloaded-era, and Legacy is older than 2.411.
- **Found Legacy:** the Wayback Machine has the Flash client from supermechs.com, 787 unique SWF snapshots from 2013 to 2026. Transformation (`HangerTransform`) first appears between 2017-03-23 and May 2017. Last pre-transformation set: **2017-03-23** → `extracted/old/flash-2017-03-23/` (music library from 2015-05, the newest archived copy). Mythical crafting and fusion existed before transformation.
- The item library sizes of Legacy 2017-03 and 2.411 are nearly identical, so the roster may barely differ at that point. Earlier Flash snapshots (2013–2016) may hold items removed later. Compare once decompiled.
- 2.411 APK moved to `extracted/early-reloaded/`.
- To re-query the snapshots: `web.archive.org/cdx/search/cdx?url=supermechs.com&matchType=domain&filter=mimetype:application/x-shockwave-flash`
- Reloaded = 7.628.4 (final, May 2023). It adds Divine.

# Open questions
- Where exactly are the extracted files, and what formats are they in?
- How do we balance old fixed-stat items against transformation-era stat scaling?
- Do we need guest saves (in the browser, before login)?
- 2026-09-28: **Paint system comes later** (Reloaded-style mech paint that tints the `mcColor` layer). Until then, items use their Reloaded looks as they are, including the white `E` Mythical looks.
- **2026-09-29: Resistance can go below zero.** Negative resistance increases the damage taken (e.g. drain physical resistance, then a maxed Falcon lands ~2,000). Drain-then-burst combos are intended. Exact formula for the combat phase.
- **2026-09-29: Backfire at Ultimate.** The data has no backfire past Mythical. Rule: backfire follows the data up to Mythical, then grows at **half the damage's growth rate** through Ultimate (e.g. Lazy Falcon 490 at Mythical → ~583 at Ult 1 → ~737 at Ult 100). Applies to all backfire items.
