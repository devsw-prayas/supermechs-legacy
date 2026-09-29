# Soften a zone's colours: less saturation, gentler contrast, slightly lifted shadows, tiny blur on fine detail.
#   VER=2v2 python tools/soften.py STRENGTH N [N...]    (STRENGTH 0..1, e.g. 0.5; 0 = undo)
# Always works from a saved copy (zoneNN.presoft.png), so it can be re-run with a new strength.
import os, sys, shutil, numpy as np
from PIL import Image, ImageFilter
V=os.environ.get("VER",""); D="Plans/Zones/work"+("/"+V if V else "")+"/zones"
k=float(sys.argv[1])
for n in map(int,sys.argv[2:]):
    p=f"{D}/zone{n:02d}.png"; base=p.replace(".png",".presoft.png")
    if not os.path.exists(base): shutil.copy(p,base)
    im=Image.open(base).convert("RGB")
    a=np.asarray(im).astype(float); b=np.asarray(im.filter(ImageFilter.GaussianBlur(1.2))).astype(float)
    a=a*(1-.35*k)+b*(.35*k)                                  # take the harsh edge off fine detail
    L=a.mean(2,keepdims=True)
    a=L+(a-L)*(1-.35*k)                                      # desaturate
    m=L.mean(); a=m+(a-m)*(1-.18*k)                          # compress contrast
    a=a+(255-a)*.04*k                                        # lift shadows a touch
    Image.fromarray(a.clip(0,255).astype(np.uint8)).save(p); print("softened",n,k)
