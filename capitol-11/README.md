# Capítol 11 — Programació al SGBD amb MySQL/MariaDB

Aquesta carpeta conté els exercicis resolts del capítol 11 del llibre *Bases de Dades 360*. El capítol cobreix la programació al servidor amb **MySQL/MariaDB**: funcions, procediments emmagatzemats, variables i àmbits, control de flux (`IF`, `CASE`, `WHILE`, `REPEAT`, `LOOP`), cursors, gestió d'excepcions (`DECLARE HANDLER`, `SIGNAL`, `RESIGNAL`) i triggers.

El **capítol 12** del llibre tracta exactament els mateixos conceptes per a **PostgreSQL (PL/pgSQL)**. Si treballes amb PostgreSQL, mira la carpeta [`capitol-12/`](../capitol-12/).

---

## 📂 Fitxers

```
capitol-11/
├── README.md
└── MySQL/
    ├── exercici_11_1_funcio_nota_mitjana_alumne_p_id_alu.sql
    ├── exercici_11_2_procediment_matricular_alumne_p_id.sql
    └── exercici_11_3_trigger_d_auditoria_del_salari_amb.sql
```

| Exercici | Tema |
|---|---|
| **11.1** | Funció `nota_mitjana_alumne(p_id_alumne)`: retorna la nota mitjana de l'alumne (arrodonida a 2 decimals); validació amb `SIGNAL` si l'alumne no existeix; `NULL` si encara no té cap nota confirmada. |
| **11.2** | Procediment `matricular_alumne(p_id_alumne, p_id_modul, p_convocatoria)`: insereix matrícula dins d'una transacció amb validacions encadenades, bloqueig amb `FOR UPDATE` i propagació d'errors amb `RESIGNAL`. |
| **11.3** | Dos triggers sobre `professor`: un `BEFORE UPDATE` que prohibeix rebaixes superiors al 10%, i un `AFTER UPDATE` que registra els canvis de salari a una taula `auditoria_salari`. |

---

## 🗄️ Base de dades necessària

Els exercicis treballen sobre la base de dades `institut` del **capítol 6**:

- `capitol-06/MySQL/01_institut_mysql.sql`
- `capitol-06/MySQL/02_institut_inserts_mysql.sql`

A més, l'exercici 11.3 crea la taula `auditoria_salari` automàticament.

---

## 🚀 Com executar

```bash
# 1. Connecta't a la base de dades institut
mysql -u <usuari> -p institut

# 2. Carrega l'exercici dins de la sessió oberta
source MySQL/exercici_11_1_funcio_nota_mitjana_alumne_p_id_alu.sql;

# O bé, des de fora:
mysql -u <usuari> -p institut < MySQL/exercici_11_1_funcio_nota_mitjana_alumne_p_id_alu.sql
```

Després pots cridar les funcions/procediments:

```sql
-- Funcions: SELECT
SELECT nota_mitjana_alumne(1);

-- Procediments: CALL
CALL matricular_alumne(1, 5, 1);

-- Triggers: s'activen automàticament quan modifiques la taula
UPDATE professor SET salari = salari * 1.05 WHERE id_prof = 1;
SELECT * FROM auditoria_salari WHERE id_prof = 1 ORDER BY moment;
```

---

## 🔑 Conceptes clau a MySQL/MariaDB

| Concepte | Sintaxi |
|---|---|
| Canvi de delimitador | `DELIMITER //` ... `DELIMITER ;` |
| Funció | `CREATE FUNCTION nom(...) RETURNS tipus DETERMINISTIC READS SQL DATA BEGIN ... END //` |
| Procediment | `CREATE PROCEDURE nom(IN/OUT/INOUT p tipus) BEGIN ... END //` |
| Declarar variable | `DECLARE v_nom tipus DEFAULT valor;` |
| Assignar valor | `SET v_nom = ...;` o `SELECT ... INTO v_nom FROM ...;` |
| Llançar error | `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '...';` |
| Capturar errors | `DECLARE EXIT/CONTINUE HANDLER FOR SQLEXCEPTION ...` |
| Propagar error | `RESIGNAL;` |
| Trigger | `CREATE TRIGGER nom BEFORE/AFTER INSERT/UPDATE/DELETE ON taula FOR EACH ROW BEGIN ... END` |
| Files antiga / nova | `OLD.col`, `NEW.col` |

---

## 🔄 Equivalències MySQL ↔ PostgreSQL

Per facilitar la comparació amb el **capítol 12** (PL/pgSQL):

| Concepte | MySQL/MariaDB | PostgreSQL (PL/pgSQL) |
|---|---|---|
| Delimitador | `DELIMITER //` ... `DELIMITER ;` | `$$ ... $$` (citat dòlar) |
| Llenguatge | (per defecte) | `LANGUAGE plpgsql` |
| Característica DET. | `DETERMINISTIC`, `READS SQL DATA` | `STABLE`, `IMMUTABLE`, `VOLATILE` |
| Excepció | `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '...';` | `RAISE EXCEPTION '...' USING ERRCODE = '...';` |
| Handler | `DECLARE ... HANDLER FOR SQLEXCEPTION ...` | `EXCEPTION WHEN ... THEN ...` |
| Propagació | `RESIGNAL;` | `RAISE;` |
| Cursor implícit | (cal `DECLARE CURSOR` explícit) | `FOR rec IN SELECT ... LOOP ... END LOOP;` |
| Trigger | Codi dins del trigger | Funció separada cridada des del trigger |

---

## 🔗 Referències al llibre

- **Capítol 6** — *Fonaments de SQL*. La base de dades `institut`.
- **Capítol 9** — *Transaccions i concurrència*. Conceptes que es fan servir a l'exercici 11.2.
- **Capítol 12** — *Programació al SGBD (PL/pgSQL)*. La versió PostgreSQL dels mateixos exercicis.
- **Capítol 13** — *Control d'accés*. Privilegi `EXECUTE` sobre funcions i procediments.
