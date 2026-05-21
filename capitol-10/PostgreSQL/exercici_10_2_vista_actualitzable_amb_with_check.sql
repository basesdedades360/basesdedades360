-- Exercici resolt 10.2
-- Vista actualitzable amb `WITH CHECK OPTION`
-- Sintaxi: PostgreSQL

CREATE OR REPLACE VIEW v_profs_dept_informatica AS
SELECT id_prof, nom, cognoms, email, telefon, salari,
       data_alta, actiu, id_dept
FROM   professor
WHERE  id_dept = 1
WITH CHECK OPTION;

-- --- Bloc següent ---

INSERT INTO v_profs_dept_informatica
       (nom, cognoms, email, salari, id_dept)
VALUES ('Marc',   'Vila',  'marc.vila@institut.cat',  2800, 1);
-- ✅ Inserit correctament. Apareix a la vista i a la taula professor.

-- --- Bloc següent ---

INSERT INTO v_profs_dept_informatica
       (nom, cognoms, email, salari, id_dept)
VALUES ('Júlia', 'Pons',  'julia.pons@institut.cat', 2750, 2);

-- --- Bloc següent ---

UPDATE v_profs_dept_informatica
SET    id_dept = 3
WHERE  id_prof = 5;
-- ❌ ERROR: CHECK OPTION failed

-- --- Bloc següent ---

CREATE OR REPLACE VIEW v_profs_actius_informatica AS
SELECT *
FROM   v_profs_dept_informatica
WHERE  actiu = TRUE
WITH CASCADED CHECK OPTION;

-- --- Bloc següent ---

-- Inserció que viola el filtre PROPI (actiu = FALSE):
INSERT INTO v_profs_actius_informatica
       (nom, cognoms, email, salari, actiu, id_dept)
VALUES ('Pere', 'Solé', 'pere.sole@institut.cat', 2900, FALSE, 1);
-- ❌ ERROR: CHECK OPTION failed (actiu = FALSE no compleix el filtre actiu = TRUE)

-- Inserció que viola el filtre del PARE (id_dept = 2):
INSERT INTO v_profs_actius_informatica
       (nom, cognoms, email, salari, actiu, id_dept)
VALUES ('Anna', 'Mas',  'anna.mas@institut.cat',  3000, TRUE, 2);
-- ❌ ERROR: CHECK OPTION failed (id_dept = 2 viola el filtre de la vista pare)
