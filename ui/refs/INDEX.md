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
| battle-pickups-loot.webp | Battle after picking up a kit and destroying structures: left column now stacks three panels (STATS, PICKUPS with the kit icon, WIN LOOT with gold amount), crater sprites left on the floor where crates were destroyed |
| battle-explosion.webp | Explosion effect that plays when any structure is destroyed; two pickups now shown (repair, energy) and Win Loot at 150 gold; craters left on the floor |
| battle-fight.webp | 1v1 fight view: player panel top-left and enemy panel top-right (portrait, name, HP bar, energy and heat bars, resist shields, turn lamps), settings and power buttons in the centre, zoom button, action bar bottom-left (6 slots: move, target, shield, empty, flame, chevrons) and x2 / play bottom-right, tech-panel strip above the bar |
| battle-hover-enemy-weapon.webp | Hovering an enemy weapon in the fight view: a red-bordered stat card appears on the left (knockback, heat gain, resist, damage range 130-275, resist drain -6), a green-bordered card on the right (turn lamps, +11 heat, EPIC rarity), the targeted mech tints red and red beams shoot up from the ground |
| battle-hover-shutdown.webp | Hovering the chevrons icon on the action bar: green label bar above the bar reads "Shut engine down", the icon slot outlines green, a green card on the left shows -202 heat |
| battle-hover-stomp.webp | Hovering the flame/claw icon: label "Stomp", green MYTHICAL card on the left, red stat card on the right (knockback 1, energy drain 71, resist 5, damage 134-203), enemy tinted red with red beams |
| battle-out-of-range.webp | Weapons sub-menu of the action bar (back arrow, then item icons): hovering Grappling hook shows a red "OUT OF RANGE" banner with crossed-out range icons over the arena, label bar reads "Grappling hook", green card left (+11 heat), red card right (13, 7, damage 34-43), red beams on the enemy, the last slot dimmed |
| upgrade-transform.png | Upgrade, Transform mode (selected item at level cap, Mythical target, 5 empty material slots, Transform button with gold cost, locked tile in grid) |

Still to come: item detail, others as sent. Battle action bar: chevrons = Shut engine down, flame/claw = Stomp; move, target, shield and the empty slot still unconfirmed.
Open question: meaning of the mech glyph + number on item tiles ("/50" looks like a cap, MAX replaces it).

## Seen in chat, no file saved (push to ui/refs/ if you want them kept)
- upgrade-mass-select: Upgrade with Mass Select open. Rarity checkboxes (Common / Rare / Epic), Element checkboxes (Physical / Explosive / Electric), Item type icon grid (7 types with checkmarks). Selected item shows in the machine slot with a row of chosen items below, "LEVEL 23 / 50", XP bar "92,366/95,320 +2", stat lines with +N gains, Boost button with gold cost 24,026.
- Confirmed: "/50" on item tiles is the level cap (LEVEL 23 / 50). The small number beside the mech glyph is still unexplained.
- battle-zoomed-out (seen in chat, no file): Fight view after pressing the zoom button (icon flips from minus to plus). Camera pulls back so both mechs are small and the full arena background shows (tower, chains, rocks), with a small rocket-like object at each screen edge. The HUD, weapons sub-menu and buttons stay the same size.
