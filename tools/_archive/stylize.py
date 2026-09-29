# Clean-up pass: Kuwahara filter (flattens texture/noise inside faces, keeps edges) + light sharpen.
#   python tools/stylize.py R N [N ...]   (R = radius, e.g. 3) ; reads final/blended/, writes final/styled/
import sys, os, numpy as np
from PIL import Image, ImageFilter
D="Plans/Zones/map"; C="Plans/Zones/work/checks"; os.makedirs("Plans/Zones/archive/styled",exist_ok=True)
def box(x,r):
    k=2*r+1; p=np.pad(x,((r,r),(r,r))+((0,0),)*(x.ndim-2),mode="edge")
    c=p.cumsum(0).cumsum(1); c=np.pad(c,((1,0),(1,0))+((0,0),)*(x.ndim-2))
    return (c[k:,k:]-c[:-k,k:]-c[k:,:-k]+c[:-k,:-k])/(k*k)
def kuwahara(a,r):
    L=a.mean(2); m=box(a,r); m2=box(L*L,r); mL=box(L,r); var=m2-mL**2
    H,W=L.shape; best=None
    for dy in (-r,r):
        for dx in (-r,r):
            v=np.roll(var,(dy,dx),(0,1)); mm=np.roll(m,(dy,dx),(0,1))
            if best is None: bv,bm=v,mm; best=1
            else: s=v<bv; bv=np.where(s,v,bv); bm=np.where(s[...,None],mm,bm)
    return bm
R=int(sys.argv[1])
for n in map(int,sys.argv[2:]):
    im=Image.open(f"{D}/zones-960/zone{n:02d}.png").convert("RGB"); a=np.asarray(im).astype(float)
    o=Image.fromarray(kuwahara(a,R).clip(0,255).astype(np.uint8)).filter(ImageFilter.UnsharpMask(radius=1.5,percent=60,threshold=2))
    o.save(f"Plans/Zones/archive/styled/zone{n:02d}.png")
    W,H=im.size; box_=(int(W*.3),int(H*.25),int(W*.3)+500,int(H*.25)+400)
    c=Image.new("RGB",(1000,400)); c.paste(im.crop(box_),(0,0)); c.paste(o.crop(box_),(500,0)); c.save(f"{C}/_style-check-{n:02d}.jpg",quality=90)
