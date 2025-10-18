#!/bin/bash
set -e

# === KONFIGURACIJA ===
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../catan/src" && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
OUTPUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$OUTPUT_DIR/clang_tidy_results.txt"
HTML_FILE="$OUTPUT_DIR/clang_tidy_report.html"

echo "====================================================="
echo "Pokrece se Clang-Tidy analizu projekta"
echo "====================================================="
echo "Koren projekta: $PROJECT_ROOT"
echo "Rezultati ce se nalaziti u: $OUTPUT_DIR"
echo ""


if [ ! -d "$BUILD_DIR" ]; then
    echo "Kreira se build direktorijum ukoliko ne postoji..."
    mkdir -p "$BUILD_DIR"
fi

echo "Generise se compile_commands.json pomocu CMake-a..."
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -S "$PROJECT_ROOT" -B "$BUILD_DIR" > /dev/null

if [ ! -f "$BUILD_DIR/compile_commands.json" ]; then
    echo "[ERROR] compile_commands.json nije pronadjen u $BUILD_DIR!"
    exit 1
fi


echo "Pokrece se Clang-Tidy nad svim .cpp fajlovima..."
find "$PROJECT_ROOT/sources" -name "*.cpp" | xargs clang-tidy -p "$BUILD_DIR" > "$LOG_FILE" 2>&1 || true

echo "Analiza je zavrsena. Rezultati: $LOG_FILE"


if command -v aha >/dev/null 2>&1; then
    cat "$LOG_FILE" | aha --black --title "Clang-Tidy Report for Catan" > "$HTML_FILE"
    echo " HTML izvestaj je generisan: $HTML_FILE"
else
    echo " 'aha' nije instaliran. HTML izvestaj nije generisan."
    echo "      Instaliraj alat aha pomocu: sudo apt install aha"
fi

echo ""
echo "====================================================="
echo "Analiza je uspesno zavrsena!"
echo " - Tekstualni izvestaj se nalazi u: $LOG_FILE"
echo " - HTML izvestaj: $HTML_FILE"
echo "====================================================="
