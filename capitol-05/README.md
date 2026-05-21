# Capítol 5 — Disseny físic i tipus de dades

Aquesta carpeta conté els exercicis resolts del capítol 5 del llibre *Bases de Dades 360*. El capítol fa el salt del model lògic al model físic: tria de tipus de dades (numèrics, text, temporals, booleans, ENUM, JSON), restriccions físiques (`CHECK`, `NOT NULL`, `UNIQUE`, claus foranes), índexs i una primera lectura del pla d'execució amb `EXPLAIN`.

---

## 📂 Fitxers

Cada exercici té dues versions paral·leles, una per a cada SGBD. Els fitxers MySQL i PostgreSQL es mantenen el més iguals possible — es diferencien només on la sintaxi diverge.

```
capitol-05/
├── README.md                                          ← aquest fitxer
├── MySQL/
│   ├── exercici_5_1_tria_de_tipus_de_dades.sql
│   ├── exercici_5_2_creacio_i_avaluacio_d_indexs.sql
│   ├── exercici_5_3_evolucio_d_un_esquema_en_produccio.sql
│   └── exercici_5_4_refactor_amb_conversio_de_tipus_de.sql
└── PostgreSQL/
    └── (mateixos fitxers, adaptats a la sintaxi de PostgreSQL)
```

| Exercici | Tema | Objectiu |
|---|---|---|
| **5.1** | Tria de tipus de dades | Definir el tipus òptim per cada columna de la taula `producte` d'una botiga en línia, justificant cada decisió. |
| **5.2** | Creació i avaluació d'índexs | Crear i comparar índexs sobre una taula real, mesurar-ne l'efecte amb `EXPLAIN`. |
| **5.3** | Evolució d'un esquema en producció | Aplicar `ALTER TABLE` per refactoritzar un esquema viu sense perdre dades. |
| **5.4** | Refactor amb conversió de tipus | Migrar dades entre tipus incompatibles amb seguretat. |

---

## 🔑 Diferències sintàctiques que veuràs

| Concepte | MySQL/MariaDB | PostgreSQL |
|---|---|---|
| Autoincrement | `AUTO_INCREMENT` | `GENERATED ALWAYS AS IDENTITY` |
| Enter no negatiu | `INT UNSIGNED`, `TINYINT UNSIGNED` | `INT` + `CHECK (col >= 0)` o `SMALLINT` |
| Decimals exactes | `DECIMAL(p,s)` | `NUMERIC(p,s)` |
| Modificar columna | `MODIFY COLUMN`, `CHANGE COLUMN` | `ALTER COLUMN ... TYPE` / `DROP NOT NULL` |
| Reanomenar columna | `RENAME COLUMN` (≥ 8.0) | `RENAME COLUMN` |
| Marca de temps automàtica | `TIMESTAMP ... ON UPDATE CURRENT_TIMESTAMP` | `TIMESTAMPTZ` + `TRIGGER` |
| Pla d'execució | `EXPLAIN`, `EXPLAIN ANALYZE` (≥ 8.0) | `EXPLAIN`, `EXPLAIN ANALYZE` |

---

## 🚀 Com executar

Aquests exercicis assumeixen una base de dades buida o el joc de dades del **capítol 6** (carpetes `capitol-06/MySQL/` i `capitol-06/PostgreSQL/`).

```bash
# MySQL / MariaDB
mysql -u <usuari> -p < MySQL/exercici_5_1_tria_de_tipus_de_dades.sql

# PostgreSQL
psql -U <usuari> -d <bd> -f PostgreSQL/exercici_5_1_tria_de_tipus_de_dades.sql
```

> ⚠️ Alguns exercicis (5.3 i 5.4) parteixen d'un esquema previ que cal crear primer. Llegeix el bloc inicial del fitxer SQL.

---

## 🔗 Referències al llibre

- **Capítol 5** — *Disseny físic i tipus de dades* (versió canònica del capítol).
- **Capítol 6** — joc de dades de l'institut, on s'apliquen aquestes decisions de disseny.
- **Capítol 8** — optimització de consultes, on els índexs creats aquí prenen tot el seu sentit.

[← Tornar al README principal](../README.md)
