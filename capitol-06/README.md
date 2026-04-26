# Capítol 6 — Fonaments de SQL: DML i funcions integrades

Aquesta carpeta conté els scripts SQL del capítol 6 del llibre *Bases de Dades 360*. El capítol estableix els fonaments del llenguatge SQL: operacions DML (`INSERT`, `UPDATE`, `DELETE`, `SELECT`), filtratge amb `WHERE`, ús de funcions integrades i agregació amb `GROUP BY`/`HAVING`, sempre amb la sintaxi paral·lela de **MySQL/MariaDB** i **PostgreSQL**.

---

## 📂 Fitxers

| Fitxer | Descripció |
|---|---|
| [`institut_mysql.sql`](./institut_mysql.sql) | Esquema complet de la base de dades `institut` per a **MySQL/MariaDB**. |
| [`institut_postgresql.sql`](./institut_postgresql.sql) | Esquema complet de la base de dades `institut` per a **PostgreSQL**. |

Ambdós scripts creen les mateixes 5 taules amb una estructura equivalent, però adaptada a les particularitats de cada SGBD (`AUTO_INCREMENT` vs `GENERATED ALWAYS AS IDENTITY`, `TINYINT UNSIGNED` vs `SMALLINT`, `DECIMAL` vs `NUMERIC`, etc.).

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

### Online amb DB Fiddle (la manera més ràpida)

1. Obre [DB Fiddle](https://www.db-fiddle.com/) en dues pestanyes:
   - Una amb **MySQL 8.0**
   - Una amb **PostgreSQL 15**
2. Copia el contingut del fitxer corresponent al panell esquerre.
3. Prem **Run**.

### Localment

```bash
# MySQL / MariaDB
mysql -u <usuari> -p < institut_mysql.sql

# PostgreSQL
psql -U <usuari> -f institut_postgresql.sql
```

---

## ⚙️ Característiques utilitzades

L'esquema fa servir característiques modernes de cada SGBD que cal tenir en compte:

| Característica | MySQL/MariaDB | PostgreSQL |
|---|---|---|
| Autoincrement | `AUTO_INCREMENT` | `GENERATED ALWAYS AS IDENTITY` |
| Tipus enter petit no negatiu | `TINYINT UNSIGNED` | `SMALLINT` |
| Decimals | `DECIMAL(p,s)` | `NUMERIC(p,s)` |
| Tipus any | `YEAR` | `SMALLINT` + `CHECK` |
| `CHECK` natiu | MySQL ≥ 8.0.16 / MariaDB ≥ 10.2 | Sempre |
| Codificació | `utf8mb4` (BD) | `UTF8` (BD) |

> ⚠️ **Versions anteriors de MySQL** (< 8.0.16) ignoraven les restriccions `CHECK` silenciosament. Si treballes amb una versió antiga, els `CHECK` es validaran al codi de l'aplicació, no al SGBD.

---

## ✅ Verificació ràpida

Després d'executar l'script, pots verificar que tot s'ha creat correctament:

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

---

## 🔗 Recursos relacionats al llibre

- **Capítol 5** — *Disseny físic i tipus de dades*: detalla per què s'han triat aquests tipus i restriccions.
- **Capítol 6** — *Fonaments de SQL*: utilitza aquest esquema per a tots els exemples i exercicis.
- **Capítol 7** — *`JOIN`s i subconsultes* (en preparació): aquí veuràs com extreure informació combinada de les 5 taules.

---

[← Tornar al README principal](../README.md)
