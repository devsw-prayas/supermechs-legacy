# Repaint asphalt roads as a matte, soft-edged path.
# Seeds (points on the road, full-res px) per zone in data/road_seeds.json: {"13": [[20,255],[1100,330]]}
#   python tools/road_matte.py 13 [14 ...]  -> final/road/zoneNN.png, _road-check-NN.jpg, _road-zoom-NN.jpg
import sys, os, json, numpy as np
from PIL import Image, ImageFilter, ImageDraw
D="Plans/Zones/work"; os.makedirs(D+"/road",exist_ok=True)
SEEDS=json.load(open("data/road_seeds.json"))
F=lambda m,f: np.asarray(Image.fromarray((m*255).astype(np.uint8)).filter(f))>127
for n in [int(v) for v in sys.argv[1:] if v.isdigit()]:
    im=Image.open(f"{D}/zones/zone{n:02d}.png").convert("RGB"); a=np.asarray(im).astype(float); H,W=a.shape[:2]
    road=np.zeros((H,W),bool)
    for x,y in SEEDS[str(n)]:
        t=im.copy(); ImageDraw.floodfill(t,(x,y),(255,0,255),thresh=int(SEEDS.get("thresh",{}).get(str(n),26)))
        road|=(np.asarray(t)==[255,0,255]).all(2)
    road=F(F(road,ImageFilter.MaxFilter(9)),ImageFilter.MinFilter(9))   # swallow lane/edge lines
    road=F(road,ImageFilter.MaxFilter(9))                               # include the outer edge lines
    ring=F(road,ImageFilter.MaxFilter(41))&~road
    L=a.mean(2); mx,mn=a.max(2),a.min(2); sat=(mx-mn)/(mx+1)
    ground=np.median(a[ring],0); hot=sat*mx; acc=a[hot>np.percentile(hot,95)].mean(0)
    col=np.clip((ground*1.15+20)*0.72+acc*0.28,0,255)
    rng=np.random.default_rng(n); nz=np.asarray(Image.fromarray((rng.random((H//8,W//8))*255).astype(np.uint8)).resize((W,H),Image.BICUBIC)).astype(float)
    col=col[None,None,:]  # flat matte colour
    m=Image.fromarray((road*255).astype(np.uint8))
    alpha=np.asarray(m.filter(ImageFilter.GaussianBlur(1.5)))/255.0
    out=a*(1-alpha[...,None])+col*alpha[...,None]
    glow=np.asarray(m.filter(ImageFilter.GaussianBlur(16)))/255.0
    
    o=Image.fromarray(out.clip(0,255).astype(np.uint8)); o.save(f"{D}/road/zone{n:02d}.png")
    c=Image.new("RGB",(W,H*2)); c.paste(im,(0,0)); c.paste(o,(0,H)); c.resize((W//2,H)).save(f"{D}/checks/_road-check-{n:02d}.jpg",quality=85)
    print(n,"road px",int(road.sum()))
