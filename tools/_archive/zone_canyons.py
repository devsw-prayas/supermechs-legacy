# Procedural low-poly zone panel: Canyons (zone 2). 800x480, road enters/exits at y~178.
import math, random
from PIL import Image, ImageDraw, ImageFilter
random.seed(7)
W,H,S=800,480,2  # draw at 2x, downsample
def c(t,k): return tuple(max(0,min(255,int(v*k))) for v in t)
img=Image.new("RGB",(W*S,H*S)); d=ImageDraw.Draw(img)
# ground: faceted triangles, warm red-orange with gentle variation
base=(206,112,70); g=48
for gy in range(-1,H//g+2):
    for gx in range(-1,W//g+2):
        pts=[]
        for dy in (0,1):
            for dx in (0,1):
                random.seed(hash((gx+dx,gy+dy))&0xffffffff)
                pts.append(((gx+dx)*g+random.uniform(-14,14),(gy+dy)*g+random.uniform(-14,14)))
        random.seed(gx*991+gy)
        for tri in ((pts[0],pts[1],pts[2]),(pts[1],pts[3],pts[2])):
            k=random.uniform(0.95,1.04)
            d.polygon([(x*S,y*S) for x,y in tri],fill=c(base,k))
# dry riverbed cracks
for _ in range(14):
    x,y=random.uniform(0,W),random.uniform(250,470); pts=[(x,y)]
    for _ in range(5): x+=random.uniform(10,30); y+=random.uniform(-10,10); pts.append((x,y))
    d.line([(a*S,b*S) for a,b in pts],fill=c(base,0.8),width=2*S)
def mesa(x,y,w,h,layers,col):
    # stacked low-poly plateau: top face lit, front face shaded, side darker
    for i in range(layers):
        lw=w*(1-0.14*i); lx=x+(w-lw)/2+random.uniform(-6,6); ly=y-h*i
        top=[(lx,ly),(lx+lw*0.2,ly-14),(lx+lw*0.75,ly-17),(lx+lw,ly-4),(lx+lw*0.85,ly+8),(lx+lw*0.15,ly+9)]
        front=[(lx+lw*0.15,ly+9),(lx+lw*0.85,ly+8),(lx+lw*0.85,ly+8+h),(lx+lw*0.15,ly+9+h)]
        side=[(lx+lw*0.85,ly+8),(lx+lw,ly-4),(lx+lw,ly-4+h),(lx+lw*0.85,ly+8+h)]
        lft=[(lx,ly),(lx+lw*0.15,ly+9),(lx+lw*0.15,ly+9+h),(lx,ly+h)]
        # shadow
        d.polygon([((a+18)*S,(b+h*0.5+6)*S) for a,b in front],fill=c(base,0.72))
        for poly,k in ((lft,0.78),(front,0.9),(side,0.62),(top,1.18)):
            d.polygon([(a*S,b*S) for a,b in poly],fill=c(col,k))
        for sx in range(1,4):  # strata lines
            yy=ly+9+h*sx/4
            d.line([((lx+lw*0.15)*S,yy*S),((lx+lw*0.85)*S,(yy-1)*S)],fill=c(col,0.75),width=S)
mesas=[(20,60,150,34,3,(190,95,60)),(230,20,120,28,2,(176,88,58)),(560,40,190,30,3,(196,102,62)),
(380,395,170,38,2,(182,92,60)),(0,380,140,40,3,(170,84,54)),(640,360,160,36,3,(188,96,60)),(470,150,60,22,1,(200,108,66))]
# road path (behind foreground mesas)
pts=[]
for i in range(0,W+1,3):
    t=i/W; y=178+60*math.sin(t*math.pi*2.2+0.2)*math.sin(t*math.pi)**0.8
    pts.append((i,y))
for m in mesas[:3]+[mesas[6]]: mesa(*m)
glow=Image.new("L",img.size); gd=ImageDraw.Draw(glow)
gd.line([(a*S,b*S) for a,b in pts],fill=255,width=46*S,joint="curve")
glow=glow.filter(ImageFilter.GaussianBlur(10*S))
img=Image.composite(Image.new("RGB",img.size,(250,180,110)),img,glow.point(lambda v:int(v*0.45)))
d=ImageDraw.Draw(img)
road=Image.new("L",img.size); rd=ImageDraw.Draw(road)
rd.line([(a*S,b*S) for a,b in pts],fill=255,width=32*S,joint="curve")
for a,b in pts[::4]: rd.ellipse([(a-16)*S,(b-16)*S,(a+16)*S,(b+16)*S],fill=255)
road=road.filter(ImageFilter.GaussianBlur(1.5*S))
img=Image.composite(Image.new("RGB",img.size,(244,160,78)),img,road)
d=ImageDraw.Draw(img)
for m in mesas[3:6]: mesa(*m)
# scattered boulders
for _ in range(22):
    x,y=random.uniform(20,780),random.uniform(90,460)
    if abs(y-178)<60: continue
    r=random.uniform(5,11)
    d.polygon([((x-r)*S,y*S),((x-r*0.3)*S,(y-r)*S),((x+r)*S,(y-r*0.4)*S),((x+r*0.8)*S,(y+r*0.4)*S),(x*S,(y+r*0.5)*S)],fill=c((180,92,58),1.0))
    d.polygon([((x-r*0.3)*S,(y-r)*S),((x+r)*S,(y-r*0.4)*S),(x*S,(y-r*0.2)*S)],fill=c((180,92,58),1.2))
# vignette like originals
v=Image.new("L",img.size,0); vd=ImageDraw.Draw(v)
vd.rectangle([0,0,img.size[0],img.size[1]],fill=0); vd.ellipse([-200*S,-150*S,1000*S,630*S],fill=255)
v=v.filter(ImageFilter.GaussianBlur(80*S))
img=Image.composite(img,Image.eval(img,lambda p:int(p*0.8)),v)
out=img.resize((W,H),Image.LANCZOS)
out.save("Plans/Zones/backgrounds/new-zone02-canyons.png")
p1=Image.open("Plans/Zones/backgrounds/reloaded-worldMapPart1.png").convert("RGB")
s=Image.new("RGB",(1600,480)); s.paste(p1,(0,0)); s.paste(out,(800,0)); s.save("Plans/Zones/backgrounds/_canyons-preview.png")
