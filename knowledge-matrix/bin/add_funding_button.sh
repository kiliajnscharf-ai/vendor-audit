#!/usr/bin/env bash
set -euo pipefail

HTML_FILE="docs/index.html"

if [ ! -f "${HTML_FILE}" ]; then
    echo "[FEHLER] ${HTML_FILE} nicht gefunden. Bitte zuerst generate_site.sh ausfuehren."
    exit 1
fi

echo "[INFO] Erweitere oeffentliche Web-Praesenz um Foerder-Schnittstelle..."

# Einbinden eines strukturierten Foerder-Hinweises vor dem Footer
sed -i '/<hr>/i \
    <div class="card" style="border-left: 5px solid #003366; background: #eef3f8;">\
        <h3>Projekt-Unterstuetzung & Foerderung</h3>\
        <p>Dieses System wird kontinuierlich weiterentwickelt. Foerderbeitraege und Sponsoring unterstuetzen die dauerhafte Pflege freier Wissensmodule und technischer Audits.</p>\
        <p><strong>Status:</strong> Freie Spenden und Foerder-Abos willkommen.</p>\
    </div>' "${HTML_FILE}"

echo "[ERFOLG] Foerder-Bereich erfolgreich in ${HTML_FILE} integriert."
