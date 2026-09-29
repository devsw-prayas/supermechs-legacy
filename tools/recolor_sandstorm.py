"""SandStorm (new physical laser): DawnBlaze (sideLaser2*) recoloured from red to physical amber.
Every red pixel (hue within ±30° of 0°, saturation > 0.2) gets hue 38°, keeping its saturation
and brightness. Output: Plans/Side Weapons/lasers/sideLaser1<look>.png
"""
import colorsys, glob, sys
from pathlib import Path
from PIL import Image

OUT = Path("Plans/Side Weapons/lasers")

def recolor(src, hue=38 / 360):
    im = Image.open(src).convert("RGBA"); px = im.load()
    for y in range(im.height):
        for x in range(im.width):
            r, g, b, a = px[x, y]
            if a == 0: continue
            h, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
            if s > .2 and (h < 30 / 360 or h > 330 / 360):
                r, g, b = colorsys.hsv_to_rgb(hue, s, v)
                px[x, y] = (round(r * 255), round(g * 255), round(b * 255), a)
    return im

if __name__ == "__main__":
    for look in (sys.argv[1:] or ["C", "D", "E"]):
        src = glob.glob(f"chosen/Side Weapons/*/sideLaser2{look}.png")[0]
        recolor(src).save(OUT / f"sideLaser1{look}.png")
    print("ok")
