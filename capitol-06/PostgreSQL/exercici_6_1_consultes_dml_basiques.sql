-- Exercici resolt 6.1
-- Consultes DML bàsiques
-- Sintaxi: PostgreSQL


-- 1
INSERT INTO departament (nom_dept, edifici) VALUES
  ('Informàtica',   'Edifici A'),
  ('Administració', 'Edifici B'),
  ('Sanitat',       'Edifici C');

-- 2 
INSERT INTO professor (nom, cognoms, email, salari, id_dept) VALUES
  ('Anna', 'Vidal',  'anna.vidal@escola.cat',  2800.00, 1),
  ('Marc', 'Torres', 'marc.torres@escola.cat', 3100.00, 1);

-- 3 
SELECT
  CONCAT(nom, ' ', cognoms) AS nom_complet,
  salari                    AS salari_anual,
  ROUND(salari / 12, 2)     AS salari_mensual
FROM professor
WHERE actiu = TRUE
ORDER BY salari DESC;

-- 4
UPDATE professor
SET    salari = ROUND(salari * 1.05, 2)
WHERE  id_dept = 1;

-- 5 
SELECT
  nom || ' ' || cognoms AS nom_complet,
  email,
  ROUND(salari / 12, 2)     AS salari_mensual
FROM professor
ORDER BY salari DESC
LIMIT 3;


