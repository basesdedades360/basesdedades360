-- Exercici resolt 13.2
-- Estructura de rols per a una aplicacio amb tres nivells d'usuari
-- Sintaxi: MySQL / MariaDB 8.0+

USE institut;

-- ============================================================
-- PAS 1 — Crear els tres rols en cadena d'herència
-- ============================================================

-- Nivell base: consulta
CREATE ROLE rol_consultor;
GRANT SELECT ON institut.* TO rol_consultor;

-- Nivell intermedi: gestió de matrícules (hereta consulta)
CREATE ROLE rol_gestor;
GRANT rol_consultor TO rol_gestor;
GRANT INSERT, UPDATE, DELETE ON institut.matricula TO rol_gestor;
GRANT EXECUTE ON FUNCTION  institut.nota_mitjana_alumne TO rol_gestor;
GRANT EXECUTE ON PROCEDURE institut.matricular_alumne   TO rol_gestor;

-- Nivell superior: administració acadèmica (hereta gestió)
CREATE ROLE rol_admin_academic;
GRANT rol_gestor TO rol_admin_academic;
GRANT INSERT, UPDATE, DELETE ON institut.professor   TO rol_admin_academic;
GRANT INSERT, UPDATE, DELETE ON institut.departament TO rol_admin_academic;
GRANT INSERT, UPDATE, DELETE ON institut.modul       TO rol_admin_academic;
GRANT INSERT, UPDATE, DELETE ON institut.alumne      TO rol_admin_academic;

-- --- Bloc següent ---

-- ============================================================
-- PAS 2 — Crear els tres usuaris i assignar els rols
-- ============================================================

CREATE USER 'anna'@'localhost'   IDENTIFIED BY 'Anna2026!';
CREATE USER 'bernat'@'localhost' IDENTIFIED BY 'Bernat2026!';
CREATE USER 'clara'@'localhost'  IDENTIFIED BY 'Clara2026!';

GRANT rol_consultor      TO 'anna'@'localhost';     -- consulta
GRANT rol_gestor         TO 'bernat'@'localhost';   -- gestió
GRANT rol_admin_academic TO 'clara'@'localhost';    -- administració

-- --- Bloc següent ---

-- ============================================================
-- PAS 3 — Activar els rols per defecte
--
-- A diferència de PostgreSQL, els rols MySQL NO s'apliquen
-- automàticament. Cal SET DEFAULT ROLE perquè el rol estigui
-- actiu en cada nova sessió.
-- ============================================================

SET DEFAULT ROLE ALL TO 'anna'@'localhost';
SET DEFAULT ROLE ALL TO 'bernat'@'localhost';
SET DEFAULT ROLE ALL TO 'clara'@'localhost';

-- --- Bloc següent ---

-- ============================================================
-- PAS 4 — Verificar amb SHOW GRANTS
-- ============================================================

-- SHOW GRANTS FOR 'anna'@'localhost';
-- SHOW GRANTS FOR 'anna'@'localhost' USING rol_consultor;
-- SHOW GRANTS FOR 'bernat'@'localhost' USING rol_gestor;
-- SHOW GRANTS FOR 'clara'@'localhost' USING rol_admin_academic;

-- Per veure tots els rols definits al sistema:
-- SELECT * FROM mysql.role_edges;

-- ============================================================
-- NOTA SOBRE TAULES FUTURES
-- ============================================================
-- A MySQL no existeix un equivalent directe a
-- ALTER DEFAULT PRIVILEGES de PostgreSQL. La pràctica
-- habitual és atorgar privilegis sobre 'institut.*' (com hem
-- fet a rol_consultor), de manera que qualsevol taula nova
-- creada dins la BD 'institut' hereta automàticament aquests
-- privilegis. Per als nivells superiors, cal donar els
-- privilegis explícitament a cada taula nova o ampliar el
-- GRANT a 'institut.*'.
