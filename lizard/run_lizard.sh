#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../catan/src" && pwd)"
OUTPUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT_FILE="$OUTPUT_DIR/lizard_report.html"

echo "============================================"
echo "Pokrece se Lizard analiza kompleksnosti"
echo "============================================"
echo "Koren projekta: $PROJECT_ROOT"
echo "Izvestaj ce biti sacuvan u: $REPORT_FILE"
echo ""

if ! command -v lizard &> /dev/null; then
    echo "Greska: Lizard nije instaliran."
    echo "Instaliraj ga komandom: pip install lizard"
    exit 1
fi

echo "Pokrece se Lizard analiza..."
lizard "$PROJECT_ROOT" | aha --black --title "Lizard Complexity Report" > "$REPORT_FILE"


echo ""
echo "Analiza je zavrsena."
echo "Izvestaj se nalazi u: $REPORT_FILE"
echo "Mozete ga otvoriti u browseru: $REPORT_FILE"

