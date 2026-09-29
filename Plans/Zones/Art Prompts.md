# Zone Art Prompts

Prompts for generating the 12 new zone panels with GPT image generation. Afterwards Claude fixes the road joins, blends the edges into the neighbouring zones and resizes to 800×480.

## How to use
1. Start each chat by attaching 2–3 original panels as style reference (e.g. `reloaded-worldMapPart1.png`, `reloaded-worldMapPart2.png`, `reloaded-worldMapPart5.png` from `reference/`).
2. Also attach **the two neighbouring zones** (listed per zone) so the colours at the edges match.
3. Paste the **Style block** + the zone prompt. Ask for a **landscape 3:2** image (1536×1024).
4. (Old full-panel method, superseded by the canvas method below.)

## Style block (paste before every zone prompt)
> Top-down game world map panel for a mobile mech game, in the exact style of the attached reference images: flat low-poly vector art, clean faceted shapes with a lit top face and darker side faces, soft ambient shadows, smooth colour gradients, slight vignette at the corners, no outlines, no texture noise, no text, no UI, no characters, no mechs. Seen from high above at a slight angle. A single wide glowing path (about 1/15 of the image height wide, soft glowing edges, lighter than the ground) winds across the panel as an S-curve, entering at the left edge a little above the middle and leaving at the right edge a little above the middle. Keep open ground around the path so mission markers can be placed on it. Scenery on the top and bottom edges frames the path. Landscape, 3:2.

## Zone prompts

### 2 · Canyons (between ★Desert and Desert Outpost)
> Red-orange desert canyons. Tall layered sandstone mesas and buttes with horizontal strata, deep shadowed ravines along the top and bottom edges, a dry cracked riverbed, a natural rock arch near the path, scattered boulders. Path colour: warm orange. Left edge matches plain orange desert sand; right edge becomes darker cracked brown earth.

### 3 · Desert Outpost (between Canyons and Forest Grasslands)
> Cracked brown desert with a hostile military outpost: low-poly metal bunkers, radar dish, fuel tanks, sandbag walls, a landing pad and a few watchtowers, grey and rust colours with small red lights. Tyre tracks in the sand. The right quarter starts showing patches of dry yellow grass and a few small shrubs. Path colour: orange fading to yellow-green on the right.

### 4 · Forest Grasslands (between Desert Outpost and ★Forest)
> Rolling green grassland plains with soft hills, patches of dry yellow grass on the left fading to lush green on the right, small clusters of low-poly pine trees becoming denser toward the right edge, a few grey rocks, a small stream, a broken wooden windmill. Path colour: yellow-green.

### 6 · Mountain Pass (between ★Forest and Cliffs)
> A narrow pass climbing through grey-green low-poly mountains. Tall rocky peaks with snowy tips along the top edge, steep grey cliffs along the bottom, sparse pine trees on the left thinning out to the right, a rope bridge over a gap, a fallen rock slide near the path. Path colour: pale green fading to pale grey-blue.

### 7 · Cliffs (between Mountain Pass and ★Silent Waters)
> Tall coastal sea cliffs seen from above: grey-brown rock plateaus on the left dropping into deep blue ocean on the right. White foam where waves hit the rocks, a lighthouse on a cliff edge, a few sea stacks in the water, gulls optional. Path runs along the cliff top then down to the shore. Path colour: pale grey fading to light blue.

### 9 · Ocean Outpost (between ★Silent Waters and Snowy Cliffs)
> Deep dark-blue open ocean with a hostile offshore platform outpost: low-poly steel oil-rig platforms on stilts, connecting walkways, cranes, a helipad, small red warning lights. Floating ice floes begin to appear toward the right edge. The path is a glowing sea route across the water. Path colour: bright blue fading to icy white-blue.

### 10 · Snowy Cliffs (between Ocean Outpost and ★Snow)
> Icy shoreline: dark blue water with ice floes on the left rising into tall white-and-pale-blue snow-covered cliffs on the right, faceted ice crystals, frozen waterfalls, snow drifts. Path colour: icy blue fading to light grey.

### 12 · Geyser Fields (between ★Snow and ★Lava)
> Snowfield being broken open by volcanic heat: white snow on the left, melting into dark grey rock on the right, steaming geysers, glowing orange-red lava cracks spreading through the ice, pools of meltwater, a few dark volcanic vents. Path colour: light grey fading to red.

