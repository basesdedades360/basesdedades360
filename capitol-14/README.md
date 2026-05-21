# Capítol 14 — Bases de dades no relacionals (MongoDB)

Aquesta carpeta conté l'**script de càrrega** i els **exercicis resolts** del capítol 14 del llibre *Bases de Dades 360*. El capítol introdueix el món NoSQL i se centra a **MongoDB** com a sistema documental de referència: model de dades, `mongosh`, operacions CRUD, consultes amb operadors, índexs i el framework d'agregació.

A diferència dels capítols anteriors, **aquí no hi ha versió MySQL/PostgreSQL**: tot el codi és per a MongoDB.

---

## 📂 Fitxers

```
capitol-14/
├── README.md
└── MongoDB/
    ├── 01_institut_mongodb.js                          ← càrrega de la BD 'institut'
    ├── exercici_14_1_crud_i_consultes_basiques.js
    ├── exercici_14_2_modificacions.js
    ├── exercici_14_3_consultes_amb_operadors.js
    └── exercici_14_4_agregacions.js
```

| Bloc | Tema | Exercicis |
|---|---|:-:|
| **14.1** | CRUD i consultes bàsiques (`insertOne`, `find`, `countDocuments`, projeccions, `sort`, `limit`) | 1–5 |
| **14.2** | Modificacions (`updateMany` amb `$mul`/`$unset`/`$set`, `deleteMany`) | 6–9 |
| **14.3** | Consultes amb operadors (`$gte`, `$in`, `$regex`, `$lt`) | 10–13 |
| **14.4** | Framework d'agregació (`$match`, `$group`, `$lookup`, `$unwind`, `$project`) | 14–20 |

---

## 🛠️ Requisits

| Requisit | Versió mínima recomanada |
|---|---|
| **MongoDB Community Edition** | 6.0 (recomanada 7.0 o superior) |
| **mongosh** (MongoDB Shell) | 1.10 |
| **MongoDB Compass** (opcional) | 1.40 |

Alternativament, pots fer servir **MongoDB Atlas** (capa gratuïta M0 al núvol) sense instal·lar res localment.

---

## 🚀 Com executar

### Pas 1 — Carregar la base de dades

Des de la línia de comandes, obre `mongosh` dins de la carpeta del capítol:

```bash
cd capitol-14/MongoDB
mongosh
```

Un cop dins de la consola, carrega l'script d'inicialització:

```javascript
load("01_institut_mongodb.js")
```

L'script crea (o reinicia) la base de dades `institut` amb cinc col·leccions:

```
departament  ──<  professor  ──<  modul  ──<  matricula  >──  alumne
```

També crea uns quants **índexs únics** sobre `email`, `codi` i la clau composta de `matricula`.

Després de la càrrega hauries de veure:

```
Càrrega completada:
  departaments: 7
  professors:   13
  alumnes:      20
  mòduls:       20
  matrícules:   56
```

### Pas 2 — Executar un fitxer d'exercicis

```javascript
use institut
load("exercici_14_1_crud_i_consultes_basiques.js")
```

També pots copiar i enganxar les comandes una a una per veure el resultat detallat de cada operació.

> ⚠️ **Atenció:** l'exercici **14.2 modifica dades** (apuja salaris, elimina camps, etc.). Si vols repetir-lo des d'un estat net, torna a executar `load("01_institut_mongodb.js")`: l'script comença esborrant les col·leccions existents.

---

## 🗄️ Estructura de la base de dades `institut`

Hem adoptat un **disseny d'estil relacional**: una col·lecció per cada entitat, amb les relacions resoltes per **referències** mitjançant `_id`. Aquest enfocament:

- Facilita la **comparació** amb els capítols SQL anteriors (5, 6, 7...).
- Permet practicar `$lookup`, l'equivalent del `JOIN` a MongoDB.
- Mostra que, en MongoDB, el model documental **no obliga** a incrustar-ho tot.

A la secció 14.8 del llibre es discuteix per què, en un projecte real, podríem optar per un disseny més idiomàtic amb documents incrustats.

### Col·leccions

