"""A minimal Slack webhook stand-in for test.sh.

usage: mock_slack.py PORT_FILE BODY_FILE

Listens on a free local port and writes it to PORT_FILE. Every POST body is appended
to BODY_FILE, one per line. The path decides the answer: /ok gives 200, anything else
gives 500.
"""
import http.server
import sys


class Handler(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        with open(sys.argv[2], "ab") as out:
            out.write(self.rfile.read(length) + b"\n")
        self.send_response(200 if self.path == "/ok" else 500)
        self.end_headers()
        self.wfile.write(b"ok")

    def log_message(self, *args):
        pass


server = http.server.HTTPServer(("127.0.0.1", 0), Handler)
with open(sys.argv[1], "w") as port_file:
    port_file.write(str(server.server_address[1]))
server.serve_forever()
