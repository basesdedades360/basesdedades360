# Bases de Dades 360

> *Del disseny al NoSQL — exercicis resolts en MySQL/MariaDB, PostgreSQL i MongoDB.*

[![Llicència: CC BY-SA 4.0](https://img.shields.io/badge/Llic%C3%A8ncia-CC%20BY--SA%204.0-lightgrey.svg)](./LICENSE)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![MariaDB](https://img.shields.io/badge/MariaDB-10.5+-003545?logo=mariadb&logoColor=white)](https://mariadb.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-7.0+-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com/)
![Idioma: català](https://img.shields.io/badge/idioma-catal%C3%A0-FFCD00)

Aquest repositori conté els **scripts SQL, scripts MongoDB, exercicis resolts i recursos complementaris** del llibre *Bases de Dades 360*. La característica distintiva del llibre — i d'aquest repositori — és que **cada exercici es presenta en paral·lel** per als dos SGBD relacionals més utilitzats del programari lliure (**MySQL/MariaDB** i **PostgreSQL**), i el capítol final introdueix també **MongoDB** com a referent del món NoSQL documental.

---

## 📑 Sobre el llibre

*Bases de Dades 360* és un llibre adreçat a estudiants de cicles formatius i a qualsevol persona que vulgui aprendre bases de dades des de zero. Cobreix tot el cicle de vida d'una base de dades: disseny conceptual i lògic, normalització, SQL fonamental i avançat, optimització, transaccions, seguretat i una panoràmica del món NoSQL.


---

## 📂 Estructura del repositori

```
basesdedades360/
├── README.md                  ← aquest fitxer
├── LICENSE                    ← CC BY-SA 4.0
├── .gitignore
├── capitol-05/                ← Disseny físic i tipus de dades
│   ├── README.md
│   ├── MySQL/
│   └── PostgreSQL/
├── capitol-06/                ← Fonaments de SQL: DDL i DML
│   ├── README.md
│   ├── MySQL/                 (esquema + dades + exercicis)
│   └── PostgreSQL/
├── capitol-07/                ← Agrupacions, JOINs i subconsultes
├── capitol-08/                ← Optimització de consultes
├── capitol-09/                ← Transaccions i concurrència
├── capitol-10/                ← Vistes i diccionari de dades
├── capitol-11/                ← Programació al SGBD (MySQL/MariaDB)
│   └── MySQL/                 (capítol exclusivament MySQL/MariaDB)
├── capitol-12/                ← Programació al SGBD (PL/pgSQL)
│   └── PostgreSQL/            (capítol exclusivament PostgreSQL)
├── capitol-13/                ← Control d'accés
└── capitol-14/                ← Bases de dades no relacionals (MongoDB)
    ├── README.md
    └── MongoDB/               (capítol exclusivament MongoDB)
```

> ℹ️ Els **capítols 11 i 12** són dues versions del mateix tema (*Programació al SGBD*): el 11 amb MySQL/MariaDB i el 12 amb PostgreSQL (PL/pgSQL). Cada lector pot fer servir el que correspongui al seu motor.

---

## 🎯 Presentació del llibre

*Bases de Dades 360* és una introducció pràctica i actualitzada al món de les bases de dades, pensada per a estudiants i professionals que volen una visió completa des del disseny relacional fins a aplicacions NoSQL. El llibre inclou exercicis resolts i exemples paral·lels en MySQL/MariaDB, PostgreSQL i MongoDB per facilitar l'aprenentatge comparatiu.

Compra o descarrega el llibre i troba materials addicionals a:

- Pàgina del llibre i recursos: [Jordi Quesada Balaguer — Bases de dades 360°](https://jordiquesada.github.io/)
- Còpia del codi i descàrrega: [https://github.com/basesdedades360/basesdedades360](https://github.com/basesdedades360/basesdedades360)

---

## 🌐 Estructura de la pàgina web

La pàgina web del llibre està organitzada per seccions que faciliten l'accés al contingut, recursos i compra/descàrrega:

- Inici: presentació i enllaços principals (compra, descàrrega, repositori).
- Contingut: informació del llibre i índex de capítols amb enllaços a repositoris i recursos.
- Recursos: exemples, fitxers addicionals i materials complementaris per a docents i estudiants.
- Contacte: informació de l'autor i enllaços a xarxes / correu electrònic.

Consulta la pàgina per a més detalls: [Jordi Quesada Balaguer — Bases de dades 360°](https://jordiquesada.github.io/)

---

## 🗄️ Base de dades de referència: `institut`

La majoria dels exercicis a partir del capítol 6 treballen sobre una base de dades de gestió acadèmica anomenada **`institut`**, amb diferents taules.


Per executar qualsevol exercici dels capítols 7 endavant, cal haver carregat prèviament:

1. `capitol-06/<SGBD>/01_institut_<sgbd>.sql` (esquema)
2. `capitol-06/<SGBD>/02_institut_inserts_<sgbd>.sql` (dades de prova)

> 📌 Al **capítol 14** hi ha una versió MongoDB de la mateixa base de dades a `capitol-14/MongoDB/01_institut_mongodb.js`. Manté els mateixos identificadors per facilitar la comparació amb la versió SQL.

---

## 🛠️ Requisits

| Requisit | Versió mínima recomanada |
|---|---|
| MySQL | 8.0 (per a `CHECK` natiu, `JSON` i finestres) |
| MariaDB | 10.5 |
| PostgreSQL | 13 (recomanada 15 o superior) |
| MongoDB | 6.0 (recomanada 7.0 o superior) |
| mongosh | 1.10 |

Els scripts SQL utilitzen característiques modernes (`GENERATED ALWAYS AS IDENTITY`, `CHECK` natiu, funcions de finestra...). En versions anteriors poden necessitar petits ajustos.

---

## 🤝 Com contribuir

Aquest repositori és principalment un complement al llibre. Són benvingudes:

- **Correccions de bugs** als scripts (obre una *issue* o un *pull request*).
- **Errates** detectades al text del llibre, indicant capítol i pàgina.
- **Versions alternatives en MongoDB** del capítol 14 amb un disseny idiomàtic (documents incrustats).

---

## 📜 Llicència

Aquest repositori es distribueix sota la llicència **[Creative Commons Reconeixement-CompartirIgual 4.0 Internacional (CC BY-SA 4.0)](./LICENSE)**.

Pots **copiar, redistribuir, transformar i fer-ne ús**, fins i tot comercialment, amb dues condicions:

1. **Reconeixement:** has de citar l'autor i indicar la font (aquest repositori).
2. **CompartirIgual:** si transformes el material, has de distribuir el resultat amb la mateixa llicència que l'original.

---

## 👤 Autor

**Jordi Quesada** — [`jordi.quesada@proton.me`](mailto:jordi.quesada@proton.me)

GitHub: [@basesdedades360](https://github.com/basesdedades360/) · Repositori: [https://github.com/basesdedades360/basesdedades360](https://github.com/basesdedades360/basesdedades360)

> Si aquest material t'ha sigut útil, considera deixar una ⭐ al repositori. Ajuda a fer-lo visible a altres estudiants i docents.