### 14 · Lava Outpost (between ★Lava and ★Wasteland)
> Dark volcanic rock with rivers of glowing lava and cracked magma ground. A hostile industrial outpost built over the lava: heat-shielded bunkers, pipes, smelting furnaces, chimneys with orange glow, a bridge over a lava river. Toward the right edge the lava cools into dark grey ash ground with faint purple tint. Path colour: red fading to dark grey.

### 16 · Barren Wasteland (between ★Wasteland and Fortress Gates)
> Nearly empty dark grey-purple wasteland: flat cracked ash ground, a few small abandoned ruined buildings, a rusted wrecked vehicle, shallow craters, dead leafless trees, faint toxic green glow in a few cracks. Mostly empty open space, quiet and bleak. Path colour: dark grey.

### 17 · Fortress Gates (between Barren Wasteland and Perimeter)
> The outer gates of an evil overlord's fortress: a massive dark metal wall with a huge closed gate in the right half, gun turrets and watchtowers on the wall, red warning lights, spiked barricades, trenches and destroyed tanks in front. Ground is dark grey with red glow. The path leads up to and through the gate. Path colour: dark grey with a red glow.

### 18 · Perimeter (between Fortress Gates and ★Overlord's Den)
> Inside the fortress walls: dark industrial grounds, metal floor plates, pipes, generators, laser fences, turret emplacements, red searchlights, glowing red cracks. Toward the right edge the ground breaks into a glowing red-orange chasm with rising heat, matching the Overlord's Den. Path colour: dark grey with a red glow, becoming red on the right.

---

## New workflow (2026-09-28): generate assets → vectorize → compose in Illustrator
Full-panel generation didn't match the originals' scale, palette or seams. Instead:
1. Generate **single isolated assets** (one object per image, plain white background).
2. Vectorize in Illustrator (Image Trace → Low Fidelity Photo / 16–30 colours, then Expand) or vectorizer.ai.
3. The user composes each zone on an 800×480 artboard, with the neighbouring zones' edges as guides.

### Asset style block
> A single isolated game asset for a top-down mobile mech game world map, flat low-poly vector style: clean faceted shapes, lit top faces, darker side faces, no outlines, no texture, no gradients inside faces, soft simple drop shadow to the bottom-right. Seen from high above at a slight angle (about 60° top-down). Centred on a plain pure white background, nothing else in the image, no text.

### Canyons asset list (zone 2)
- tall layered sandstone mesa, red-orange, horizontal strata (make 3 variations: wide, tall, small)
- cluster of thin sandstone spires (2 variations)
- natural rock arch
- small boulders, set of 5 on one sheet, spaced apart
- canyon cliff edge / ravine wall segment, long horizontal strip
- cracked dry earth patch

---

## Road fix (zones 11–19) with Gemini
Attach `work/zones/zoneNN.png (or work/road/zoneNN.png for 11–19)`, fill in the two hex codes from the chain, then Claude runs `tools/road_transplant.py N <result>` (keeps only the new road, original pixels everywhere else, seams exact).

> Edit this image. Change ONLY the road. Keep every other pixel exactly the same: same colours, brightness, lighting, objects and composition. Do not recolour, sharpen or restyle anything else. Keep the exact image size.
> Repaint the road as a soft, matte, packed-dust path: one flat colour with only very subtle dusty texture, soft slightly uneven edges blending into the ground, no asphalt, no lane lines, no edge lines, no shine. Same position, same shape, same width as the current road.
> Road colour: at the left edge exactly **<START>**, gradually changing to exactly **<END>** at the right edge.

| Zone | Start | End |
|---|---|---|
| 11 Snow | #D8E5F5 | #9A9FA8 |
| 12 Geyser Fields | #9A9FA8 | #7A6F70 |
| 13 Lava | #7A6F70 | #7C6A66 |
| 14 Lava Outpost | #7C6A66 | #6E6275 |
| 15 Wasteland | #6E6275 | #6A6570 |
| 16 Barren Wasteland | #6A6570 | #6A5A60 |
| 17 Fortress Gates | #6A5A60 | #6B4E50 |
| 18 Perimeter | #6B4E50 | #7A4640 |
| 19 Overlord's Den | #7A4640 | #8A4A3C (ends at the tower) |
