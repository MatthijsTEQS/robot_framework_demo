"""Wait until a URL becomes reachable before continuing a test or CI flow."""

from __future__ import annotations

import argparse
import http.client
import socket
import sys
import time
import urllib.error
import urllib.request


TRANSIENT_NETWORK_ERRORS = (
    ConnectionResetError,
    TimeoutError,
    socket.timeout,
    http.client.BadStatusLine,
    http.client.RemoteDisconnected,
)


def parse_args() -> argparse.Namespace:
    """Parse the target URL and polling settings from the command line."""
    parser = argparse.ArgumentParser()
    parser.add_argument("url")
    parser.add_argument("--timeout", type=int, default=120)
    parser.add_argument("--interval", type=float, default=2.0)
    return parser.parse_args()


def main() -> int:
    """Poll the URL until it responds or the timeout expires."""
    args = parse_args()
    deadline = time.time() + args.timeout

    while time.time() < deadline:
        try:
            with urllib.request.urlopen(args.url) as response:
                # Treat any reachable application response as "ready enough"
                # for version-1 orchestration, even if the page returns a
                # redirect or a client-side error page.
                if 200 <= response.status < 500:
                    print(f"Ready: {args.url} ({response.status})")
                    return 0
        except (urllib.error.URLError, *TRANSIENT_NETWORK_ERRORS):
            # During container startup the TCP connection can exist before the
            # web app is fully ready, which may cause resets or incomplete
            # HTTP responses. These are retriable readiness failures.
            pass
        time.sleep(args.interval)

    print(f"Timeout waiting for {args.url}", file=sys.stderr)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
