# Measure the road's vertical centre at the left/right edge of each zone (1500-tall zones).
#   VER=2v2 python tools/road_edges.py
import os, glob, numpy as np
from PIL import Image
V=os.environ.get("VER",""); D="Plans/Zones/work"+("/"+V if V else "")+"/zones"
def road_y(a):
    s=a.astype(float).mean(1); L=s.mean(1); sat=s.max(1)-s.min(1)
    k=9; Ls=np.convolve(L,np.ones(k)/k,"same"); rough=np.convolve(np.abs(np.diff(L,prepend=L[0])),np.ones(k)/k,"same")
    ok=(rough<4)&(sat<70)&(Ls>np.percentile(Ls,55))
    H=len(L); runs=[]; y=0
    while y<H:
        if ok[y]:
            y0=y
            while y<H and ok[y]: y+=1
            if 40<=y-y0<=160 and .15*H<(y0+y)/2<.85*H: runs.append((y-y0,(y0+y)/2,Ls[y0:y].mean()))
        else: y+=1
    if not runs: return None
    return max(runs,key=lambda r:r[0]*r[2])[1]
out={}
for f in sorted(glob.glob(D+"/zone*.png")):
    a=np.asarray(Image.open(f).convert("RGB")); n=int(os.path.basename(f)[4:6])
    out[n]=(road_y(a[:,:6]),road_y(a[:,-6:])); print(f"zone{n:02d} left {out[n][0]} right {out[n][1]}")
ns=sorted(out)
for a,b in zip(ns,ns[1:]):
    if out[a][1] and out[b][0]: print(f"seam {a}->{b}: {out[b][0]-out[a][1]:+.0f}")
