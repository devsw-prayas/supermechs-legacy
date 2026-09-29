# Use the Gemini road-edited zone as-is, but paste the original back over Gemini's watermark corner.
#   python tools/road_transplant.py N <edited image>  -> final/road/zoneNN.png (+ _road-zoom-NN.jpg)
import sys, os, numpy as np
from PIL import Image, ImageFilter
D="Plans/Zones/work"; os.makedirs(D+"/road",exist_ok=True)
n=int(sys.argv[1]); o0=Image.open(f"{D}/zones/zone{n:02d}.png").convert("RGB")
g=Image.open(sys.argv[2]).convert("RGB")
H=1500; W=round(o0.width*H/o0.height)               # fixed output: 1500 px tall, zone's own shape
g=g.resize((W,H),Image.LANCZOS); o=o0.resize((W,H),Image.LANCZOS)
A=np.asarray(o).astype(float); G=np.asarray(g).astype(float)
print("whole-image diff %.1f (under ~10 = Gemini kept the rest)"%np.abs(G-A).mean())
# watermark sits ~7.5% in from the bottom-right corner: feather the original back over a small box
m=Image.new("L",(W,H)); from PIL import ImageDraw
fx,fy=(float(sys.argv[3]),float(sys.argv[4])) if len(sys.argv)>4 else (0.925,0.945)
cx,cy,r=int(W*fx),int(H*fy),int(H*0.05); ImageDraw.Draw(m).ellipse([cx-r,cy-r,cx+r,cy+r],fill=255)
a=np.asarray(m.filter(ImageFilter.GaussianBlur(r/3)))/255.0
out=G*(1-a[...,None])+A*a[...,None]
o2=Image.fromarray(out.clip(0,255).astype(np.uint8)); o2.save(f"{D}/road/zone{n:02d}.png")
o2.resize((W//2,H//2)).save(f"{D}/checks/_road-zoom-{n:02d}.jpg",quality=88)
