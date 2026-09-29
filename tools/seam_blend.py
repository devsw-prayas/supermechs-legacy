# Colour-match zone seams: for each seam, shift both panels toward the average edge colour,
# row by row, fading out over FADE px. Input final/zoneNN.png -> final/blended/zoneNN.png
import glob, os, numpy as np
from PIL import Image, ImageFilter
V=os.environ.get("VER",""); D="Plans/Zones/work"+("/"+V if V else ""); M="Plans/Zones/map"+("-"+V if V else ""); OUT=M+"/zones-"+os.environ.get("ZONE_H","960"); os.makedirs(OUT,exist_ok=True)
W,H=1600,int(os.environ.get("ZONE_H","960")); STRIP=24; FADE=420
files=sorted(glob.glob(D+"/zones/zone[0-9][0-9].png"))
src=[D+"/road/"+os.path.basename(f) if os.path.exists(D+"/road/"+os.path.basename(f)) else f for f in files]  # prefer road-fixed version
ims=[np.asarray((lambda im: im.resize((round(im.width*H/im.height),H),Image.LANCZOS))(Image.open(f).convert("RGB"))).astype(float) for f in src]
def edge(a,side):
    s=a[:,-STRIP:] if side=="r" else a[:,:STRIP]
    m=s.mean(1)                                   # per-row colour
    k=41; pad=np.pad(m,((k,k),(0,0)),mode="edge")  # smooth vertically
    return np.stack([np.convolve(pad[:,c],np.ones(2*k+1)/(2*k+1),"valid") for c in range(3)],1)
corr=[np.zeros(a.shape) for a in ims]
RAMP=lambda w: np.clip(1-np.arange(w)/FADE,0,1)**1.5
for i in range(len(ims)-1):
    a,b=ims[i],ims[i+1]; ea,eb=edge(a,"r"),edge(b,"l"); mid=(ea+eb)/2
    corr[i]+=(mid-ea)[:,None,:]*RAMP(a.shape[1])[::-1][None,:,None]
    corr[i+1]+=(mid-eb)[:,None,:]*RAMP(b.shape[1])[None,:,None]
outs=[]
for f,a,c in zip(files,ims,corr):
    o=Image.fromarray((a+c).clip(0,255).astype(np.uint8)); dst=OUT+"/"+os.path.basename(f); tmp=dst+".tmp.png"; o.save(tmp)
    import time
    for _ in range(10):
        try: os.replace(tmp,dst); break
        except OSError: time.sleep(0.5)
    else: print("LOCKED, could not update",dst)
    outs.append(o)
h=480; rs=[o.resize((round(o.width*h/o.height),h)) for o in outs]
strip=Image.new("RGB",(sum(r.width for r in rs),h)); x=0
for r in rs: strip.paste(r,(x,0)); x+=r.width
tmp=M+"/_route-blended.tmp.png"; strip.save(tmp)
try: os.replace(tmp,M+"/_route-blended.png")
except OSError: os.replace(tmp,M+"/_route-blended-new.png"); print("preview locked, wrote _route-blended-new.png"); print(len(outs),"zones")

sm=strip.resize((strip.width*300//strip.height,300),Image.LANCZOS); sm.save(M+"/_route-preview.jpg",quality=85)
