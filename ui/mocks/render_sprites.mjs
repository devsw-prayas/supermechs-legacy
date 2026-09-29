// Render original item SVGs (idle look) to transparent 2x PNGs, the same scale as the PNGs under Plans/.
// usage: node ui/mocks/render_sprites.mjs <outDir> <symbol> [symbol...]
// Reads extracted/sprites-chosen/reloaded/svg_idle/<symbol>.svg (falls back to svg/ then legacy).
import {spawn} from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
const [,, outDir, ...syms] = process.argv;
const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), '../..');
const CH = process.env.CHROME || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome';
const port = 9800 + Math.floor(Math.random() * 300);
const p = spawn(CH, ['--headless=new','--no-sandbox','--disable-gpu','--allow-file-access-from-files',`--remote-debugging-port=${port}`,'--hide-scrollbars','about:blank'],{stdio:'ignore'});
const sleep = ms => new Promise(r => setTimeout(r, ms));
let list; for (let i = 0; i < 50; i++) { try { list = await (await fetch(`http://127.0.0.1:${port}/json`)).json(); if (list.length) break; } catch {} await sleep(200); }
const ws = new WebSocket(list.find(t => t.type === 'page').webSocketDebuggerUrl); await new Promise(r => ws.onopen = r);
let id = 0; const pend = {}; ws.onmessage = e => { const m = JSON.parse(e.data); if (m.id && pend[m.id]) { pend[m.id](m.result); delete pend[m.id]; } };
const send = (method, params = {}) => new Promise(r => { const i = ++id; pend[i] = r; ws.send(JSON.stringify({id: i, method, params})); });
await send('Page.enable');
await send('Emulation.setDefaultBackgroundColorOverride', {color: {r: 0, g: 0, b: 0, a: 0}});
fs.mkdirSync(outDir, {recursive: true});
for (const sym of syms) {
  let f = null;
  for (const era of ['reloaded', 'legacy']) for (const d of ['svg_idle', 'svg']) {
    const c = path.join(ROOT, 'extracted/sprites-chosen', era, d, sym + '.svg'); if (!f && fs.existsSync(c)) f = c;
  }
  if (!f) { console.log('missing', sym); continue; }
  const s = fs.readFileSync(f, 'utf8');
  const w = parseFloat((s.match(/\bwidth="([\d.]+)px"/) || [])[1]), h = parseFloat((s.match(/\bheight="([\d.]+)px"/) || [])[1]);
  const W = Math.round(w * 2), H = Math.round(h * 2);
  await send('Emulation.setDeviceMetricsOverride', {width: Math.ceil(w), height: Math.ceil(h), deviceScaleFactor: 2, mobile: false});
  await send('Page.navigate', {url: 'file://' + f});
  await sleep(250);
  const r = await send('Page.captureScreenshot', {format: 'png', clip: {x: 0, y: 0, width: w, height: h, scale: 1}});
  fs.writeFileSync(path.join(outDir, sym + '.png'), Buffer.from(r.data, 'base64'));
  console.log('wrote', sym, W + 'x' + H);
}
p.kill(); process.exit(0);
