#!/usr/bin/env bash
set -euo pipefail

INPUT_FILE="${1:-}"

if [ -z "${INPUT_FILE}" ] || [ ! -f "${INPUT_FILE}" ]; then
    echo "[FEHLER] Keine gueltige Eingabedatei angegeben."
    exit 1
fi

echo "[INGEST] Validiere KI-Datensatz: ${INPUT_FILE}..."
# Pruefung von JSON-Syntax und Pflichtfeldern
if jq -e '.contributor_ai and .language and .domain and .statement' "${INPUT_FILE}" >/dev/null; then
    LANG=$(jq -r '.language' "${INPUT_FILE}")
    echo "[VALIDIERT] Datensatz fuer Sprache '${LANG}' entspricht Standard Platz 1."
else
    echo "[ABGELEHNT] Datensatz unvollstaendig oder Syntax fehlerhaft."
    exit 1
fi
