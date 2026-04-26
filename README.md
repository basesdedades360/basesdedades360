# Bases de Dades 360

> *De zero a la consulta avançada — amb MySQL/MariaDB i PostgreSQL en paral·lel.*

[![Llicència: CC BY-SA 4.0](https://img.shields.io/badge/Llic%C3%A8ncia-CC%20BY--SA%204.0-lightgrey.svg)](./LICENSE)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![MariaDB](https://img.shields.io/badge/MariaDB-10.5+-003545?logo=mariadb&logoColor=white)](https://mariadb.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
![Idioma: català](https://img.shields.io/badge/idioma-catal%C3%A0-FFCD00)

Aquest repositori conté els **scripts SQL, exercicis resolts i recursos complementaris** del llibre *Bases de Dades 360*, una introducció pràctica a les bases de dades relacionals en què cada tema es presenta en paral·lel per als dos SGBD més utilitzats del programari lliure: **MySQL/MariaDB** i **PostgreSQL**.

---

## 📑 Sobre el llibre

*Bases de Dades 360* és un llibre adreçat a estudiants de cicles formatius i a qualsevol persona que vulgui aprendre bases de dades des de zero. La seva característica distintiva és que **cada exemple, cada exercici i cada explicació es presenta en les dues sintaxis** (MySQL/MariaDB i PostgreSQL), de manera que el lector adquireix competència real i no queda lligat a un únic sistema.

Continguts dels blocs:

- **Bloc I — Fonaments:** model relacional, normalització i disseny lògic.
- **Bloc II — Disseny físic:** tipus de dades, restriccions, índexs i evolució d'esquemes.
- **Bloc III — SQL pràctic:** DML, funcions, agregació, `JOIN`s, subconsultes, vistes.
- **Bloc IV — Bases de dades en producció:** transaccions, usuaris i permisos, *backup* i restauració.

---

## 📂 Estructura del repositori

```
basesdedades360/
├── README.md                  ← aquest fitxer
├── LICENSE
├── .gitignore
├── capitol-05/                (en preparació)
├── capitol-06/                ← scripts del capítol 6
│   ├── README.md
│   ├── institut_mysql.sql
│   └── institut_postgresql.sql
└── capitol-07/                (en preparació)
```

| Capítol | Tema | Carpeta |
|---|---|---|
| 5 | Disseny físic i tipus de dades | _pendent_ |
| 6 | Fonaments de SQL: DML i funcions integrades | [`capitol-06/`](./capitol-06/) |
| 7 | `JOIN`s i subconsultes | _pendent_ |

---

## 🚀 Com usar els scripts

Cada capítol conté un parell de fitxers SQL paral·lels (un per a MySQL/MariaDB i un altre per a PostgreSQL). Pots executar-los de tres maneres:

### Opció 1 — Online (sense instal·lar res)

La manera més ràpida de provar els scripts és amb un *playground* en línia. La més recomanada per al llibre és **DB Fiddle**:

- [DB Fiddle (MySQL 8.0)](https://www.db-fiddle.com/?rdbms=mysql_8.0)
- [DB Fiddle (PostgreSQL 15)](https://www.db-fiddle.com/?rdbms=postgres_15)

Copia el contingut del fitxer `.sql` corresponent al panell esquerre i prem **Run**.

### Opció 2 — Localment amb el client de línia d'ordres

```bash
# MySQL / MariaDB
mysql -u root -p < capitol-06/institut_mysql.sql

# PostgreSQL
psql -U postgres -f capitol-06/institut_postgresql.sql
```

### Opció 3 — Amb una eina gràfica

Obre el fitxer `.sql` amb el teu client habitual (DBeaver, MySQL Workbench, pgAdmin, HeidiSQL, TablePlus...) i executa l'script complet.

---

## 🛠️ Requisits

| Requisit | Versió mínima recomanada |
|---|---|
| MySQL | 8.0 (per a `CHECK` natiu i `JSON`) |
| MariaDB | 10.5 |
| PostgreSQL | 13 (la 15 o superior preferida) |

Els scripts utilitzen característiques modernes (`GENERATED ALWAYS AS IDENTITY` a PostgreSQL, `CHECK` aplicat realment a MySQL 8.0+...). En versions anteriors poden necessitar petits ajustos.

---

## 🤝 Com contribuir

Aquest repositori és principalment un complement al llibre, però són benvingudes:

- **Correccions de bugs** als scripts (obre una *issue* o un *pull request*).
- **Errates** detectades al text del llibre, indicant capítol i pàgina.
- **Traduccions** dels scripts a altres llengües (cal mantenir la versió original en català).

---

## 📜 Llicència

Aquest repositori es distribueix sota la llicència **[Creative Commons Reconeixement-CompartirIgual 4.0 Internacional (CC BY-SA 4.0)](./LICENSE)**.

Pots **copiar, redistribuir, transformar i fer-ne ús**, fins i tot comercialment, amb dues condicions:

1. **Reconeixement:** has de citar l'autor i indicar la font (aquest repositori).
2. **CompartirIgual:** si transformes el material, has de distribuir el resultat amb la mateixa llicència que l'original.

---

## 👤 Autor

**Jordi Quesada** — [`jordi.quesada@proton.me`](mailto:jordi.quesada@proton.me)

GitHub: [@basesdedades360](https://github.com/basesdedades360/) · Repositori: [`basesdedades360`](https://github.com/basesdedades360/basededades360/)

> Si aquest material t'ha sigut útil, considera deixar una ⭐ al repositori. Ajuda a fer-lo visible a altres estudiants i docents.
