# Segment a zone into region masks by colour.  python tools/zone_masks.py N [N...]
# -> Plans/Zones/work/masks/zoneNN/<class>.png (white = region) + _masks-NN.jpg preview
import sys, os, numpy as np
from PIL import Image, ImageFilter
SRC="Plans/Zones/map/zones-1500"; OUT="Plans/Zones/work/masks"
CLASSES={ # preview colours
 "lava":(255,90,0),"water":(0,120,255),"snow":(235,245,255),"vegetation":(40,170,60),
 "glow":(255,0,200),"rock":(120,120,130),"ground":(150,110,70)}
def hsv(a):
    im=Image.fromarray(a.astype(np.uint8)).convert("HSV"); h=np.asarray(im).astype(float)
    return h[...,0]*360/255,h[...,1]/255,h[...,2]/255
def clean(m,k=5):
    f=lambda m,flt: np.asarray(Image.fromarray((m*255).astype(np.uint8)).filter(flt))>127
    return f(f(m,ImageFilter.MinFilter(k)),ImageFilter.MaxFilter(k))
for n in map(int,sys.argv[1:]):
    a=np.asarray(Image.open(f"{SRC}/zone{n:02d}.png").convert("RGB")).astype(float)
    H,S,V=hsv(a); d=f"{OUT}/zone{n:02d}"; os.makedirs(d,exist_ok=True)
    m={}
    m["glow"]=(S>0.55)&(V>0.75)&((H<20)|(H>335))&(a[...,0]>230)&(a[...,1]<120)        # red lights / hot glow
    m["lava"]=(S>0.6)&(V>0.7)&(H>=8)&(H<38)&(a[...,0]>215)&(a[...,1]<175)&~m["glow"]
    m["water"]=(S>0.3)&(H>175)&(H<225)&(V>0.25)
    m["snow"]=(V>0.78)&(S<0.25)&~m["water"]
    m["vegetation"]=(S>0.25)&(H>=55)&(H<170)&(V>0.15)
    taken=m["glow"]|m["lava"]|m["water"]|m["snow"]|m["vegetation"]
    m["rock"]=(S<0.22)&(V<0.78)&~taken
    m["ground"]=~(taken|m["rock"])
    for k in m: m[k]=clean(m[k])
    prev=np.zeros_like(a)
    for k in ["ground","rock","vegetation","snow","water","lava","glow"]:
        Image.fromarray((m[k]*255).astype(np.uint8)).save(f"{d}/{k}.png"); prev[m[k]]=CLASSES[k]
    src=Image.fromarray(a.astype(np.uint8)); pv=Image.fromarray(prev.astype(np.uint8))
    w,h=src.size; c=Image.new("RGB",(w,h*2)); c.paste(src,(0,0)); c.paste(Image.blend(src,pv,0.75),(0,h))
    c.resize((w//3,h*2//3)).save(f"Plans/Zones/work/checks/_masks-{n:02d}.jpg",quality=85)
    print(n,{k:f"{100*v.mean():.0f}%" for k,v in m.items()})
