# Warm colour grade on a variant zone (dusk).  VER=2v2 python tools/warm.py N [strength=1]
import os, sys, numpy as np
from PIL import Image
V=os.environ.get("VER",""); p=f"Plans/Zones/work/{V}/zones/zone{int(sys.argv[1]):02d}.png"; k=float(sys.argv[2]) if len(sys.argv)>2 else 1
a=np.asarray(Image.open(p).convert("RGB")).astype(float)
L=a.mean(2,keepdims=True)
warm=a*np.array([1+.10*k,1+.02*k,1-.12*k])+np.array([10,4,-6])*k*(L/255)   # push toward amber, stronger in lights
Image.fromarray(warm.clip(0,255).astype(np.uint8)).save(p); print("warmed",p,k)
