# Add a generated variant zone: crop to 5:3 (centre), 2500x1500, keep raw copy, then re-blend.
#   python tools/add_variant_zone.py 2v2 7 <img>
import sys, os, shutil, subprocess
from PIL import Image
ver,n,src=sys.argv[1],int(sys.argv[2]),sys.argv[3]
R=f"Plans/Zones/work/{ver}-raw"; O=f"Plans/Zones/work/{ver}/zones"; os.makedirs(R,exist_ok=True); os.makedirs(O,exist_ok=True)
shutil.copy(src,f"{R}/zone{n:02d}{os.path.splitext(src)[1]}")
im=Image.open(src).convert("RGB"); w,h=im.size
if "--keep" in sys.argv: im=im.resize((round(w*1500/h),1500),Image.LANCZOS)   # keep its own shape (e.g. the narrow zone 16)
else:
    th=round(w*3/5)
    if th<h: t=(h-th)//2; im=im.crop((0,t,w,t+th))
    else: tw=round(h*5/3); l=(w-tw)//2; im=im.crop((l,0,l+tw,h))
    im=im.resize((2500,1500),Image.LANCZOS)
im.save(f"{O}/zone{n:02d}.png")
env=dict(os.environ,VER=ver)
for hgt in ("960","1500"): subprocess.run([sys.executable,"tools/seam_blend.py"],env=dict(env,ZONE_H=hgt),check=True)
print(ver,"zone",n,"added")
