-- Exercici resolt 13.2
-- Estructura de rols per a una aplicació amb tres nivells d'usuari
-- Sintaxi: PostgreSQL

-- Nivell base: consulta
CREATE ROLE rol_consultor;
GRANT USAGE ON SCHEMA public TO rol_consultor;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO rol_consultor;

-- Nivell intermedi: gestió de matrícules (hereta consulta)
CREATE ROLE rol_gestor;
GRANT rol_consultor TO rol_gestor;
GRANT INSERT, UPDATE, DELETE ON matricula TO rol_gestor;
GRANT EXECUTE ON FUNCTION nota_mitjana_alumne(INT) TO rol_gestor;
GRANT EXECUTE ON PROCEDURE matricular_alumne(INT, SMALLINT, SMALLINT) TO rol_gestor;

-- Nivell superior: administració acadèmica (hereta gestió)
CREATE ROLE rol_admin_academic;
GRANT rol_gestor TO rol_admin_academic;
GRANT INSERT, UPDATE, DELETE ON professor, departament, modul, alumne TO rol_admin_academic;

-- --- Bloc següent ---

-- Si l'admin crea una taula nova, ja serà accessible automàticament:
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO rol_consultor;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT INSERT, UPDATE, DELETE ON TABLES TO rol_admin_academic;

-- --- Bloc següent ---

CREATE USER anna   WITH PASSWORD 'Anna2026!';
CREATE USER bernat WITH PASSWORD 'Bernat2026!';
CREATE USER clara  WITH PASSWORD 'Clara2026!';

GRANT rol_consultor      TO anna;     -- consulta
GRANT rol_gestor         TO bernat;   -- gestió
GRANT rol_admin_academic TO clara;    -- administració
