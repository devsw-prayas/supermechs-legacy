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

Still to come: workshop editor, item detail, battle HUD, others as sent.
Open question: meaning of the mech glyph + number on item tiles ("/50" looks like a cap, MAX replaces it).

## Seen in chat, no file saved (push to ui/refs/ if you want them kept)
- upgrade-mass-select: Upgrade with Mass Select open. Rarity checkboxes (Common / Rare / Epic), Element checkboxes (Physical / Explosive / Electric), Item type icon grid (7 types with checkmarks). Selected item shows in the machine slot with a row of chosen items below, "LEVEL 23 / 50", XP bar "92,366/95,320 +2", stat lines with +N gains, Boost button with gold cost 24,026.
- upgrade-result-mission-toast: Result screen after a boost. Red ribbon "Level 26 / 50", stat list (weight, HP, Pys Dmg, Resist drain, Range, Knockback, Walking, Jumping), item art with glow and name, XP bar, blue "SWEET!" button. A "Mission completed" toast (checklist icon + green tick, orange title, white mission text) slides in at the top.
- Confirmed: "/50" on item tiles is the level cap (LEVEL 23 / 50). The small number beside the mech glyph is still unexplained.
- upgrade-complete: The plain "ITEM BOOSTED" result screen (same as upgrade-result-mission-toast without the toast). Orange title, red ribbon "Level 26 / 50", eight stat rows on dark strips with white icons, item art on a light-burst, gold item name, XP bar "96,848 / 103,560", blue "SWEET!" button, in the same blue frame with no title bar.
