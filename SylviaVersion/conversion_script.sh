#!/usr/bin/env bash
set -euo pipefail

INPUT_LIST="to_convert.txt"
OUT_DIR="targets"
INC_DIR="hackatdac21"

while read -r svfile; do
  # ensure file exists
  if [[ ! -f "$svfile" ]]; then
    echo "Warning: '$svfile' not found, skipping." >&2
    continue
  fi

  # derive output path
  base=$(basename "$svfile" .sv)
  outfile="$OUT_DIR/${base}.v"

  # run sv2v
  sv2v --incdir="$INC_DIR" --write="$outfile" "$svfile"
  echo "Converted '$svfile' → '$outfile'"
done < "$INPUT_LIST"