#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE="https://public.websites.umich.edu/~yqnl"
mkdir -p "$ROOT/files" "$ROOT/archive/umich-original"

echo "Downloading binary assets from the current UM site..."
curl -fL "$BASE/files/photo.jpg" -o "$ROOT/files/photo.jpg"
curl -fL "$BASE/files/cv2.pdf" -o "$ROOT/archive/umich-original/cv2.pdf"

echo "Archiving the current UM HTML pages..."
curl -fL "$BASE/" -o "$ROOT/archive/umich-original/index.html"
for p in research teaching talks events; do
  curl -fL "$BASE/$p.html" -o "$ROOT/archive/umich-original/$p.html"
done

# Make the migrated homepage independent of the UM server after the assets are present.
python3 - "$ROOT" <<'PY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
p = root / "index.html"
s = p.read_text(encoding="utf-8")
s = s.replace("https://public.websites.umich.edu/~yqnl/files/photo.jpg", "files/photo.jpg")
p.write_text(s, encoding="utf-8")
PY

echo
echo "Done. The migrated site now uses a local copy of photo.jpg. The updated CV already bundled as files/cv.pdf is preserved."
echo "Original UM HTML has also been saved in archive/umich-original/."
