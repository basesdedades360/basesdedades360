# Bases de Dades 360°: Del disseny al NoSQL

> *Teoria, exemples i exercicis resolts en MySQL/MariaDB, PostgreSQL i MongoDB.*

[![Llicència: CC BY-SA 4.0](https://img.shields.io/badge/Llic%C3%A8ncia-CC%20BY--SA%204.0-lightgrey.svg)](./LICENSE)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![MariaDB](https://img.shields.io/badge/MariaDB-10.5+-003545?logo=mariadb&logoColor=white)](https://mariadb.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-7.0+-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com/)
![Idioma: català](https://img.shields.io/badge/idioma-catal%C3%A0-FFCD00)

<p align="center">
  <a href="https://www.bubok.es/libros/286477/bases-de-dades-360-del-disseny-al-nosql" target="_blank" rel="noopener noreferrer">
    <img src="./portada.png" alt="Portada de Bases de Dades 360°" width="320" />
  </a>
</p>

*Bases de Dades 360°* és una introducció pràctica i actualitzada al món de les bases de dades, pensada per a estudiants i professionals que volen una visió completa des del disseny relacional fins a aplicacions NoSQL. El llibre inclou exercicis resolts i exemples paral·lels en MySQL/MariaDB, PostgreSQL i MongoDB per facilitar l'aprenentatge comparatiu.

La descàrrega del llibre és gratuïta, i el llibre en paper està disponible a preu de cost a:

- [Comprar o descarregar el llibre](https://www.bubok.es/libros/286477/bases-de-dades-360-del-disseny-al-nosql)
- [Repositori del projecte](https://github.com/basesdedades360/basesdedades360)

> 📌 El contingut digital és gratuït; el format en paper es pot adquirir a preu de cost.


---

## 🗄️ El repositori

Aquest repositori conté els scripts SQL, MongoDB, exercicis resolts i recursos complementaris del llibre *Bases de dades 360°: Del disseny al NoSQL*. Una característica distintiva del llibre és que cada exercici es presenta en paral·lel per als dos SGBD relacionals més utilitzats del programari lliure (**MySQL/MariaDB** i **PostgreSQL**), i el capítol final introdueix també **MongoDB** com a referent del món NoSQL documental.


---

## 📚 Índex de capítols

| Capítol | Tema | Carpeta | MySQL | PostgreSQL | MongoDB |
|---|---|---|:-:|:-:|:-:|
| 5 | Disseny físic i tipus de dades | [`capitol-05/`](./capitol-05/) | ✅ | ✅ | – |
| 6 | Fonaments de SQL: DDL i DML | [`capitol-06/`](./capitol-06/) | ✅ | ✅ | – |
| 7 | Agrupacions, JOINs i subconsultes | [`capitol-07/`](./capitol-07/) | ✅ | ✅ | – |
| 8 | Optimització de consultes | [`capitol-08/`](./capitol-08/) | ✅ | ✅ | – |
| 9 | Transaccions i concurrència | [`capitol-09/`](./capitol-09/) | ✅ | ✅ | – |
| 10 | Vistes i diccionari de dades | [`capitol-10/`](./capitol-10/) | ✅ | ✅ | – |
| 11 | Programació al SGBD (MySQL/MariaDB) | [`capitol-11/`](./capitol-11/) | ✅ | – | – |
| 12 | Programació al SGBD (PL/pgSQL) | [`capitol-12/`](./capitol-12/) | – | ✅ | – |
| 13 | Control d'accés | [`capitol-13/`](./capitol-13/) | ✅ | ✅ | – |
| 14 | Bases de dades no relacionals (MongoDB) | [`capitol-14/`](./capitol-14/) | – | – | ✅ |

> Llegenda: ✅ exercicis complets · – no aplicable al SGBD

> ℹ️ Els **capítols 11 i 12** són dues versions del mateix tema (*Programació al SGBD*): el 11 amb MySQL/MariaDB i el 12 amb PostgreSQL (PL/pgSQL). Cada lector pot fer servir el que correspongui al seu motor.

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
