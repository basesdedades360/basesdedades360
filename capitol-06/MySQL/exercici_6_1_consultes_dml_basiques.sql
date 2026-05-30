-- Exercici resolt 6.1
-- Consultes DML bàsiques
-- Sintaxi: MySQL / MariaDB

-- 1 
INSERT INTO departament (nom_dept, edifici) VALUES
    ('Informàtica',  'Edifici A'),
    ('Administració','Edifici B'),
    ('Sanitat',      'Edifici C');

-- 2
INSERT INTO professor (nom, cognoms, email, salari, id_dept) VALUES
    ('Anna', 'Vidal',  'anna.vidal@escola.cat',  2800.00, 1),
    ('Marc', 'Torres', 'marc.torres@escola.cat', 3100.00, 1);

-- 3
SELECT
    CONCAT(nom, ' ', cognoms) AS nom_complet,    -- a PG funciona també nom || ' ' || cognoms
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
    id_dept,
    COUNT(*)               AS num_professors,
    ROUND(AVG(salari), 2)  AS salari_mitja
FROM   professor
GROUP BY id_dept
HAVING COUNT(*) >= 1
ORDER BY id_dept;
