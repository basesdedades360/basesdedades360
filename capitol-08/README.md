# Capítol 8 — Optimització de consultes

Aquesta carpeta conté els exercicis resolts del capítol 8 del llibre *Bases de Dades 360*. El capítol cobreix l'optimització de consultes: índexs (B-tree, compostos, parcials, *covering*), lectura de plans d'execució amb `EXPLAIN` i `EXPLAIN ANALYZE`, reescriptura de consultes per a sargabilitat, i com mesurar l'impacte real de cada decisió.

---

## 📂 Fitxers

```
capitol-08/
├── README.md                                              ← aquest fitxer
├── MySQL/
│   └── exercici_8_2_reescriptura_de_Consultes.sql
└── PostgreSQL/
    ├── exercici_8_1_disseny_d_indexs.sql
    └── exercici_8_3_procediment_complet_de_diagnostic.sql


> ℹ️ A diferència dels altres capítols, aquí cada exercici està orientat principalment a un SGBD perquè explora característiques específiques (índexs parcials a PostgreSQL, `ANALYZE TABLE` a MySQL). Les idees són transferibles però el codi de mesura és específic.

---

## 🗄️ Base de dades necessària

Tots els exercicis treballen sobre la base de dades `institut` del **capítol 6**. Abans d'executar-los, cal carregar:

- `capitol-06/MySQL/01_institut_mysql.sql` + `02_institut_inserts_mysql.sql`
- `capitol-06/PostgreSQL/01_institut_postgresql.sql` + `02_institut_inserts_postgresql.sql`

---

## 🚀 Com executar

```bash
# MySQL / MariaDB
mysql -u <usuari> -p institut < MySQL/exercici_8_2_reescriptura_per_a_sargabilitat_i_p.sql

# PostgreSQL
psql -U <usuari> -d institut -f PostgreSQL/exercici_8_1_disseny_d_indexs_i_mesura_del_seu_e.sql
```

Per veure el pla d'execució d'una consulta sense executar-la:

```sql
-- MySQL / MariaDB
EXPLAIN SELECT ...;
EXPLAIN ANALYZE SELECT ...;   -- ≥ 8.0

-- PostgreSQL
EXPLAIN SELECT ...;
EXPLAIN (ANALYZE, BUFFERS) SELECT ...;
```


[← Tornar al README principal](../README.md)
