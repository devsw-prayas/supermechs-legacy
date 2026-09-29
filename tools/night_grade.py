# 3v3 = night/corrupted colour grade over the finished 2v2 zones (no regeneration).
#   python tools/night_grade.py [N ...]   (no N = all)  work/2v2/zones -> work/3v3/zones
import os, sys, glob, numpy as np
from PIL import Image, ImageFilter
S=os.environ.get("SRC","Plans/Zones/work/2v2/zones"); O=os.environ.get("DST","Plans/Zones/work/3v3/zones"); os.makedirs(O,exist_ok=True)
ns=[int(v) for v in sys.argv[1:]] or [int(os.path.basename(f)[4:6]) for f in glob.glob(S+"/zone??.png")]
for n in sorted(ns):
    im=Image.open(f"{S}/zone{n:02d}.png").convert("RGB"); a=np.asarray(im).astype(float)
    L=a.mean(2,keepdims=True); mx=a.max(2,keepdims=True); mn=a.min(2,keepdims=True)
    # fires / lava / red lights: bright + warm + saturated -> keep and boost
    loc=np.asarray(im.convert("L").filter(ImageFilter.GaussianBlur(30))).astype(float)[...,None]
    hot=np.clip(((a[...,:1]-a[...,2:3])-60)/60,0,1)*np.clip((mx-170)/50,0,1)*np.clip((L-loc-15)/35,0,1)*np.clip(((mx-mn)/(mx+1)-0.45)/0.2,0,1)
    lava=np.clip(((a[...,:1]-a[...,2:3])-100)/50,0,1)*np.clip((mx-190)/30,0,1)*np.clip(((mx-mn)/(mx+1)-0.5)/0.15,0,1)   # large lava fields (very hot orange)
    hot=np.maximum(hot,lava)
    hot=np.asarray(Image.fromarray((hot[...,0]*255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(2))).astype(float)[...,None]/255
    g=L+(a-L)*0.55                                   # desaturate
    g=g*np.array([0.52,0.33,0.38])                   # night, dark red
    g=g+np.array([14,2,6])                           # lift shadows into dark red
    fire=a*np.array([1.15,0.75,0.8])                 # fires a bit redder, full brightness
    out=g*(1-hot)+fire*hot
    bloom=np.asarray(Image.fromarray((hot[...,0]*255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(25))).astype(float)[...,None]/255
    share=float(hot.mean())                           # zones full of lights/lava get less spill, or it turns to fog
    out=out+bloom*np.array([90,15,25])*max(0.15,1-share*12)
    m=out.mean(); out=m+(out-m)*1.18                  # keep shapes readable in the dark
    Image.fromarray(out.clip(0,255).astype(np.uint8)).save(f"{O}/zone{n:02d}.png"); print("3v3",n)
