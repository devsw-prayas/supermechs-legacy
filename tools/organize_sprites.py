"""Flatten JPEXS sprite exports into extracted/sprites/<era>/<fmt>/<symbol>.<ext>.

Only named symbols (those with a class name) are kept. Multi-frame sprites
(animations) go to a <symbol>/ folder with one file per frame.
"""
import os, re, shutil, sys, json

raw, out = sys.argv[1], sys.argv[2]
report = {}
for era in os.listdir(raw):
    for fmt in os.listdir(os.path.join(raw, era)):
        dest = os.path.join(out, era, fmt)
        os.makedirs(dest, exist_ok=True)
        single = multi = 0
        for lib in sorted(os.listdir(os.path.join(raw, era, fmt))):
            libdir = os.path.join(raw, era, fmt, lib)
            for d in os.listdir(libdir):
                m = re.match(r"DefineSprite_\d+_(.+)$", d)
                if not m:
                    continue
                name = m.group(1).split(".")[-1]
                if name.startswith("mcClientVersion") or "_fla" in m.group(1):
                    continue
                frames = sorted(os.listdir(os.path.join(libdir, d)), key=lambda f: int(re.sub(r"\D", "", f) or 0))
                if len(frames) == 1:
                    shutil.copy2(os.path.join(libdir, d, frames[0]), os.path.join(dest, name + os.path.splitext(frames[0])[1]))
                    single += 1
                else:
                    fd = os.path.join(dest, name)
                    os.makedirs(fd, exist_ok=True)
                    for f in frames:
                        shutil.copy2(os.path.join(libdir, d, f), os.path.join(fd, f))
                    multi += 1
        report[f"{era}/{fmt}"] = {"single": single, "animated": multi}
print(json.dumps(report, indent=2))
