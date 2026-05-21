-- Exercici resolt 13.3
-- Configurar l'accés a la xarxa per a un servidor d'aplicació
-- Sintaxi: MySQL / MariaDB
--
-- A diferència de PostgreSQL (que controla la xarxa amb un fitxer
-- pg_hba.conf separat), MySQL integra la informació de xarxa
-- directament dins de la identitat de l'usuari amb la parella
-- 'usuari'@'host'. Aquesta és la principal diferència entre
-- les dues plataformes.
--
-- INFRAESTRUCTURA SUPOSADA:
--   - Servidor de BD a la IP 10.0.0.5
--   - Servidor d'aplicacions a la IP 10.0.0.10 (compte 'app_web')
--   - Estacions de la secretaria al rang 10.0.1.0/24 (comptes 'secretari_*')
--   - Accés administratiu només des del propi servidor de BD

-- ============================================================
-- PAS 1 — Configurar el servidor perquè accepti connexions
-- de xarxa (i no només per socket local)
-- ============================================================
-- Al fitxer /etc/mysql/my.cnf (o el seu equivalent):
--
--   [mysqld]
--   bind-address = 0.0.0.0    # o llistat d'IPs concretes
--
-- Després cal reiniciar el servei: systemctl restart mysql

-- --- Bloc següent ---

-- ============================================================
-- PAS 2 — Administrador 'root' restringit a connexions locals
-- ============================================================
-- Per defecte, 'root'@'localhost' ja existeix només per a connexions
-- per socket. Verifiquem que NO existeix una versió oberta:

SELECT user, host FROM mysql.user WHERE user = 'root';

-- Si hi hagués 'root'@'%' o 'root'@'IP-no-segura', eliminar-los:
-- DROP USER IF EXISTS 'root'@'%';

-- --- Bloc següent ---

-- ============================================================
-- PAS 3 — Aplicació web: només des de la seva IP
-- ============================================================

CREATE USER 'app_web'@'10.0.0.10'
    IDENTIFIED BY 'AppPwd2026!'
    REQUIRE SSL;

-- Privilegis acotats al que necessita l'aplicació
GRANT SELECT, INSERT, UPDATE, DELETE
    ON institut.matricula TO 'app_web'@'10.0.0.10';

GRANT SELECT
    ON institut.alumne TO 'app_web'@'10.0.0.10';

GRANT SELECT
    ON institut.modul TO 'app_web'@'10.0.0.10';

GRANT EXECUTE ON PROCEDURE institut.matricular_alumne
    TO 'app_web'@'10.0.0.10';

-- --- Bloc següent ---

-- ============================================================
-- PAS 4 — Secretaria: només des del seu rang d'IPs
-- ============================================================
-- MySQL permet comodins amb '%' i, en versions modernes,
-- notació CIDR per a rangs sencers.

CREATE ROLE rol_secretaria;
GRANT SELECT, INSERT, UPDATE ON institut.alumne    TO rol_secretaria;
GRANT SELECT, INSERT, UPDATE ON institut.matricula TO rol_secretaria;
GRANT SELECT                ON institut.modul      TO rol_secretaria;

-- Comptes individuals de cada secretari, amb host limitat al rang
CREATE USER 'secretari_1'@'10.0.1.%' IDENTIFIED BY 'Sec1_2026!' REQUIRE SSL;
CREATE USER 'secretari_2'@'10.0.1.%' IDENTIFIED BY 'Sec2_2026!' REQUIRE SSL;

GRANT rol_secretaria TO 'secretari_1'@'10.0.1.%';
GRANT rol_secretaria TO 'secretari_2'@'10.0.1.%';

SET DEFAULT ROLE rol_secretaria TO 'secretari_1'@'10.0.1.%';
SET DEFAULT ROLE rol_secretaria TO 'secretari_2'@'10.0.1.%';

-- --- Bloc següent ---

-- ============================================================
-- PAS 5 — Aplicar els canvis
-- ============================================================
-- A MySQL, els canvis fets amb CREATE USER, GRANT, REVOKE i DROP
-- USER s'apliquen immediatament. No cal "recarregar" cap fitxer.
-- (Només si s'ha modificat directament la taula mysql.user amb
-- INSERT/UPDATE, cosa molt desaconsellada, cal fer:)
FLUSH PRIVILEGES;

-- --- Bloc següent ---

-- ============================================================
-- PAS 6 — Verificacions
-- ============================================================

-- Veure totes les identitats actuals i des d'on poden connectar:
SELECT user, host FROM mysql.user
WHERE user IN ('app_web', 'secretari_1', 'secretari_2', 'director')
ORDER BY user, host;

-- Provar des de l'exterior:
-- Des del servidor d'aplicacions (10.0.0.10):
-- mysql -u app_web -h 10.0.0.5 -p institut       -- OK
--
-- Des d'una estació de secretaria (10.0.1.50):
-- mysql -u secretari_1 -h 10.0.0.5 -p institut   -- OK
-- mysql -u app_web -h 10.0.0.5 -p institut       -- ERROR 1045: rebutjat
--                                                    (app_web només des de 10.0.0.10)
--
-- Des d'una IP qualsevol externa:
-- mysql -u app_web -h 10.0.0.5 -p                -- ERROR 1045: rebutjat

-- ============================================================
-- DIFERÈNCIES CLAU AMB POSTGRESQL
-- ============================================================
-- * PostgreSQL: la xarxa es controla a pg_hba.conf, un fitxer
--   independent de la BD. Cal pg_reload_conf() per aplicar canvis.
-- * MySQL: la xarxa forma part de la IDENTITAT de l'usuari
--   ('user'@'host'). Cada combinació és un compte diferent amb
--   els seus propis privilegis i contrasenya. Els canvis amb
--   GRANT/REVOKE són immediats.
