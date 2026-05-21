# Capítol 10 — SQL avançat: vistes i diccionari de dades

Aquesta carpeta conté els exercicis resolts del capítol 10 del llibre *Bases de Dades 360*. El capítol es centra en dues eines fonamentals: les **vistes** (simples, encadenades, actualitzables i materialitzades) i el **diccionari de dades** (`information_schema` i els catàlegs propis de cada SGBD).

---

## 📂 Fitxers

```
capitol-10/
├── README.md
├── MySQL/
│   ├── exercici_10_1_vista_de_notes_aprovades_per_que_no.sql
│   ├── exercici_10_2_vista_actualitzable_amb_with_check.sql
│   └── exercici_10_3_generar_el_diccionari_d_una_taula_a.sql
└── PostgreSQL/
    └── (mateixos fitxers, sintaxi PostgreSQL on cal)
```

| Exercici | Tema |
|---|---|
| **10.1** | Vista de notes aprovades: per què no és actualitzable i com saber-ho consultant el diccionari. |
| **10.2** | Vista actualitzable amb `WITH CHECK OPTION`: garantir que les modificacions respecten el filtre. |
| **10.3** | Generar el diccionari d'una taula a partir de l'`information_schema`. |

---

## 🗄️ Base de dades necessària

Tots els exercicis treballen sobre la base de dades `institut` del **capítol 6**:

- `capitol-06/MySQL/01_institut_mysql.sql` + `02_institut_inserts_mysql.sql`
- `capitol-06/PostgreSQL/01_institut_postgresql.sql` + `02_institut_inserts_postgresql.sql`

---

## 🚀 Com executar

```bash
# MySQL / MariaDB
mysql -u <usuari> -p institut < MySQL/exercici_10_1_vista_de_notes_aprovades_per_que_no.sql

# PostgreSQL
psql -U <usuari> -d institut -f PostgreSQL/exercici_10_1_vista_de_notes_aprovades_per_que_no.sql
```

---

## 🔑 Diferències sintàctiques rellevants

| Concepte | MySQL/MariaDB | PostgreSQL |
|---|---|---|
| Crear/substituir vista | `CREATE OR REPLACE VIEW` | `CREATE OR REPLACE VIEW` |
| Vista actualitzable | Depèn del SGBD (regles internes) | Suportada amb regles més estrictes |
| `WITH CHECK OPTION` | `LOCAL` / `CASCADED` | `LOCAL` / `CASCADED` |
| Vistes materialitzades | ❌ No natives — emular amb taula + trigger | ✅ `CREATE MATERIALIZED VIEW` + `REFRESH` |
| Diccionari estàndard | `information_schema.*` | `information_schema.*` |
| Catàlegs propis | `mysql.*`, `performance_schema.*` | `pg_catalog.*` (`pg_class`, `pg_attribute`...) |
| Veure mida de taula | `information_schema.TABLES` | `pg_total_relation_size('taula')` |

---

## 📖 Consultes pràctiques al diccionari (vegeu §10.6 al llibre)

El capítol inclou consultes "doctora" per:

1. Llistar totes les taules d'una BD.
2. Llistar columnes amb tipus, nullabilitat, valor per defecte.
3. Trobar la clau primària i les claus foranes d'una taula.
4. Llistar tots els índexs d'una taula.
5. Veure la mida en disc.
6. Veure la definició SQL d'una vista.
7. Llistar privilegis d'un usuari.

Aquestes consultes són una eina de diagnòstic excel·lent quan reps una base de dades aliena sense documentació.

---

## 🔗 Referències al llibre

- **Capítol 6** — *Fonaments de SQL*. Base de dades `institut` utilitzada en tots els exemples.
- **Capítol 8** — *Optimització de consultes*. Les vistes encadenades poden tenir cost d'execució: cal entendre el pla.

[← Tornar al README principal](../README.md)
