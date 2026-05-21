# Capítol 12 — Programació al SGBD amb PostgreSQL (PL/pgSQL)

Aquesta carpeta conté els exercicis resolts del capítol 12 del llibre *Bases de Dades 360*. El capítol cobreix la programació al servidor amb **PL/pgSQL**: funcions, procediments, blocs anònims `DO`, variables i àmbits, control de flux, cursors, gestió d'excepcions i triggers.

---

## 📂 Fitxers

> ℹ️ **Capítol exclusivament PostgreSQL.** PL/pgSQL és un llenguatge específic de PostgreSQL. L'equivalent a MySQL/MariaDB seria *Stored Routines* en SQL/PSM, però la sintaxi és prou diferent perquè els exemples no es puguin reaprofitar directament. Per això, els exercicis equivalents en sintaxi **MySQL/MariaDB** són al [`capitol-11/`](../capitol-11/).

```
capitol-12/
├── README.md
└── PostgreSQL/
    ├── exercici_12_1_funcio_nota_mitjana_alumne_p_id_alu.sql
    ├── exercici_12_2_procediment_matricular_alumne_p_id.sql
    └── exercici_12_3_trigger_d_auditoria_del_salari_amb.sql
```

| Exercici | Tema |
|---|---|
| **12.1** | Funció `nota_mitjana_alumne(p_id_alumne)`: retorna la nota mitjana d'un alumne; gestió de `NULL` i alumnes sense matrícules. |
| **12.2** | Procediment `matricular_alumne(p_id_alumne, p_id_modul, p_curs)`: insereix matrícula amb validacions i `RAISE EXCEPTION` quan cal. |
| **12.3** | Trigger d'auditoria del salari amb límit configurable: registra canvis a una taula `auditoria_salari` i rebutja augments massa grans. |

---

## 🗄️ Base de dades necessària

Els exercicis treballen sobre la base de dades `institut` del **capítol 6**:

- `capitol-06/PostgreSQL/01_institut_postgresql.sql`
- `capitol-06/PostgreSQL/02_institut_inserts_postgresql.sql`

A més, alguns exercicis creen objectes addicionals (taula `auditoria_salari` per al trigger 12.3). Els scripts inclouen aquesta preparació.

---

## 🚀 Com executar

```bash
# 1. Connecta't a la base de dades institut
psql -U <usuari> -d institut

# 2. Carrega l'exercici dins de la sessió oberta
\i PostgreSQL/exercici_12_1_funcio_nota_mitjana_alumne_p_id_alu.sql

# O bé, des de fora:
psql -U <usuari> -d institut -f PostgreSQL/exercici_12_1_funcio_nota_mitjana_alumne_p_id_alu.sql
```

Després pots cridar les funcions/procediments:

```sql
-- Funcions: SELECT
SELECT nota_mitjana_alumne(7);

-- Procediments: CALL
CALL matricular_alumne(7, 3, 2025);

-- Triggers: actuen sols quan modifiques la taula
UPDATE professor SET salari = salari * 1.50 WHERE id_prof = 1;  -- pot disparar el trigger
```

---

## 🔑 Conceptes clau de PL/pgSQL

| Concepte | Sintaxi |
|---|---|
| Bloc | `DO $$ BEGIN ... END $$;` |
| Funció | `CREATE FUNCTION ... RETURNS ... AS $$ ... $$ LANGUAGE plpgsql;` |
| Procediment | `CREATE PROCEDURE ... AS $$ ... $$ LANGUAGE plpgsql;` |
| Variable amb tipus heretat | `v_nota matricula.nota_final%TYPE;` |
| Tota la fila d'una taula | `v_alumne alumne%ROWTYPE;` |
| Gestió d'errors | `EXCEPTION WHEN ... THEN ...` |
| Llançar excepció | `RAISE EXCEPTION 'missatge' USING ERRCODE = '...';` |
| Trigger | `CREATE TRIGGER ... BEFORE/AFTER ... EXECUTE FUNCTION fn();` |

---

## 🔗 Referències al llibre

- **Capítol 6** — *Fonaments de SQL*. Base de dades `institut`.
- **Capítol 9** — *Transaccions i concurrència*. Els procediments d'aquest capítol fan servir transaccions implícites.
- **Capítol 13** — *Control d'accés*. Els privilegis sobre rutines (`EXECUTE`) es defineixen allà.

[← Tornar al README principal](../README.md)
