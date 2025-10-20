# 2023_Analysis_06-catan

## Informacije o projektu:

Projekat **Catan** je igrica koja simulira stratešku društvenu igru Catan (1995) u kojoj se 4 igrača međusobno takmiče u cilju da kolonizuju ostrvo Katan, tako što dobijaju resurse u zavisnosti od bacanja kockica, koje kasnije koriste u izgradnji puteva, naselja i gradova. Pobednik je onaj ko prvi stigne do 10 poena.

Za implementaciju je korišćen programski jezik *C++* i razvojno okruženje *Qt 5*. Projekat **Catan** je rađen za potrebe kursa Razvoj softvera na Matematičkom fakultetu i može se pronaći na adresi:
[https://gitlab.com/matf-bg-ac-rs/course-rs/projects-2022-2023/06-catan/-/tree/main?ref_type=heads](https://gitlab.com/matf-bg-ac-rs/course-rs/projects-2022-2023/06-catan/-/tree/main?ref_type=heads). U okviru *README.md* fajla tog projekta mogu se pronaći i detaljnije informacije o igrici, instalaciji, pokretanju, autorima, kao i demo snimak.

Analiza u ovom radu odnosi se na verziju sa *main* grane (commit hash: `459066599278054ab57aa4ccac935e6dbc2baed0`).
Cilj analize je prikaz primene različitih alata za **verifikaciju softvera**, kao i uvida u dobijene rezultate, pronađene greške i zaključke izvedene iz analize.

Detaljan izveštaj nalazi se u fajlu **ProjectAnalysisReport.md**.

---
## Alati korišćeni za analizu projekta

1. **Clang-Tidy** – alat za statičku analizu koda koji detektuje potencijalne greške, loše prakse i neusklađenosti sa C++ standardom.
2. **Lizard** – alat za merenje kompleksnosti funkcija, broja linija koda i drugih metrika kvaliteta koda.
3. **Cppcheck** – alat za statičku analizu koji otkriva greške, neiskorišćene promenljive, probleme sa tipovima i nebezbedne konstrukcije.
4. **Flawfinder** – bezbednosni analizator koda koji traži potencijalno ranjive funkcije i nebezbedne obrasce u C/C++ projektima. 
5. **Valgrind**
   - **Memcheck** – alat za detekciju curenja memorije i neinicijalizovanih pokazivača.
   - **Massif** – alat za profilisanje memorijskog korišćenja kroz vreme.


---
## Instalacija potrebnih alata


Na Linux sistemima, svi potrebni alati za analizu koda mogu se instalirati pomoću sledećih komandi.
Ova komande ažuriraju listu paketa i instaliraju **Valgrind**, **Clang-Tidy**, **Cppcheck**,  **Flawfinder** i **Lizard**:

```bash
sudo apt update && sudo apt install -y valgrind clang-tidy cppcheck flawfinder
pip install lizard
```

---
## Zaključak:


## Autor:
Jovana Đurović, 1052/2023