| Col·lecció | Documents | Camps principals |
|---|:-:|---|
| `departament` | 7 | `_id`, `nom_dept`, `edifici` |
| `professor` | 13 | `_id`, `nom`, `cognoms`, `email`, `salari`, `actiu`, `id_dept` |
| `alumne` | 20 | `_id`, `nom`, `cognoms`, `email`, `data_naix`, `curs_inici` |
| `modul` | 20 | `_id`, `codi`, `nom_modul`, `hores`, `curs`, `id_prof` |
| `matricula` | 56 | `id_alumne`, `id_modul`, `nota_final`, `convocatoria` |

### Casos pensats per a pràctiques

- **Dos professors inactius** (Eva Romero i Laia Puig): per filtrar amb `actiu: false`.
- **Un mòdul sense professor** (`id_prof: null` a "Gestió logística"): per practicar `$lookup` amb sense correspondència.
- **Dos alumnes sense matrícula** (Quim Font i Adriana Roca): per practicar el patró de "alumnes sense activitat".
- **Notes `null`** (avaluació pendent) i **múltiples convocatòries** per al mateix mòdul.

---

## 🔑 Equivalències SQL ↔ MongoDB

Una taula ràpida per al lector que ve dels capítols anteriors:

| SQL | MongoDB |
|---|---|
| `SELECT * FROM alumne` | `db.alumne.find()` |
| `SELECT nom FROM alumne` | `db.alumne.find({}, { nom: 1, _id: 0 })` |
| `SELECT * FROM alumne WHERE curs_inici = 2024` | `db.alumne.find({ curs_inici: 2024 })` |
| `SELECT * FROM alumne ORDER BY cognoms DESC` | `db.alumne.find().sort({ cognoms: -1 })` |
| `SELECT * FROM alumne LIMIT 5` | `db.alumne.find().limit(5)` |
| `SELECT COUNT(*) FROM alumne` | `db.alumne.countDocuments()` |
| `INSERT INTO alumne ...` | `db.alumne.insertOne({...})` |
| `UPDATE alumne SET telefon = '...' WHERE _id = 1` | `db.alumne.updateOne({ _id: 1 }, { $set: { telefon: "..." } })` |
| `DELETE FROM alumne WHERE _id = 1` | `db.alumne.deleteOne({ _id: 1 })` |
| `JOIN` | `$lookup` (a `aggregate`) |
| `GROUP BY ... HAVING` | `$group` + `$match` (a `aggregate`) |
| `WHERE col LIKE 'A%'` | `{ col: { $regex: /^A/ } }` |
| `WHERE col IS NULL` | `{ col: null }` o `{ col: { $exists: false } }` |
| `CREATE INDEX` | `db.col.createIndex({...})` |
| `CREATE USER ... WITH PASSWORD ...` | `db.createUser({ user: ..., pwd: ..., roles: [...] })` |

---

## 💡 Bones pràctiques destacades al capítol

- **`use <db>` abans de fer res**: ets a la BD que creus que ets? Comprova-ho amb `db`.
- Aprofita el **tabulador** (`Tab`) de `mongosh` per autocompletar noms de col·leccions i mètodes.
- Mai facis `updateOne(filtre, { camp: valor })` sense `$set`: reemplaçaràs el document sencer.
- **`countDocuments`** és preferible a `count()` (que està obsoleta).
- **`$lookup` no és gratis**: és més car que un `JOIN` indexat de SQL. Si una relació s'accedeix sempre conjunta, pensa a **incrustar**.
- **`explain("executionStats")`** és el teu amic per saber si una consulta està fent servir un índex.
- A **producció**, sempre amb **autenticació activada** (`security.authorization: enabled`) i, idealment, TLS.

---

## 🔗 Referències al llibre

- **Capítol 6** — *Fonaments de SQL*. La versió relacional de la BD `institut`.
- **Capítol 7** — *Agrupacions, JOINs i subconsultes*. Compara amb el framework d'agregació.
- **Capítol 13** — *Control d'accés*. El concepte de mínim privilegi s'aplica idènticament a MongoDB.

---

## 📚 Recursos addicionals

- [Documentació oficial de MongoDB](https://www.mongodb.com/docs/)
- [Documentació de mongosh](https://www.mongodb.com/docs/mongodb-shell/)
- [MongoDB University](https://learn.mongodb.com/) (cursos gratuïts)
- [MongoDB Atlas](https://cloud.mongodb.com/) (entorn al núvol amb capa gratuïta)
