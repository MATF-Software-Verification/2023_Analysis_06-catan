#!/bin/bash
set -xe

EXEC_PATH="../../catan/src/build/Catan"

REPORT_FILE="memcheck_results.txt"

SUPP_FILE="suppressions.supp"

if [ ! -f "$EXEC_PATH" ]; then
    echo "Greska: izvrsni fajl nije pronadjen!"
    exit 1
fi

echo "Pokrece se Valgrind Memcheck nad: $EXEC_PATH"
echo "Rezultati se nalaze u: $REPORT_FILE"
echo ""

valgrind --tool=memcheck \
         --track-origins=yes \
         --leak-check=full \
         --show-leak-kinds=all \
         --log-file="$REPORT_FILE" \
         "$EXEC_PATH"

echo "Memcheck je uspesno zavrsen"
