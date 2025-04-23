#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="sources"                # directory holding .sv files
PREPEND_LIST="to_prepend.txt"    # ordered list of package .sv paths
OUT_DIR="targets"                # where converted .v files will go
LIB_DIR="hackatdac21"            # sv2v library search dir

#    mapfile (aka readarray) reads each line into PKG_FILES[] :contentReference[oaicite:4]{index=4}
mapfile -t PKG_FILES < "$PREPEND_LIST"

for svfile in "$SRC_DIR"/*.sv; do
  # Skip non-files
  [[ ! -f "$svfile" ]] && continue

  base=$(basename "$svfile" .sv)
  outfile="$OUT_DIR/${base}.v"

  tmp="$(mktemp --suffix=.sv)"    # mktemp creates a unique file safely :contentReference[oaicite:5]{index=5}

  for pkg in "${PKG_FILES[@]}"; do
    if [[ -f "$pkg" ]]; then
      cat "$pkg" >> "$tmp"         # concat package :contentReference[oaicite:6]{index=6}
    else
      echo "Warning: package file '$pkg' not found" >&2
    fi
  done

  cat "$svfile" >> "$tmp"         # concat source :contentReference[oaicite:7]{index=7}

  sv2v --write="$outfile" "$tmp"

  echo "Converted '$svfile' → '$outfile'"

  rm "$tmp"
done

