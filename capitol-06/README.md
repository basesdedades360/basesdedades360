# Capítol 6 — Fonaments de SQL: DML i funcions integrades

Aquesta carpeta conté els scripts SQL del capítol 6 del llibre *Bases de Dades 360*. El capítol estableix els fonaments del llenguatge SQL: operacions DML (`INSERT`, `UPDATE`, `DELETE`, `SELECT`), filtratge amb `WHERE`, ús de funcions integrades i agregació amb `GROUP BY`/`HAVING`, sempre amb la sintaxi paral·lela de **MySQL/MariaDB** i **PostgreSQL**.

---

## 📂 Fitxers

Els scripts s'organitzen en dues subcarpetes paral·leles, una per a cada SGBD. Els prefixos numèrics indiquen l'ordre d'execució: primer la creació de l'esquema (`01_`) i després la inserció de dades de prova (`02_`).

```
capitol-06/
├── README.md                              ← aquest fitxer
├── MySQL/
│   ├── 01_institut_mysql.sql              ← esquema (DDL)
│   ├── 02_institut_inserts_mysql.sql      ← dades de prova (DML)
│   ├── exercici_6_1_consultes_dml_basiques.sql
│   ├── exercici_6_2_filtratge.sql
│   ├── exercici_6_3_expressions_regulars.sql
│   └── exercici_6_4_expresions_regulars.sql
└── PostgreSQL/
    ├── 01_institut_postgresql.sql         ← esquema (DDL)
    ├── 02_institut_inserts_postgresql.sql ← dades de prova (DML)
    ├── exercici_6_1_consultes_dml_basiques.sql
    ├── exercici_6_2_filtratge.sql
    ├── exercici_6_3_expressions_regulars.sql
    └── exercici_6_4_expressions_regulars.sql

```

### Scripts d'esquema i dades

| Fitxer | Descripció |
|---|---|
| [`MySQL/01_institut_mysql.sql`](./MySQL/01_institut_mysql.sql) | Esquema complet de la base de dades `institut` per a **MySQL/MariaDB**. |
| [`MySQL/02_institut_inserts_mysql.sql`](./MySQL/02_institut_inserts_mysql.sql) | Joc de dades de prova per a **MySQL/MariaDB** (departaments, professors, alumnes, mòduls i matrícules). |
| [`PostgreSQL/01_institut_postgresql.sql`](./PostgreSQL/01_institut_postgresql.sql) | Esquema complet de la base de dades `institut` per a **PostgreSQL**. |
| [`PostgreSQL/02_institut_inserts_postgresql.sql`](./PostgreSQL/02_institut_inserts_postgresql.sql) | Joc de dades de prova per a **PostgreSQL** (mateix contingut lògic que la versió MySQL, adaptat a la sintaxi de Postgres). |

Els scripts d'esquema (`01_`) creen les mateixes 5 taules amb una estructura equivalent en els dos SGBD, però adaptada a les particularitats de cadascun (`AUTO_INCREMENT` vs `GENERATED ALWAYS AS IDENTITY`, `TINYINT UNSIGNED` vs `SMALLINT`, `DECIMAL` vs `NUMERIC`, etc.). Els scripts d'inserció (`02_`) omplen aquestes taules amb un joc de dades pensat per practicar `JOIN`s, subconsultes, agrupacions i agregacions, incloent casos especials (alumnes sense matrícules, mòduls sense professor, notes pendents `NULL`, suspesos amb segona i tercera convocatòria, etc.).

### Exercicis resolts

Tots els exercicis estan disponibles en doble versió **MySQL/MariaDB** i **PostgreSQL**:


---

## 🗄️ Esquema de la base de dades

La base de dades modela la informació acadèmica d'un institut de formació professional:

```
┌──────────────┐ 1     N ┌──────────────┐
│ departament  │─────────│  professor   │
└──────────────┘         └──────┬───────┘
                                │ 1
                                │
                                │ N
                         ┌──────┴───────┐
                         │    modul     │
                         └──────┬───────┘
                                │ N
                                │
┌──────────────┐ 1     N ┌──────┴───────┐
│   alumne     │─────────│  matricula   │
└──────────────┘         └──────────────┘
```

| Taula | Descripció |
|---|---|
| `departament` | Departaments de l'institut (Informàtica, Sanitat, Idiomes...) |
| `professor` | Plantilla docent, amb salari, data d'alta i departament. |
| `alumne` | Alumnat matriculat al centre. |
| `modul` | Mòduls professionals (assignatures), assignats a un professor. |
| `matricula` | Relació N:M entre alumnes i mòduls, amb nota final i convocatòria. |

---

## 🚀 Com executar

> ⚠️ **Important:** cal executar primer l'script `01_` (creació de taules) i tot seguit el `02_` (inserció de dades). Si els executes a l'inrevés, els `INSERT` fallaran perquè les taules encara no existeixen.

### Online amb DB Fiddle (la manera més ràpida)

1. Obre [DB Fiddle](https://www.db-fiddle.com/) en dues pestanyes:
   - Una amb **MySQL 8.0**
   - Una amb **PostgreSQL 15**
2. Copia el contingut de l'script `01_...` al panell esquerre i prem **Run**.
3. A continuació, copia el contingut de l'script `02_...` al mateix panell i torna a prémer **Run**.

> Alternativament, pots concatenar tots dos fitxers en un sol panell i executar-ho tot d'una.

### Localment

```bash
# MySQL / MariaDB — esquema i dades
mysql -u <usuari> -p < MySQL/01_institut_mysql.sql
mysql -u <usuari> -p institut < MySQL/02_institut_inserts_mysql.sql

# MySQL / MariaDB — un exercici resolt
mysql -u <usuari> -p institut < MySQL/exercici_6_6_auditoria_qualitat_dades_textuals.sql

# PostgreSQL — esquema i dades
psql -U <usuari> -f PostgreSQL/01_institut_postgresql.sql
psql -U <usuari> -d institut -f PostgreSQL/02_institut_inserts_postgresql.sql

# PostgreSQL — un exercici resolt
psql -U <usuari> -d institut -f PostgreSQL/exercici_6_6_auditoria_qualitat_dades_textuals.sql
```

> El primer script (`01_`) crea la base de dades i les taules. El segon (`02_`) ja s'executa **dins** de la base de dades `institut`, per això a MySQL passem el nom de la BD com a argument i a PostgreSQL fem servir `-d institut`. Els exercicis (`exercici_6_*.sql`) també s'executen dins de la BD `institut` un cop carregades les dades.

---


## ✅ Verificació ràpida

Després d'executar els dos scripts, pots verificar que tot s'ha creat i poblat correctament:

```sql
-- MySQL / MariaDB
SHOW TABLES;
DESCRIBE professor;
```

```sql
-- PostgreSQL
\dt              -- llista taules
\d professor     -- descripció de la taula professor
```

Hauries de veure les 5 taules: `alumne`, `departament`, `matricula`, `modul`, `professor`.

Per comprovar que els inserts s'han executat correctament:

```sql
SELECT COUNT(*) FROM departament;
SELECT COUNT(*) FROM professor;
SELECT COUNT(*) FROM alumne;
SELECT COUNT(*) FROM modul;
SELECT COUNT(*) FROM matricula;
```

El resultat esperat és: 7 departaments, 13 professors, 20 alumnes, 20 mòduls i 58 matrícules.


---

[← Tornar al README principal](../README.md)
