# Widen the road at a zone's left edge by stretching rows around it (fades out to the right).
#   VER=2v2 python tools/road_widen.py N CENTER_Y FACTOR [FADE]   e.g. 16 345 1.4 450
import os, sys, shutil, numpy as np
from PIL import Image
V=os.environ.get("VER",""); D="Plans/Zones/work"+("/"+V if V else "")+"/zones"
n,c,f=int(sys.argv[1]),float(sys.argv[2]),float(sys.argv[3]); fade=int(sys.argv[4]) if len(sys.argv)>4 else 450; dy=float(sys.argv[5]) if len(sys.argv)>5 else 0
p=f"{D}/zone{n:02d}.png"; bak=p.replace(".png",".prewiden.png")
if not os.path.exists(bak): shutil.copy(p,bak)
a=np.asarray(Image.open(bak).convert("RGB")).astype(float); H,W=a.shape[:2]
t=np.clip(1-np.arange(W)/fade,0,1); t=t*t*(3-2*t); ys=np.arange(H); out=np.empty_like(a)
R=260  # rows within this distance of the road centre get stretched, smoothly back to 1 beyond
for x in range(W):
    k=1+(f-1)*t[x]; d=ys-c
    w=np.clip(1-np.abs(d)/R,0,1)                     # stretch strongest at the road, none far away
    src=c+d/(1+(k-1)*w)-dy*t[x]*np.clip(1-np.abs(d)/600,0,1)
    y0=np.clip(np.floor(src).astype(int),0,H-1); y1=np.minimum(y0+1,H-1); fr=(src-np.floor(src))[:,None]
    out[:,x]=a[y0,x]*(1-fr)+a[y1,x]*fr
Image.fromarray(out.clip(0,255).astype(np.uint8)).save(p); print("widened",n,f)
