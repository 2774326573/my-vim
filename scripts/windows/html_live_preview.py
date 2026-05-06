import argparse
import json
import mimetypes
import os
import socketserver
import sys
import threading
import time
import webbrowser
from http import HTTPStatus
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
from urllib.parse import quote, urlparse


class ThreadingHTTPServer(socketserver.ThreadingMixIn, HTTPServer):
    daemon_threads = True


class PreviewServer(ThreadingHTTPServer):
    def __init__(self, server_address, handler_class, target_file, state_file):
        self.target_file = Path(target_file).resolve()
        self.root_dir = self.target_file.parent
        self.target_name = self.target_file.name
        self.state_file = Path(state_file).resolve()
        super().__init__(server_address, handler_class)

    def build_preview_url(self):
        host, port = self.server_address[:2]
        return f"http://{host}:{port}/__myvim_preview__"

    def get_target_mtime_ns(self):
        try:
            return self.target_file.stat().st_mtime_ns
        except FileNotFoundError:
            return 0

    def write_state(self):
        self.state_file.parent.mkdir(parents=True, exist_ok=True)
        payload = {
            "pid": os.getpid(),
            "port": self.server_address[1],
            "url": self.build_preview_url(),
            "file": str(self.target_file),
            "mtime_ns": self.get_target_mtime_ns(),
        }
        self.state_file.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")


class PreviewHandler(BaseHTTPRequestHandler):
    server_version = "MyVimHtmlPreview/1.0"

    def do_GET(self):
        parsed = urlparse(self.path)
        route = parsed.path
        if route == "/__myvim_preview__":
            self.serve_preview_page()
            return
        if route == "/__myvim_mtime__":
            self.serve_mtime()
            return
        self.serve_static(route)

    def log_message(self, format_, *args):
        return

    def serve_preview_page(self):
        iframe_src = "/" + quote(self.server.target_name)
        html = f"""<!DOCTYPE html>
<html lang=\"zh-CN\">
<head>
  <meta charset=\"UTF-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
  <title>HTML 实时预览 - {self.server.target_name}</title>
  <style>
    html, body {{ height: 100%; margin: 0; background: #111827; color: #e5e7eb; font-family: Segoe UI, Microsoft YaHei UI, sans-serif; }}
    .bar {{ box-sizing: border-box; height: 40px; padding: 0 14px; display: flex; align-items: center; justify-content: space-between; background: #0f172a; border-bottom: 1px solid #1f2937; }}
    .title {{ font-size: 13px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }}
    .status {{ font-size: 12px; color: #93c5fd; }}
    iframe {{ width: 100%; height: calc(100% - 40px); border: 0; background: white; }}
  </style>
</head>
<body>
  <div class=\"bar\">
    <div class=\"title\">{self.server.target_file}</div>
    <div class=\"status\" id=\"status\">等待变更</div>
  </div>
  <iframe id=\"preview-frame\" src=\"{iframe_src}\"></iframe>
  <script>
    const frame = document.getElementById('preview-frame');
    const status = document.getElementById('status');
    let lastMtime = 0;
    async function syncPreview() {{
      try {{
        const response = await fetch('/__myvim_mtime__', {{ cache: 'no-store' }});
        if (!response.ok) {{
          status.textContent = '预览文件不可用';
          return;
        }}
        const payload = await response.json();
        if (!lastMtime) {{
          lastMtime = payload.mtime_ns;
        }} else if (payload.mtime_ns !== lastMtime) {{
          lastMtime = payload.mtime_ns;
          const url = new URL(frame.src, window.location.origin);
          url.searchParams.set('t', String(Date.now()));
          frame.src = url.pathname + '?' + url.searchParams.toString();
          status.textContent = '已刷新 ' + new Date().toLocaleTimeString();
          return;
        }}
        status.textContent = '监听中 ' + new Date().toLocaleTimeString();
      }} catch (error) {{
        status.textContent = '连接中断，等待重试';
      }}
    }}
    syncPreview();
    setInterval(syncPreview, 800);
  </script>
</body>
</html>
"""
        data = html.encode("utf-8")
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def serve_mtime(self):
        payload = {
            "mtime_ns": self.server.get_target_mtime_ns(),
            "file": str(self.server.target_file),
        }
        data = json.dumps(payload).encode("utf-8")
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Cache-Control", "no-store")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def serve_static(self, route):
        relative = route.lstrip("/") or self.server.target_name
        file_path = (self.server.root_dir / relative).resolve()
        try:
            file_path.relative_to(self.server.root_dir)
        except ValueError:
            self.send_error(HTTPStatus.FORBIDDEN, "Forbidden")
            return
        if file_path.is_dir():
            file_path = file_path / "index.html"
        if not file_path.exists() or not file_path.is_file():
            self.send_error(HTTPStatus.NOT_FOUND, "Not Found")
            return
        content_type = mimetypes.guess_type(str(file_path))[0] or "application/octet-stream"
        try:
            data = file_path.read_bytes()
        except OSError:
            self.send_error(HTTPStatus.INTERNAL_SERVER_ERROR, "Read Failed")
            return
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-Type", content_type)
        self.send_header("Cache-Control", "no-store")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


def run_server(args):
    with PreviewServer((args.host, args.port), PreviewHandler, args.file, args.state) as server:
        server.write_state()
        if not args.no_browser:
            threading.Thread(target=lambda: webbrowser.open(server.build_preview_url()), daemon=True).start()
        try:
            server.serve_forever(poll_interval=0.5)
        finally:
            try:
                Path(args.state).unlink()
            except FileNotFoundError:
                pass


def parse_args(argv):
    parser = argparse.ArgumentParser(description="MyVim HTML live preview server")
    parser.add_argument("--file", required=True, help="HTML file to preview")
    parser.add_argument("--state", required=True, help="State json file path")
    parser.add_argument("--host", default="127.0.0.1", help="Bind host")
    parser.add_argument("--port", type=int, default=0, help="Bind port, 0 means auto")
    parser.add_argument("--no-browser", action="store_true", help="Do not open browser automatically")
    return parser.parse_args(argv)


def main(argv=None):
    args = parse_args(argv or sys.argv[1:])
    target = Path(args.file).resolve()
    if not target.exists():
        raise SystemExit(f"HTML file does not exist: {target}")
    run_server(args)


if __name__ == "__main__":
    main()