# Capítol 7 — Agrupacions, JOINs i subconsultes

Aquesta carpeta conté els exercicis resolts del capítol 7 del llibre *Bases de Dades 360*. El capítol es centra en el cor de les consultes SQL multi-taula: funcions d'agregació, `GROUP BY` i `HAVING`, tots els tipus de `JOIN` (`INNER`, `LEFT`, `RIGHT`, `FULL OUTER`, `CROSS`, auto-join) i les subconsultes (correlacionades i no correlacionades, amb `EXISTS`, `ANY`, `ALL`).

---

## 📂 Fitxers

```
capitol-07/
├── README.md                                              ← aquest fitxer
├── MySQL/
│   ├── exercici_7_1_consultes_joins.sql
│   └── exercici_7_2_subconsultes_i_exists.sql
└── PostgreSQL/
    ├── exercici_7_1_consultes_joins.sql
    └── exercici_7_2_subconsultes_i_exists.sql

---

## 🗄️ Base de dades necessària

Aquests exercicis treballen sobre la base de dades `institut` que s'introdueix al **capítol 6**. Cal haver executat prèviament els scripts:

- `capitol-06/MySQL/01_institut_mysql.sql` + `02_institut_inserts_mysql.sql`
- `capitol-06/PostgreSQL/01_institut_postgresql.sql` + `02_institut_inserts_postgresql.sql`

---


## 🚀 Com executar

```bash
# Després d'executar primer els scripts de capítol-06 (esquema + dades de prova):

# MySQL / MariaDB
mysql -u <usuari> -p institut < MySQL/exercici_7_1_consultes_multi_taula_amb_joins_i_a.sql

# PostgreSQL
psql -U <usuari> -d institut -f PostgreSQL/exercici_7_1_consultes_multi_taula_amb_joins_i_a.sql
```



[← Tornar al README principal](../README.md)
