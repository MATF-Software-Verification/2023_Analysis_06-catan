#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../catan/src" && pwd)"
OUTPUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HTML_DIR="$OUTPUT_DIR/html_report"

echo "============================================"
echo "Pokrece se Cppcheck analiza projekta"
echo "============================================"
echo "Koren projekta: $PROJECT_ROOT"
echo "Rezultati ce se nalaziti u: $HTML_DIR"
echo ""

mkdir -p "$HTML_DIR"

echo "Pokrece se cppcheck nad .cpp i .h fajlovima..."

#ignorisu se build i moc fajlovi
find "$PROJECT_ROOT" \( -path "$PROJECT_ROOT/build" -o -name "moc_*.cpp" \) -prune -o \
    \( -name "*.cpp" -o -name "*.h" \) -print | \
    xargs cppcheck --enable=all --std=c++17 --language=c++ --inconclusive 2>&1 | \
    aha --black --title "Cppcheck Report for Catan" > "$HTML_DIR/cppcheck_report.html"

echo "Analiza je zavrsena. Otvoriti  $HTML_DIR/cppcheck_report.html u browseru kako bi se videli rezultati"
