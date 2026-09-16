#!/usr/bin/env bash
set -euo pipefail

echo "=== STARTE BASH MULTILINGUAL BUILD ENGINE ==="

for lang in en pl; do
    DATA="locales/${lang}/earth.json"
    OUT="docs/${lang}/index.html"
    
    TITLE=$(jq -r '.title' "${DATA}")
    SUBTITLE=$(jq -r '.subtitle' "${DATA}")
    TOTAL=$(jq '.domains | length' "${DATA}")

    cat << HTML_START > "${OUT}"
<!DOCTYPE html>
<html lang="${lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${TITLE}</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; line-height: 1.6; max-width: 800px; margin: 0 auto; padding: 20px; background: #f4f6f8; color: #111; }
        h1 { color: #003366; border-bottom: 2px solid #003366; padding-bottom: 10px; }
        .card { background: white; padding: 15px; margin: 15px 0; border-radius: 6px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .badge { display: inline-block; padding: 4px 8px; font-size: 12px; font-weight: bold; background: #003366; color: white; border-radius: 4px; }
    </style>
</head>
<body>
    <h1>${TITLE}</h1>
    <p>${SUBTITLE}</p>
    <p><small>Sprache / Language: <strong>${lang^^}</strong></small></p>
HTML_START

    for i in $(seq 0 $((TOTAL - 1))); do
        ID=$(jq -r ".domains[$i].id" "${DATA}")
        DOM=$(jq -r ".domains[$i].domain" "${DATA}")
        Q=$(jq -r ".domains[$i].question" "${DATA}")
        DIFF=$(jq -r ".domains[$i].difficulty" "${DATA}")

        cat << HTML_ITEM >> "${OUT}"
    <div class="card">
        <span class="badge">${DOM}</span> <small>${ID} [${DIFF}]</small>
        <p><strong>Frage:</strong> ${Q}</p>
    </div>
HTML_ITEM
    done

    cat << HTML_END >> "${OUT}"
    <hr>
    <footer>
        <p><small>Projekt Haus im Wind | International Verified Knowledge Matrix</small></p>
    </footer>
</body>
</html>
HTML_END

    echo "[ERFOLG] Seite generiert: ${OUT}"
done
echo "=== MULTILINGUAL BUILD ABGESCHLOSSEN ==="
