-- Exercici resolt 6.1
-- Consultes DML bàsiques
-- Sintaxi: MySQL / MariaDB

-- 1. Inserir departaments
INSERT INTO departament (nom_dept, edifici) VALUES
    ('Informàtica',  'Edifici A'),
    ('Administració','Edifici B'),
    ('Sanitat',      'Edifici C');

-- 2. Inserir professors (id_dept = 1 correspon a Informàtica)
INSERT INTO professor (nom, cognoms, email, salari, id_dept) VALUES
    ('Anna', 'Vidal',  'anna.vidal@escola.cat',  2800.00, 1),
    ('Marc', 'Torres', 'marc.torres@escola.cat', 3100.00, 1);

-- 3. Professors actius amb salari mensual
SELECT
    CONCAT(nom, ' ', cognoms) AS nom_complet,    -- a PG funciona també nom || ' ' || cognoms
    salari                    AS salari_anual,
    ROUND(salari / 12, 2)     AS salari_mensual
FROM professor
WHERE actiu = TRUE
ORDER BY salari DESC;

-- --- Bloc següent ---

-- 4. Augment del 5 % al departament d'Informàtica

-- Pas previ: comprova quins professors s'afectaran:
SELECT id_prof, nom, cognoms, salari FROM professor WHERE id_dept = 1;

-- Quan el resultat és correcte, executa l'UPDATE:
UPDATE professor
SET    salari = ROUND(salari * 1.05, 2)
WHERE  id_dept = 1;

-- 5. Professors per departament (amb almenys 1)
SELECT
    id_dept,
    COUNT(*)               AS num_professors,
    ROUND(AVG(salari), 2)  AS salari_mitja
FROM   professor
GROUP BY id_dept
HAVING COUNT(*) >= 1
ORDER BY id_dept;
