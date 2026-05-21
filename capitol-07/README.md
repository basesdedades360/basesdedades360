# Capítol 7 — Agrupacions, JOINs i subconsultes

Aquesta carpeta conté els exercicis resolts del capítol 7 del llibre *Bases de Dades 360*. El capítol es centra en el cor de les consultes SQL multi-taula: funcions d'agregació, `GROUP BY` i `HAVING`, tots els tipus de `JOIN` (`INNER`, `LEFT`, `RIGHT`, `FULL OUTER`, `CROSS`, auto-join) i les subconsultes (correlacionades i no correlacionades, amb `EXISTS`, `ANY`, `ALL`).

---

## 📂 Fitxers

```
capitol-07/
├── README.md                                              ← aquest fitxer
├── MySQL/
│   ├── exercici_7_1_consultes_multi_taula_amb_joins_i_a.sql
│   └── exercici_7_2_subconsultes_i_exists.sql
└── PostgreSQL/
    └── (mateixos fitxers, sintaxi PostgreSQL)
```

| Exercici | Tema | Objectiu |
|---|---|---|
| **7.1** | Consultes multi-taula amb JOINs i agregació | Llistar alumnes amb notes, calcular mitjanes per alumne i comparar-les amb la mitjana global; per a cada professor, comptar mòduls i hores. |
| **7.2** | Subconsultes i EXISTS | Resoldre les mateixes preguntes utilitzant subconsultes correlacionades amb `EXISTS` i `NOT EXISTS`, i comparar-ne la llegibilitat amb la versió amb `JOIN`. |

---

## 🗄️ Base de dades necessària

Aquests exercicis treballen sobre la base de dades `institut` que s'introdueix al **capítol 6**. Cal haver executat prèviament els scripts:

- `capitol-06/MySQL/01_institut_mysql.sql` + `02_institut_inserts_mysql.sql`
- `capitol-06/PostgreSQL/01_institut_postgresql.sql` + `02_institut_inserts_postgresql.sql`

---

## 🔑 Notes de portabilitat

La majoria de les consultes d'aquest capítol són sintàcticament idèntiques en els dos SGBD. Les diferències que apareixen són puntuals:

| Concepte | MySQL/MariaDB | PostgreSQL |
|---|---|---|
| Concatenació de cadenes | `CONCAT(a, ' ', b)` | `a \|\| ' ' \|\| b` o `CONCAT(a, ' ', b)` |
| `FULL OUTER JOIN` | No suportat — emular amb `UNION` de `LEFT JOIN` i `RIGHT JOIN` | Suportat natiu |
| `LIMIT ... OFFSET` | `LIMIT n OFFSET m` o `LIMIT m, n` | `LIMIT n OFFSET m` |

---

## 🚀 Com executar

```bash
# Després d'executar primer els scripts de capítol-06 (esquema + dades de prova):

# MySQL / MariaDB
mysql -u <usuari> -p institut < MySQL/exercici_7_1_consultes_multi_taula_amb_joins_i_a.sql

# PostgreSQL
psql -U <usuari> -d institut -f PostgreSQL/exercici_7_1_consultes_multi_taula_amb_joins_i_a.sql
```

---

## 🔗 Referències al llibre

- **Capítol 6** — *Fonaments de SQL: DDL i DML*. El joc de dades `institut` que utilitzen tots aquests exercicis.
- **Capítol 8** — *Optimització de consultes*. Aquí veuràs els plans d'execució d'aquestes mateixes consultes.

[← Tornar al README principal](../README.md)
