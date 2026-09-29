# Hub (main menu) background – Reloaded 7.628.4

Source: `extracted/transform/supermechs-7.628.4/assets/bmmClientCC.swf`, exported with JPEXS 26.3.0 (`tools/ffdec/ffdec-cli.jar`).
Screen class `net.battleMechsMulti.screens.mainMenu.BMScreenMainMenu` = symbol 2595. PNGs are 2x, SVGs 1x.

## Scene layers (frame 1 of symbol2595, back to front by depth)
| depth | instance | char id | what |
|---|---|---|---|
| 1 | `mcBgDark` | 2472 | dark background (sprite: JPEG 2470 + shape 2471) |
| 3 | `mcBgLight` | 2475 | light background (sprite: JPEG 2473 + shape 2474) |
| 5, 7, 9 | `mcSpecialEventImageHolder`, `mcSnowFlakesHolder`, `mcPlatformsCenter` | 5 | empty placeholder sprites (code fills them at runtime) |
| 13 | (unnamed) | 2479 | floor/platform art shape (bitmaps 2476 lossless, 2477 + 2478 JPEG3 side pieces) |
| 14+ | `mcSupportBtn`, `mcArenaButton`, `mcCampaignButton`, ... | 2486+ | UI buttons/badges, not background |

No pedestal, lamp, chain or carousel clips exist in this symbol. Anything like that is spawned by code.

## Files
- `svg/screen/.../1.svg`, `png/screen/.../1.png` – whole symbol2595, frame 1. **UI buttons are included**; JPEXS cannot hide children on export.
- `svg/mcBgDark/DefineSprite_2472/1.svg`, `png/mcBgDark/.../1.png` – dark background (1605x758 at 2x)
- `svg/mcBgLight/DefineSprite_2475/1.svg`, `png/mcBgLight/.../1.png` – light background (1605x758 at 2x)
- `svg/parts/2471.svg`, `png/parts/2471.png` – shape inside mcBgDark
- `svg/parts/2474.svg`, `png/parts/2474.png` – shape inside mcBgLight
- `svg/parts/2479.svg`, `png/parts/2479.png` – unnamed depth-13 art (1619x577 at 2x)
- `png/parts/2470.jpg` – raw bitmap of dark background
- `png/parts/2473.jpg` – raw bitmap of light background
- `png/parts/2476.png` – lossless bitmap used by 2479 (1069x133)
- `png/parts/2477.png`, `png/parts/2478.png` – JPEG3 (alpha) bitmaps used by 2479 (64x282, 63x282)
