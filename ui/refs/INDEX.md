# UI reference screenshots

Reloaded-era client, taken from the user's own account (2026-09-29). Reference only, do not copy account details into notes or mocks.
`login.webp` (username visible) is kept local only and is not in the repo.

| File | Screen |
|---|---|
| loading.png | Loading screen |
| main-menu.webp | Main menu (New Player / Log In) |
| login.webp | Login dialog |
| hub.webp | Hub (top HUD, achievements, bottom nav dock) |
| shop-item-boxes.webp | Shop: Item boxes tab |
| shop-gold.webp | Shop: Gold tab |
| shop-mechs.webp | Shop: Mechs tab (prebuilts) |
| shop-customize.webp | Shop: Customize (paints) |
| shop-unclaimed.png | Shop: Unclaimed Boxes (empty state) |
| upgrade-empty.png | Upgrade, nothing selected |
| upgrade-maxed-item.png | Upgrade, maxed item selected |
| upgrade-complete.png | Item Boosted result screen (ribbon level, stat rows, item art, XP bar, SWEET! button) |
| upgrade-complete-mission-toast.png | Same result screen with a "Mission completed" toast at the top |
| upgrade-boost-selected.png | Upgrade with an item selected (level 41/50, XP bar, HP / Energy / Heat lines, Boost button) and a full grid with orange, gold, purple and locked tile borders |
| workshop.png | Workshop editor: category buttons down the left, mech on a pedestal with weight bar and equipped items, Mech Summary stats panel, inventory grid with scroll buttons |
| teams.png | Teams dialog: team list on the left (selected one outlined orange), three mech cards with weights on the right, Rename / Clone / Select buttons |
| quests-daily.webp | Daily Quests tab: quest cards with round icon, title, task, reward, Claim / progress button, countdown under the tab |
| quests-achievements.webp | Achievements tab: cards with star tiers, COMPLETED sash across finished ones, progress buttons |
| select-campaign.webp | Select Campaign dialog: stacked campaign cards (1v1 / 2v2 / next below), each with map preview and stars, progress bar, Enter button, scroll arrows |
| campaign-map-final-zone.webp | Campaign map, last zone: hex mission nodes with numbers and 3-star ratings, boss tower node, energy counter (89/79) with back button top-left, player marker with badge |
| campaign-map-danger-zone.webp | Zone name banner reference: blue ribbon with cream outline, swallow-tail ends, white heavy title ("THE DANGER ZONE"), shown at the top of the map on zone entry. Also a mid-zone map view. Windows Snipping Tool popup in the corner is not part of the game UI |
| campaign-mission-select.webp | Mission panel over the map: Normal / Hard / Insane difficulty tabs with star medallions, Rewards list (gold, box, XP), green Battle button with energy cost, orange "Watch ad" banner below |
| battle.png | Live battle screen: top HUD strip (gold, tokens, level + XP bar, star rank badge), STATS panel top-left (HP bar, energy, regen, heat, cooling), red X (leave) / x1 (battle speed) / play (auto-play) buttons bottom-left, grid arena with walls and crates on the right |
| battle-tile-select.png | Same battle screen a moment after clicking a floor square: the tile flashes solid green (move target). Speed button now reads x2 |
| battle-attack-structure.webp | Clicking a structure (crate) in battle: the player mech fires, muzzle flames and hit sparks on the target, targeting crosshair on the enemy |
| battle-pickups-loot.webp | Battle after picking up a kit and destroying structures: left column now stacks three panels (STATS, PICKUPS with the kit icon, WIN LOOT with gold amount), dust clouds where crates were destroyed |
| upgrade-transform.png | Upgrade, Transform mode (selected item at level cap, Mythical target, 5 empty material slots, Transform button with gold cost, locked tile in grid) |

Still to come: item detail, manual-mode action bar (weapons, movement, turn UI) if it exists separately from auto-play, others as sent.
Open question: meaning of the mech glyph + number on item tiles ("/50" looks like a cap, MAX replaces it).

## Seen in chat, no file saved (push to ui/refs/ if you want them kept)
- upgrade-mass-select: Upgrade with Mass Select open. Rarity checkboxes (Common / Rare / Epic), Element checkboxes (Physical / Explosive / Electric), Item type icon grid (7 types with checkmarks). Selected item shows in the machine slot with a row of chosen items below, "LEVEL 23 / 50", XP bar "92,366/95,320 +2", stat lines with +N gains, Boost button with gold cost 24,026.
- Confirmed: "/50" on item tiles is the level cap (LEVEL 23 / 50). The small number beside the mech glyph is still unexplained.
