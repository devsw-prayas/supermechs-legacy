# Zones folder

| Folder | What's in it |
|---|---|
| `Zones.md` | The 19-zone route and zone list |
| `Art Prompts.md` | Prompts used for the zone art (canvas fill, road fix, structure restyle) |
| **`map/`** | **Finished map.** `full-map-1500.png/.jpg` (all zones stitched), `full-map-zones.txt` (x position + width of each zone), `zones-1500/` (hi-res zones), `zones-960/` (in-game size), previews |
| `work/` | Working files the tools read and write: `zones/` (merged zones before road fix), `road/` (road-fixed zones, 1500 tall), `canvas/` (canvases + raw GPT outputs), `checks/` (seam/road check images) |
| `reference/` | Original game art: `reloaded-worldmaps/` (3 maps × 7 parts + contact sheets), `reloaded-battle-backgrounds/`, `legacy-worldmap/`, `legacy-battle-backgrounds/`, `style/trial-1.webp` (style reference given to GPT) |
| `drafts/` | Unused zone ideas (The Junkyard) |
| `archive/` | Experiments and rejected tries (kept, not used) |

## Rebuild the map
```
python tools/seam_blend.py                 # map/zones-960
ZONE_H=1500 python tools/seam_blend.py     # map/zones-1500
python tools/build_full_map.py 1500        # map/full-map-1500.*
```
Replace a zone: new canvas `python tools/zone_canvas.py canvas N` → fill in ChatGPT → `python tools/zone_canvas.py merge N <img>`. Road/structure edit from Gemini: `python tools/road_transplant.py N <img> [wm_x wm_y]`.

## 2v2 and 3v3 maps
| Folder | What's in it |
|---|---|
| **`map-2v2/`** | War-torn version: `full-map-1500.png/.jpg`, `zones-1500/`, `zones-960/` |
| **`map-3v3/`** | Corrupted night version (dark red grade over 2v2): same layout |
| `work/2v2-raw/` | ChatGPT outputs as received |
| `work/2v2/zones/` | Cropped zones (`.orig` = before road bend, `.presoft` = before soften) |
| `work/3v3/zones/` | Graded zones |

Add a 2v2 zone: `python tools/add_variant_zone.py 2v2 N <img> [--keep]`, then `VER=2v2 python tools/soften.py 0.6 N`, `python tools/night_grade.py N`, then for V in 2v2 3v3: `VER=$V python tools/seam_blend.py`, `VER=$V ZONE_H=1500 python tools/seam_blend.py`, `VER=$V python tools/build_full_map.py 1500`.
Fix a road height at a seam: `VER=2v2 python tools/road_bend.py N DY`.
