# Izveštaj analize projekta

## Clang-Tidy

**Clang-Tidy** predstavlja jedan od *Clang* zasnovanih alata koji obavlja statičku analizu koda (vrši analiziranje izvornog koda bez njegovog izvršavanja sa ciljem pronalaženja grešaka, poboljšanja kvaliteta koda i ispravljanja neoptimalno napisanih delova koda). **Clang-Tidy** je *C++* linter alati koji analizira kod i pronalazi programske i stilske greške unutar koda.

---
### Instalacija Clang-Tidy i pokretanje analize

Za statičku analizu C++ koda koristimo **Clang-Tidy**, koji se može instalirati na Linux sistemima pomoću sledeće komande:

```bash
sudo apt update && sudo apt install clang-tidy
```

Nakon instalacije, potrebno je kreirati skriptu `run_clang_tidy.sh` koja automatski pokreće analizu nad svim `.cpp` fajlovima u projektu. Skripta definiše koren projekta, build direktorijum, kao i putanje za tekstualni i HTML izveštaj, generiše `compile_commands.json` koristeći CMake i potom pokreće Clang-Tidy nad izvornim fajlovima. Takođe, omogućava opcionalno generisanje HTML izveštaja pomoću alata `aha`.

**AHA** (ANSI HTML Adapter) je alat koji omogućava konverziju ANSI obojenog izlaza iz terminala u HTML izveštaje. U kontekstu analize softvera, može se koristiti za generisanje preglednih HTML izveštaja iz alata koji daju obojen izlaz u terminalu, kao što su `flawfinder`, `cppcheck` ili `clang-tidy`.

Na Linux sistemima, **AHA** se može instalirati komandom:

```bash
sudo apt update && sudo apt install aha
```

`run_clang_tidy.sh`

```bash
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
```

Pre nego što se skripta pokrene, potrebno joj je dodeliti izvršna prava:
```bash
chmod +x run_clang_tidy.sh
```
Skripta se pokreće komandom iz `clang-tidy` foldera:
```bash
./run_clang_tidy.sh
```
Rezultati se beleže u `clang_tidy_results.txt`, a može se generisati i  HTML izveštaj, radi bolje preglednosti i ti rezultati ce biti sačuvani  u `clang_tidy_report.html`. Rezultati se mogu videti pozivanjem komande `cat clang_tidy_results.txt` u terminalu ili pokretanjem u browseru putanje koju dobijemo kao rezultat sktipte.


![img](clang-tidy/clang_tidy_results.png)



---
### Analiza dobijenih rezultata

![img](clang-tidy/clang_tidy_html_report.png)


 Nakon analize generisanog `clang_tidy_report.html`, Clang-Tidy je detektovao jedan *warning* da promenljiva/niz `players` dobija vrednost prilikom inicijalizacije, ali se ta vrednost nigde ne koristi. Ovo je tzv. *dead store* ili mrtvi kod. Uklanjanjem ovog niza, *warning* će nestati.

- **Lokacija problema:**  
  Fajl: `game.cpp`  
  Linija: 298

