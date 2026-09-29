# Throwaway map viewer server.  python tools/map_viewer/server.py  -> http://localhost:8765
# Serves the viewer page, the zone images, and saves nodes to Plans/Zones/nodes.json.
import json, os, http.server, socketserver
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
ZONES = os.path.join(ROOT, "Plans", "Zones")
NODES = os.path.join(ZONES, "nodes.json")
PORT = 8765

class H(http.server.SimpleHTTPRequestHandler):
    def translate_path(self, path):
        path = path.split("?")[0]
        if path in ("/", "/index.html"):
            return os.path.join(os.path.dirname(__file__), "index.html")
        if path.startswith("/zones/"):          # /zones/<map folder>/zone01.png
            return os.path.join(ZONES, *path[len("/zones/"):].split("/"))
        return os.path.join(os.path.dirname(__file__), path.lstrip("/"))

    def do_GET(self):
        if self.path.startswith("/api/nodes"):
            data = open(NODES, encoding="utf-8").read() if os.path.exists(NODES) else "[]"
            return self._send(200, data)
        if self.path.startswith("/api/maps"):
            maps = {}
            for key, folder in (("1v1", "map"), ("2v2", "map-2v2"), ("3v3", "map-3v3")):
                d = os.path.join(ZONES, folder, "zones-960")
                if os.path.isdir(d):
                    maps[key] = {"folder": folder, "zones": sorted(f for f in os.listdir(d) if f.startswith("zone") and f.endswith(".png"))}
            return self._send(200, json.dumps(maps))
        return super().do_GET()

    def do_POST(self):
        if self.path.startswith("/api/nodes"):
            body = self.rfile.read(int(self.headers.get("Content-Length", 0)))
            nodes = json.loads(body)
            tmp = NODES + ".tmp"
            with open(tmp, "w", encoding="utf-8") as f:
                json.dump(nodes, f, indent=1)
            os.replace(tmp, NODES)
            return self._send(200, json.dumps({"saved": len(nodes)}))
        self._send(404, "{}")

    def _send(self, code, text):
        b = text.encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(b)))
        self.end_headers()
        self.wfile.write(b)

    def log_message(self, *a):
        pass

socketserver.TCPServer.allow_reuse_address = True
with socketserver.ThreadingTCPServer(("127.0.0.1", PORT), H) as s:
    print(f"Map viewer on http://localhost:{PORT}")
    s.serve_forever()
