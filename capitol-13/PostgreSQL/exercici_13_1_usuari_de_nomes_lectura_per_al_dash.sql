-- Exercici resolt 13.1
-- Usuari de només lectura per al dashboard del director
-- Sintaxi: PostgreSQL

CREATE OR REPLACE VIEW v_professor_public AS
SELECT id_prof, nom, cognoms, email, telefon, data_alta, actiu, id_dept
FROM   professor;
-- Nota: hem omès salari

-- --- Bloc següent ---

CREATE ROLE rol_dashboard;

-- Accés a l'esquema
GRANT USAGE ON SCHEMA public TO rol_dashboard;

-- SELECT sobre totes les taules excepte professor
GRANT SELECT ON alumne, matricula, modul, departament TO rol_dashboard;

-- I sobre la vista que substitueix professor
GRANT SELECT ON v_professor_public TO rol_dashboard;

-- (No donem accés a la taula professor real)

-- --- Bloc següent ---

CREATE USER director WITH PASSWORD 'Dir2026!';
GRANT rol_dashboard TO director;

-- --- Bloc següent ---

-- Iniciem sessió com a director
\c institut director

-- Comprovacions:
SELECT COUNT(*) FROM alumne;            -- ✅ funciona
SELECT * FROM v_professor_public LIMIT 5;  -- ✅ funciona, no veu salari
SELECT salari FROM professor LIMIT 1;   -- ❌ ERROR: permission denied
INSERT INTO alumne (...) VALUES (...);  -- ❌ ERROR: permission denied
DELETE FROM matricula;                  -- ❌ ERROR: permission denied
