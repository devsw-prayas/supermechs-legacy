# Layout guide images for Gemini: exact road, ground colour blocks, scenery masses, landmark circles.
# Every zone: 1600x960 (5:3 = 800x480 x2). Road enters and exits at ROAD_Y so all seams line up.
import math
from PIL import Image, ImageDraw, ImageFilter
W,H=1600,960; ROAD_Y=0.42; ROAD_W=64
ROAD=(250,225,170); MASS=(60,40,40); MARK=(255,0,255)
ZONES={
 1:dict(name="desert", left=(222,140,80), right=(214,120,72), amp=0.20, waves=1.5,
        masses=[(0,0,1600,120),(0,800,1600,960),(1100,650,1600,960)], marks=[(250,300,70)]),
 2:dict(name="canyons", left=(214,120,72), right=(170,95,65), amp=0.18, waves=2.0,
        masses=[(0,0,1600,200),(0,740,1600,960)], marks=[(520,520,55)]),
}
def road_pts(z):
    pts=[]
    for x in range(0,W+1,4):
        t=x/W
        y=H*ROAD_Y+H*z["amp"]*math.sin(t*math.pi*2*z["waves"]/2*2)*math.sin(t*math.pi)
        pts.append((x,y))
    return pts
def guide(n):
    z=ZONES[n]; im=Image.new("RGB",(W,H)); d=ImageDraw.Draw(im)
    for x in range(W):
        t=x/(W-1); col=tuple(int(a+(b-a)*t) for a,b in zip(z["left"],z["right"]))
        d.line([(x,0),(x,H)],fill=col)
    for m in z["masses"]: d.rectangle(m,fill=MASS)
    d.line(road_pts(z),fill=ROAD,width=ROAD_W,joint="curve")
    for a,b in road_pts(z)[::3]: d.ellipse([a-ROAD_W/2,b-ROAD_W/2,a+ROAD_W/2,b+ROAD_W/2],fill=ROAD)
    for x,y,r in z["marks"]: d.ellipse([x-r,y-r,x+r,y+r],outline=MARK,width=8)
    im.save(f"Plans/Zones/guides/guide-zone{n:02d}-{z['name']}.png")
import os; os.makedirs("Plans/Zones/guides",exist_ok=True)
for n in ZONES: guide(n)
a=Image.open("Plans/Zones/guides/guide-zone01-desert.png"); b=Image.open("Plans/Zones/guides/guide-zone02-canyons.png")
s=Image.new("RGB",(3200,960)); s.paste(a,(0,0)); s.paste(b,(1600,0)); s.resize((1600,480)).save("Plans/Zones/guides/_seam-check-01-02.png")
