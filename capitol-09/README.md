# Capítol 9 — Transaccions i control de concurrència

Aquesta carpeta conté els exercicis resolts del capítol 9 del llibre *Bases de Dades 360*. El capítol explica les transaccions des de zero: propietats ACID, `BEGIN`/`COMMIT`/`ROLLBACK`, `SAVEPOINT`, problemes de concurrència (lectura bruta, no repetible, fantasma), nivells d'aïllament i mecanismes de bloqueig.

Cada problema es presenta amb dos enunciats diferents: la versió "**botiga**" (transferències i comandes, més típica del món bancari) i la versió "**institut**" (matrícules, reassignació de mòduls), que reutilitza la base de dades del capítol 6.

---

## 📂 Fitxers

```
capitol-09/
├── README.md
├── MySQL/
│   ├── exercici_9_1_matricular_un_alumne.sql
│   ├── exercici_9_2_analisi_de_problemes_de_concurrenci.sql
└── PostgreSQL/
    ├── exercici_9_1_matricular_un_alumne.sql
    └── exercici_9_2_analisi_de_problemes_de_concurrenci.sql


---

## 🗄️ Bases de dades necessàries

- Les versions **botiga** (`9.1`, `9.2`) creen les seves pròpies taules (`producte_botiga`, `comanda_botiga`, `linia_botiga`, `compte_bancari`...) al principi del fitxer.
- Les versions **institut** requereixen el joc de dades del **capítol 6**:
  - `capitol-06/MySQL/01_institut_mysql.sql` + `02_institut_inserts_mysql.sql`
  - `capitol-06/PostgreSQL/01_institut_postgresql.sql` + `02_institut_inserts_postgresql.sql`

---

## ⚠️ Com executar (molt important)

Aquests exercicis simulen **concurrència real**, així que sovint cal **dues finestres del client SQL obertes alhora**, cadascuna amb la seva pròpia transacció.

Per als exercicis 9.2 i 9.3, obre:

```bash
# Terminal 1 — Sessió A
mysql -u <usuari> -p institut
# o
psql -U <usuari> -d institut

# Terminal 2 — Sessió B (a part)
mysql -u <usuari> -p institut
# o
psql -U <usuari> -d institut
```

I executa les sentències de cada sessió en l'ordre indicat dins del fitxer. **No executis el fitxer sencer d'una sola tirada**: les comprovacions de concurrència no tindrien sentit.

L'exercici 9.1 sí que es pot executar en una sola sessió:

```bash
# MySQL / MariaDB
mysql -u <usuari> -p institut < MySQL/exercici_9_1_matricular_un_alumne.sql

# PostgreSQL
psql -U <usuari> -d institut -f PostgreSQL/exercici_9_1_matricular_un_alumne.sql
```

---


[← Tornar al README principal](../README.md)
