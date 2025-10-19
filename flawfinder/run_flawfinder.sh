#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../catan/src" && pwd)"
OUTPUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT_FILE="$OUTPUT_DIR/flawfinder_result.html"


echo "============================================"
echo "Pokrece se Flawfinder analiza projekta"
echo "============================================"
echo "Koren projekta: $PROJECT_ROOT"
echo "Rezultati ce se nalaziti u: $REPORT_FILE"
echo ""


if ! command -v flawfinder &> /dev/null; then
    echo "Greska: Flawfinder nije instaliran."
    echo "Instalirati Flawfinder: sudo apt install flawfinder"
    exit 1
fi

echo "Pokrece se flawfinder..."
flawfinder --html "$PROJECT_ROOT" > "$REPORT_FILE"

echo ""
echo "Analiza je zavrsena."
echo "Izvestaj se nalazi u: $REPORT_FILE"
echo "Izvestaj se moze otvoriti u browseru komandom: xdg-open $REPORT_FILE"
