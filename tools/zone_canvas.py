# Canvas trick for seamless zones.
#   python tools/zone_canvas.py canvas N        -> final/canvas/canvas-zoneNN.png (left 20% = zone N-1's right edge, rest white)
#   python tools/zone_canvas.py merge N <img>   -> final/zoneNN.png (GPT result with the overlap cut off)
import sys, os
from PIL import Image
V=os.environ.get("VER",""); D="Plans/Zones/work"+("/"+V if V else ""); ZD=D+("/"+os.environ["ZDIR"] if os.environ.get("ZDIR") else "/zones"); OV=0.20
cmd,n=sys.argv[1],int(sys.argv[2])
prev=Image.open(f"{ZD}/zone{n-1:02d}.png").convert("RGB"); w,h=prev.size
cw=round(h*5/3); s=round(cw*OV)                       # canvas is always 5:3
if cmd=="canvas":
    os.makedirs(D+"/canvas",exist_ok=True)
    c=Image.new("RGB",(cw,h),(255,255,255)); c.paste(prev.crop((w-s,0,w,h)),(0,0))
    c.save(f"{D}/canvas/canvas-zone{n:02d}.png"); print("canvas",cw,h,"overlap",s)
elif cmd=="merge":
    g=Image.open(sys.argv[3]).convert("RGB").resize((cw,h),Image.LANCZOS)
    g.save(f"{D}/canvas/raw-zone{n:02d}.png")
    # GPT sometimes moves the painted part: find where it really ended up, then cut after it
    import numpy as np
    c=np.asarray(Image.open(f"{D}/canvas/canvas-zone{n:02d}.png").convert("L")).astype(float)
    r=np.asarray(g.convert("L")).astype(float)
    ref=c[80:h-80,20:s-20]; best=(1e9,0)
    for dx in range(0,cw-s,4):
        e=np.abs(r[80:h-80,20+dx:s-20+dx]-ref).mean()
        if e<best[0]: best=(e,dx)
    err,dx=best
    print(f"painted part found at +{dx}px (err {err:.1f})" + ("  <-- GPT shifted it" if dx>8 else ""))
    out=g.crop((s+dx,0,cw,h)); tmp=f"{ZD}/zone{n:02d}.tmp.png"; out.save(tmp)
    os.replace(tmp,f"{ZD}/zone{n:02d}.png"); print("zone",n,out.size)
