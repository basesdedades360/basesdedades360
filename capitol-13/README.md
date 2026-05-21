# Capítol 13 — Control d'accés a la base de dades

Aquesta carpeta conté els exercicis resolts del capítol 13 del llibre *Bases de Dades 360*. El capítol cobreix la gestió d'usuaris i rols, l'autenticació (incloent `pg_hba.conf` de PostgreSQL i la parella `usuari@host` de MySQL), els tipus de privilegis (`SELECT`, `INSERT`, `UPDATE`, `DELETE`, `EXECUTE`, administratius) i les sentències `GRANT` i `REVOKE`.

Els tres exercicis es presenten **en paral·lel per a MySQL/MariaDB i PostgreSQL**.

---

## 📂 Fitxers

```
capitol-13/
├── README.md
├── MySQL/
│   ├── exercici_13_1_usuari_de_nomes_lectura_per_al_dash.sql
│   ├── exercici_13_2_estructura_de_rols_per_a_una_aplica.sql
│   └── exercici_13_3_configurar_acces_xarxa_per_a_un_ser.sql
└── PostgreSQL/
    ├── exercici_13_1_usuari_de_nomes_lectura_per_al_dash.sql
    ├── exercici_13_2_estructura_de_rols_per_a_una_aplica.sql
    └── exercici_13_3_configurar_pg_hba_conf_per_a_un_ser.sql
```

| Exercici | Tema | Notes |
|---|---|---|
| **13.1** | Usuari de només lectura per al dashboard del director | Inclou una vista per amagar la columna `salari` i un rol per al perfil de consulta. |
| **13.2** | Estructura de rols per a una aplicació amb tres nivells d'usuari | Patró típic d'herència: `rol_consultor` → `rol_gestor` → `rol_admin_academic`. |
| **13.3** | Configurar l'accés des de la xarxa per a un servidor d'aplicació | A MySQL es fa amb la parella `usuari@host` integrada a la identitat; a PostgreSQL, amb el fitxer `pg_hba.conf`. |

> ℹ️ **Diferències entre les dues versions.** Els tres exercicis estan plantejats amb la mateixa estructura conceptual als dos motors, però la sintaxi i, sobretot, el model d'autenticació de xarxa són diferents. L'exercici 13.3 és el que més canvia: PostgreSQL ho fa per fitxer, MySQL ho fa per usuari amb host.

---

## 🔑 Diferències MySQL ↔ PostgreSQL en control d'accés

| Concepte | MySQL/MariaDB | PostgreSQL |
|---|---|---|
| Crear usuari | `CREATE USER 'app'@'host' IDENTIFIED BY '...'` | `CREATE USER app WITH PASSWORD '...'` |
| Crear rol | `CREATE ROLE rol_xxx;` (8.0+) | `CREATE ROLE rol_xxx;` |
| Assignar rol | `GRANT rol_xxx TO 'app'@'host';` + `SET DEFAULT ROLE` | `GRANT rol_xxx TO app;` (herència automàtica) |
| Activació de rols | Manual: `SET DEFAULT ROLE` o `SET ROLE` | Automàtica en iniciar sessió |
| `usuari@host` | Sí — la xarxa forma part de la identitat | No — es controla a `pg_hba.conf` |
| Configuració d'accés | Taules `mysql.user`, `mysql.db` | Fitxer `pg_hba.conf` |
| Concedir tot d'una BD | `GRANT ALL ON db.* TO ...` | `GRANT ALL ON ALL TABLES IN SCHEMA public TO ...` |
| Taules futures | Implícit amb `db.*` | `ALTER DEFAULT PRIVILEGES ...` |
| Recarregar permisos | `FLUSH PRIVILEGES;` (només per a canvis directes a `mysql.user`) | Automàtic |
| Recarregar config. xarxa | (no aplicable) | `SELECT pg_reload_conf();` |
| Veure usuaris | `SELECT user, host FROM mysql.user;` | `\du` o `SELECT * FROM pg_roles;` |
| Veure privilegis | `SHOW GRANTS FOR ...` | `\dp` o `\du` |

---

## 🗄️ Base de dades necessària

Els exercicis treballen sobre la base de dades `institut` del **capítol 6**:

- MySQL: `capitol-06/MySQL/01_institut_mysql.sql` + `02_institut_inserts_mysql.sql`
- PostgreSQL: `capitol-06/PostgreSQL/01_institut_postgresql.sql` + `02_institut_inserts_postgresql.sql`

A més, l'exercici 13.2 cita els procediments `nota_mitjana_alumne` i `matricular_alumne` del **capítol 11** (MySQL) o **capítol 12** (PostgreSQL).

---

## 🚀 Com executar

### MySQL / MariaDB

```bash
# Cal connectar-se com un usuari amb privilegis administratius (root)
mysql -u root -p institut

# Dins de la sessió:
source MySQL/exercici_13_1_usuari_de_nomes_lectura_per_al_dash.sql;
```

### PostgreSQL

```bash
# Cal connectar-se com a postgres
psql -U postgres -d institut

# Dins de la sessió:
\i PostgreSQL/exercici_13_1_usuari_de_nomes_lectura_per_al_dash.sql
```

> ⚠️ L'**exercici 13.3** té diferències importants segons el motor:
> - **MySQL**: les comandes `CREATE USER` amb host restrictiu (`'app_web'@'10.0.0.10'`) s'apliquen immediatament. Cal, això sí, configurar `bind-address` al fitxer `/etc/mysql/my.cnf` perquè el servidor accepti connexions de xarxa.
> - **PostgreSQL**: el fitxer `pg_hba.conf` s'ha d'editar manualment al servidor i recarregar amb `SELECT pg_reload_conf();`. L'script mostra com hauria de quedar.

---

## 🛡️ Bones pràctiques que apareixen als scripts

- **Principi de mínim privilegi**: cada rol/usuari té només els permisos estrictament necessaris.
- **Vistes per amagar columnes sensibles**: en lloc de donar `SELECT (col1, col2, ...) ON taula`, és més net crear una vista i donar `SELECT` sobre la vista.
- **Capes separades**: rols per a aplicació, rols per a humans (dashboards, suport, administradors).
- **Mai cap usuari d'aplicació amb privilegis administratius**: si l'aplicació es veu compromesa, el dany ha de ser limitat.
- **Host explícit als usuaris MySQL**: mai `'usuari'@'%'` sense una raó molt concreta. Posa la IP o el rang d'IPs reals.
- **TLS/SSL obligatori per a connexions de xarxa**: `REQUIRE SSL` a MySQL, mètode `scram-sha-256` a `pg_hba.conf`.

---

## 🔗 Referències al llibre

- **Capítol 6** — *Fonaments de SQL*. Base de dades `institut`.
- **Capítol 10** — *Vistes i diccionari*. Les vistes són una eina central del control d'accés.
- **Capítol 11** — *Programació al SGBD (MySQL/MariaDB)*. Privilegi `EXECUTE` sobre funcions i procediments.
- **Capítol 12** — *Programació al SGBD (PL/pgSQL)*. Versió PostgreSQL.

[← Tornar al README principal](../README.md)
