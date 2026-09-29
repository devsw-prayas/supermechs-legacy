# Apply a version's layer stack to zones through their masks.  python tools/zone_variant.py 3v3 N [N...]
# reads map/zones-1500 + work/masks/zoneNN -> work/variants/<ver>/zoneNN.png + checks/_variant-<ver>-NN.jpg
import sys, os, numpy as np
from PIL import Image, ImageFilter
SRC="Plans/Zones/map/zones-1500"; MK="Plans/Zones/work/masks"; ver=sys.argv[1]
OUT=f"Plans/Zones/work/variants/{ver}"; os.makedirs(OUT,exist_ok=True)
def soft(m,r=2): return np.asarray(Image.fromarray(m).filter(ImageFilter.GaussianBlur(r))).astype(float)[...,None]/255
def noise(h,w,seed,octaves=5):
    rng=np.random.default_rng(seed); out=np.zeros((h,w))
    for o in range(octaves):
        s=2**(o+2); r=rng.random((max(2,h//(h//s or 1)),s*w//h+2))
        out+=np.asarray(Image.fromarray((r*255).astype(np.uint8)).resize((w,h),Image.BICUBIC)).astype(float)/255/(2**o)
    return out/out.max()
def lum(a): return (a[...,0]*.3+a[...,1]*.59+a[...,2]*.11)[...,None]
for n in map(int,sys.argv[2:]):
    a=np.asarray(Image.open(f"{SRC}/zone{n:02d}.png").convert("RGB")).astype(float); H,W=a.shape[:2]
    M={k:soft(np.asarray(Image.open(f"{MK}/zone{n:02d}/{k}.png"))) for k in ["ground","rock","vegetation","snow","water","lava","glow"]}
    L=lum(a); o=a.copy()
    if ver=="3v3":
        o=o*(1-M["vegetation"])+(L*np.array([.95,.78,.70])+[10,0,0])*M["vegetation"]          # dead, withered plants
        o=o*(1-M["water"])+(L*np.array([1.25,.22,.30])+[20,0,5])*M["water"]            # blood-red water
        o=o*(1-M["snow"])+(L*np.array([.62,.55,.66]))*M["snow"]                        # ash instead of snow
        hot=M["lava"]+M["glow"]; o=o*(1-hot)+(L*np.array([1.5,.28,.42])+[40,0,20])*hot  # crimson lava
        o=o*np.array([.72,.58,.76])                                                     # night, violet grade
        # corruption veins on the ground: thin ridges of fractal noise
        nz=noise(H,W,n); vein=np.clip(1-np.abs(nz-0.5)*16,0,1)**1.5
        vein=vein[...,None]*M["ground"]
        o=o*(1-vein)+np.array([235,35,70])*vein
        glow=Image.fromarray(np.clip((vein[...,0]+hot[...,0]*0.8)*255,0,255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(14))
        o=o+np.asarray(glow).astype(float)[...,None]/255*np.array([90,10,40])            # bloom
    elif ver=="2v2":
        o=o*(1-M["vegetation"])+(o*np.array([.85,.78,.55]))*M["vegetation"]            # dry, scorched plants
        nz=noise(H,W,n+50); burn=np.clip((nz-0.62)*4,0,1)[...,None]*(M["ground"]+M["vegetation"])
        o=o*(1-burn*0.7)+np.array([35,28,25])*burn*0.7                                  # scorch patches
        o=o*np.array([1.0,.82,.68])+[12,0,0]                                            # dusk grade
    o=np.clip(o,0,255).astype(np.uint8); im=Image.fromarray(o); im.save(f"{OUT}/zone{n:02d}.png")
    src=Image.fromarray(a.astype(np.uint8)); c=Image.new("RGB",(W,H*2)); c.paste(src,(0,0)); c.paste(im,(0,H))
    c.resize((W//3,H*2//3)).save(f"Plans/Zones/work/checks/_variant-{ver}-{n:02d}.jpg",quality=88); print(ver,n)
