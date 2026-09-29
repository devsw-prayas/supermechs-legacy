"""Recolour a top weapon's accent colour into other elements.
python tools/recolor_top.py <sprite base> <from hue lo> <from hue hi> <name:hue> ...
e.g. python tools/recolor_top.py cannon1 20 60 heat:4 elec:196
Pixels with hue in [lo, hi] and saturation > 0.25 get the new hue (saturation and brightness kept).
Reads Plans/Top Weapons/sprites/<base><look>.png, writes Plans/Top Weapons/recolors/<base><look>_<name>.png"""
import colorsys, glob, os, sys
from PIL import Image
S="Plans/Top Weapons/sprites"; O="Plans/Top Weapons/recolors"; os.makedirs(O,exist_ok=True)
base,lo,hi=sys.argv[1],float(sys.argv[2])/360,float(sys.argv[3])/360
targets=[(t.split(":")[0],float(t.split(":")[1])/360) for t in sys.argv[4:]]
for f in sorted(glob.glob(f"{S}/{base}[A-Z].png")):
    src=Image.open(f).convert("RGBA")
    for name,hue in targets:
        im=src.copy(); px=im.load()
        for y in range(im.height):
            for x in range(im.width):
                r,g,b,a=px[x,y]
                if a==0: continue
                h,s,v=colorsys.rgb_to_hsv(r/255,g/255,b/255)
                if s>.25 and lo<=h<=hi:
                    r,g,b=colorsys.hsv_to_rgb(hue,s,v); px[x,y]=(round(r*255),round(g*255),round(b*255),a)
        out=f"{O}/{os.path.basename(f)[:-4]}_{name}.png"; im.save(out); print(out)
