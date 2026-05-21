# Capítol 9 — Transaccions i control de concurrència

Aquesta carpeta conté els exercicis resolts del capítol 9 del llibre *Bases de Dades 360*. El capítol explica les transaccions des de zero: propietats ACID, `BEGIN`/`COMMIT`/`ROLLBACK`, `SAVEPOINT`, problemes de concurrència (lectura bruta, no repetible, fantasma), nivells d'aïllament i mecanismes de bloqueig.

Cada problema es presenta amb dos enunciats diferents: la versió "**botiga**" (transferències i comandes, més típica del món bancari) i la versió "**institut**" (matrícules, reassignació de mòduls), que reutilitza la base de dades del capítol 6.

---

## 📂 Fitxers

```
capitol-09/
├── README.md
├── MySQL/
│   ├── exercici_9_1_processar_una_comanda_pas_a_pas_amb.sql
│   ├── exercici_9_1_versio_institut_matricular_un_alumne_a_diversos_mod.sql
│   ├── exercici_9_2_analisi_de_problemes_de_concurrenci.sql
│   ├── exercici_9_2_versio_institut_analisi_de_problemes_de_concurrenci.sql
│   └── exercici_9_3_versio_institut_provocar_i_evitar_un_deadlock_reass.sql
└── PostgreSQL/
    └── (mateixos fitxers, sintaxi PostgreSQL on cal)
```

| Exercici | Enunciat | Tema |
|---|---|---|
| **9.1** | Botiga | Processar una comanda pas a pas amb transacció: validar estoc, calcular total, descomptar inventari, atòmicament. |
| **9.1** (versió institut) | Matricular un alumne a diversos mòduls amb transacció i `SAVEPOINT`. |
| **9.2** | Botiga | Anàlisi dels tres problemes clàssics de concurrència (lectura bruta, no repetible, fantasma). |
| **9.2** (versió institut) | Els mateixos problemes vistos sobre la base de dades de l'institut. |
| **9.3** (versió institut) | Provocar i evitar un *deadlock* reassignant mòduls a professors. |

> ℹ️ L'exercici **9.3 (versió botiga)** del capítol no genera codi SQL aïllat — es presenta com un escenari pas a pas en dues sessions simultànies amb taules markdown. Si vols reproduir-lo, fes servir la versió institut, que és funcionalment equivalent.

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
mysql -u <usuari> -p institut < MySQL/exercici_9_1_processar_una_comanda_pas_a_pas_amb.sql

# PostgreSQL
psql -U <usuari> -d institut -f PostgreSQL/exercici_9_1_versio_institut_matricular_un_alumne_a_diversos_mod.sql
```

---

## 🔑 Diferències sintàctiques rellevants

| Concepte | MySQL/MariaDB | PostgreSQL |
|---|---|---|
| Iniciar transacció | `START TRANSACTION;` o `BEGIN;` | `BEGIN;` |
| Bloquejar fila | `SELECT ... FOR UPDATE;` | `SELECT ... FOR UPDATE;` |
| Identificador inserit | `LAST_INSERT_ID()` | `RETURNING id` |
| Veure transaccions actives | `SHOW PROCESSLIST` | `SELECT * FROM pg_stat_activity` |
| Configurar aïllament | `SET TRANSACTION ISOLATION LEVEL ...;` | `SET TRANSACTION ISOLATION LEVEL ...;` |
| Veure deadlocks recents | `SHOW ENGINE INNODB STATUS` | logs del servidor |

---

## 🔗 Referències al llibre

- **Capítol 6** — *Fonaments de SQL*. Base de dades `institut` utilitzada per les versions "institut".
- **Capítol 8** — *Optimització de consultes*. Els bloquejos i els índexs interactuen: índexs ben dissenyats redueixen els bloquejos.

[← Tornar al README principal](../README.md)
