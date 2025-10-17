#!/bin/bash
set -xe

EXEC_PATH="../../catan/src/build/Catan"
REPORT_FILE="massif_results.log"
OUT_FILE="massif.out.%p"

if [ ! -f "$EXEC_PATH" ]; then
    echo "Greska: izvrsni fajl nije pronadjen!"
    exit 1
fi

echo "Pokrece se Valgrind Massif nad: $EXEC_PATH"
echo "Log fajl: $REPORT_FILE"
echo "Massif izlaz: $OUT_FILE"
echo ""

valgrind --tool=massif \
         --heap=yes \
         --time-unit=ms \
         --log-file="$REPORT_FILE" \
         --massif-out-file="$OUT_FILE" \
         "$EXEC_PATH"

echo "Massif profiliranje je zavrseno"
echo ""
echo "Za pregled koristiti komandu:"
echo "ms_print massif.out.<PID> | less"
