"""Assemble mechs for the UI mocks exactly the way the game does.

Rules taken from the decompiled client
(extracted/reloaded-7.628.4-scripts/bmmClientCC/.../mobiles/BMMechView.as, buildItem + constructor):
  * the torso is placed so its mcCenter sits at the mech origin
  * every other part's holder sits at  torsoAnchor - torso.mcCenter  (mcLeg1/2, mcSide1-4, mcTop1/2)
    and the part's art is offset so ITS OWN mcTorso lands on that holder origin
  * back-to-front draw order in itemsHolder:
      SIDE_2, SIDE_4, TOP_2, (harpoon), LEG_2, DRONE, TORSO, TOP_1, LEG_1, SIDE_1, SIDE_3
    so the far leg and far weapons sit behind the torso, the near ones in front.
Anchors are 1x, sprite PNGs are 2x, hence S = 2.

Run from the repo root:  python ui/mocks/build_mechs.py
Writes ui/mocks/assets/mech.js and copies the used sprites to ui/mocks/assets/mechs/.
"""
import glob, json, os, shutil, struct

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MOCKS = os.path.join(ROOT, "ui", "mocks")
S = 2
ORDER = ["side2", "side4", "top2", "leg2", "torso", "top1", "leg1", "side1", "side3"]

items = {i["id"]: i for i in json.load(open(os.path.join(ROOT, "data", "items_selected.json")))["items"]}


def sprite_path(name):
    hits = glob.glob(os.path.join(ROOT, "Plans", "**", name + ".png"), recursive=True)
    hits = [h for h in hits if "_archive" not in h]
    if not hits:
        raise SystemExit("missing sprite " + name)
    return hits[0]


def png_size(p):
    with open(p, "rb") as f:
        f.read(16)
        return struct.unpack(">II", f.read(8))


def base_id(name):
    """torso52_phys -> torso52 ; sideRifle1E -> sideRifle1E"""
    for suffix in ("_phys", "_heat", "_elec"):
        if name.endswith(suffix):
            return name[: -len(suffix)]
    return name


def anchors(name):
    a = items[base_id(name)].get("anchors")
    if not a:
        raise SystemExit("no anchors for " + name)
    return a


def assemble(loadout):
    """loadout: dict slot -> sprite name. Returns {w,h,parts}."""
    torso = loadout["torso"]
    ta = anchors(torso)
    cx, cy = ta["mcCenter"]
    placed = []  # (slot, sprite, x, y) in 2x px, origin = mech origin (torso mcCenter)
    for slot in ORDER:
        name = loadout.get(slot)
        if not name:
            continue
        w, h = png_size(sprite_path(name))
        if slot == "torso":
            x, y = -cx * S, -cy * S
        else:
            key = {"leg1": "mcLeg1", "leg2": "mcLeg2", "top1": "mcTop1", "top2": "mcTop2",
                   "side1": "mcSide1", "side2": "mcSide2", "side3": "mcSide3", "side4": "mcSide4"}[slot]
            if key not in ta:
                raise SystemExit("%s has no %s" % (torso, key))
            pa = anchors(name)["mcTorso"]
            x = (ta[key][0] - cx) * S - pa[0] * S
            y = (ta[key][1] - cy) * S - pa[1] * S
        placed.append((slot, name, x, y, w, h))
    x0 = min(p[2] for p in placed)
    y0 = min(p[3] for p in placed)
    x1 = max(p[2] + p[4] for p in placed)
    y1 = max(p[3] + p[5] for p in placed)
    parts = []
    for z, (slot, name, x, y, w, h) in enumerate(placed, 1):
        dst = "assets/mechs/%s.png" % name
        os.makedirs(os.path.join(MOCKS, "assets", "mechs"), exist_ok=True)
        shutil.copy(sprite_path(name), os.path.join(MOCKS, dst))
        parts.append({"src": dst, "x": round(x - x0), "y": round(y - y0), "z": z, "slot": slot})
    return {"w": round(x1 - x0), "h": round(y1 - y0), "parts": parts}


LOADOUTS = {
    # Brutality torso (torso52) on leg73 legs, checked against the game's own workshop screenshot
    "m1": {"torso": "torso52_phys", "leg1": "leg73D_phys", "leg2": "leg73D_phys",
           "top1": "topLaser2B_phys", "top2": "topLaser2C_phys",
           "side1": "cannon3C", "side2": "sideRifle1E"},
    "m2": {"torso": "torso46_phys", "leg1": "leg67D_phys", "leg2": "leg67D_phys",
           "top1": "topLaser2C_phys", "top2": "topBeam2E_phys",
           "side1": "sideRifle1E", "side2": "sideRifle2E"},
    "m3": {"torso": "torso47_phys", "leg1": "leg77D_heat", "leg2": "leg77D_heat",
           "top1": "topLaser2B_phys", "side1": "cannon3C", "side2": "sideRifle1E"},
}

JS_TAIL = """
window.buildMech=function(el,key,heightPx){const m=window.MECHS[key];el.style.position='relative';el.style.width=m.w+'px';el.style.height=m.h+'px';
 for(const p of m.parts){const i=document.createElement('img');i.src=p.src;i.draggable=false;i.style.cssText='position:absolute;left:'+p.x+'px;top:'+p.y+'px;z-index:'+p.z+';max-width:none';el.appendChild(i);}
 if(heightPx){const s=heightPx/m.h;el.style.transformOrigin='0 0';el.style.transform='scale('+s+')';el.dataset.w=m.w*s;el.dataset.h=heightPx;el.style.marginRight=(-(m.w-m.w*s))+'px';el.style.marginBottom=(-(m.h-heightPx))+'px';}
 return el;};
window.fitStage=function(){const st=document.querySelector('.stage');function f(){const s=Math.min(innerWidth/1600,innerHeight/900);st.style.transform='scale('+s+')';st.style.left=((innerWidth-1600*s)/2)+'px';st.style.top=((innerHeight-900*s)/2)+'px';}f();addEventListener('resize',f);};
"""

if __name__ == "__main__":
    out = {k: assemble(v) for k, v in LOADOUTS.items()}
    for k, v in out.items():
        print(k, v["w"], v["h"], [p["slot"] for p in v["parts"]])
    with open(os.path.join(MOCKS, "assets", "mech.js"), "w") as f:
        f.write("// Generated by ui/mocks/build_mechs.py from the game's own sprites and anchors.\n")
        f.write("window.MECHS=%s;\n" % json.dumps(out))
        f.write(JS_TAIL)
