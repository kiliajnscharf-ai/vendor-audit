#!/usr/bin/env bash
set -euo pipefail

echo "=== PHASE 1: COMMITS FESTSCHREIBEN ==="
cd ~/projects/vendor-audit
git add .
git commit -m "feat: complete vendor audit engine and docs" || true

echo "=== PHASE 2: STATUS-PRUEFUNG ==="
echo "Aktuelle Zeit: $(date +%H:%M:%S)"
echo "Verbleibende Schritte: GitHub Login und Remote-Push"
