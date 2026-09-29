# Stitch all zones into one map.  python tools/build_full_map.py [height=1500]  -> Plans/Zones/map/full-map-<h>.png/.jpg + zones txt + preview
import sys, glob
from PIL import Image
Image.MAX_IMAGE_PIXELS=None
import os; h=sys.argv[1] if len(sys.argv)>1 else "1500"; V=os.environ.get("VER",""); M="Plans/Zones/map"+("-"+V if V else "")+"/"
ims=[Image.open(f).convert("RGB") for f in sorted(glob.glob(M+f"zones-{h}/zone*.png"))]
W=sum(i.width for i in ims); H=ims[0].height; m=Image.new("RGB",(W,H)); x=0; xs=[]
for i in ims: m.paste(i,(x,0)); xs.append(x); x+=i.width
m.save(M+f"full-map-{h}.png"); m.save(M+f"full-map-{h}.jpg",quality=92)
open(M+"full-map-zones.txt","w").write(f"zone\tx_start\twidth (full-map-{h})\n"+"".join(f"{n+1}\t{a}\t{i.width}\n" for n,(a,i) in enumerate(zip(xs,ims))))
p=m.resize((W*400//H,400),Image.LANCZOS); rows=4; w=-(-p.width//rows); s=Image.new("RGB",(w,400*rows),(20,20,20))
for r in range(rows): s.paste(p.crop((r*w,0,min(p.width,(r+1)*w),400)),(0,r*400))
s.resize((w//2,800)).save(M+"_full-map-preview-rows.jpg",quality=85); print(W,H,len(ims),"zones")
