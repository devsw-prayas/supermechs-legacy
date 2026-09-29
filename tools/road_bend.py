# Bend the left part of a zone vertically so its road meets the previous zone's road.
#   VER=2v2 python tools/road_bend.py N DY [FADE]   (DY>0 moves the left edge DOWN; fades to 0 over FADE px, default 700)
import os, sys, numpy as np
from PIL import Image
V=os.environ.get("VER",""); D="Plans/Zones/work"+("/"+V if V else "")+"/zones"
n,dy=int(sys.argv[1]),float(sys.argv[2]); fade=int(sys.argv[3]) if len(sys.argv)>3 else 700
p=f"{D}/zone{n:02d}.png"; bak=p.replace(".png",".orig.png")
if not os.path.exists(bak): Image.open(p).save(bak)            # always bend from the untouched original
a=np.asarray(Image.open(bak).convert("RGB")).astype(float); H,W=a.shape[:2]
t=np.clip(1-np.arange(W)/fade,0,1); t=t*t*(3-2*t)                # smooth ramp 1 -> 0
out=np.empty_like(a); ys=np.arange(H)
for x in range(W):
    src=np.clip(ys-dy*t[x],0,H-1); y0=np.floor(src).astype(int); y1=np.minimum(y0+1,H-1); f=(src-y0)[:,None]
    out[:,x]=a[y0,x]*(1-f)+a[y1,x]*f
Image.fromarray(out.clip(0,255).astype(np.uint8)).save(p); print("zone",n,"bent",dy)
