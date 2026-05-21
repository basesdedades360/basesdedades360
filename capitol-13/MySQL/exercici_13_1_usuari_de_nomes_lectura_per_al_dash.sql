-- Exercici resolt 13.1
-- Usuari de només lectura per al dashboard del director
-- Sintaxi: MySQL / MariaDB 8.0+

USE institut;

-- ============================================================
-- PAS 1 — Vista que amaga el salari
-- ============================================================

CREATE OR REPLACE VIEW v_professor_public AS
SELECT id_prof, nom, cognoms, email, telefon, data_alta, actiu, id_dept
FROM   professor;
-- Nota: hem omès 'salari'

-- --- Bloc següent ---

-- ============================================================
-- PAS 2 — Crear el rol de només lectura (MySQL 8.0+)
-- ============================================================

CREATE ROLE rol_dashboard;

-- SELECT sobre totes les taules excepte la taula 'professor'
GRANT SELECT ON institut.alumne      TO rol_dashboard;
GRANT SELECT ON institut.matricula   TO rol_dashboard;
GRANT SELECT ON institut.modul       TO rol_dashboard;
GRANT SELECT ON institut.departament TO rol_dashboard;

-- I sobre la vista que substitueix professor
GRANT SELECT ON institut.v_professor_public TO rol_dashboard;

-- (No donem accés a la taula 'professor' real)

-- --- Bloc següent ---

-- ============================================================
-- PAS 3 — Crear l'usuari del director i assignar-li el rol
-- ============================================================

CREATE USER 'director'@'localhost' IDENTIFIED BY 'Dir2026!';

-- Concedim el rol
GRANT rol_dashboard TO 'director'@'localhost';

-- IMPORTANT: a MySQL els rols no s'activen automàticament en iniciar sessió.
-- Cal indicar que aquest rol sigui actiu per defecte:
SET DEFAULT ROLE rol_dashboard TO 'director'@'localhost';

-- --- Bloc següent ---

-- ============================================================
-- PAS 4 — Verificar (iniciem una nova sessió com a director)
-- ============================================================

-- mysql -u director -p institut

-- Comprovacions:
-- SELECT COUNT(*) FROM alumne;             -- OK
-- SELECT * FROM v_professor_public LIMIT 5; -- OK, no veu salari
-- SELECT salari FROM professor LIMIT 1;    -- ERROR 1142: SELECT denegat
-- INSERT INTO alumne (...) VALUES (...);   -- ERROR: INSERT denegat
-- DELETE FROM matricula;                   -- ERROR: DELETE denegat

-- Per veure els privilegis efectius del director:
-- SHOW GRANTS FOR 'director'@'localhost';
-- SHOW GRANTS FOR 'director'@'localhost' USING rol_dashboard;
