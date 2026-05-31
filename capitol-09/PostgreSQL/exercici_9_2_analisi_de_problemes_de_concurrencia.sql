-- Exercici resolt 9.2
-- MySQL / MariaDB

-- Escenari A 
BEGIN;

SELECT id_alumne, id_modul, convocatoria, nota_final
FROM   matricula
WHERE  id_alumne    = 5
  AND  id_modul     = 3
  AND  convocatoria = 1
FOR UPDATE;


UPDATE matricula
SET    nota_final = 7.50
WHERE  id_alumne    = 5
  AND  id_modul     = 3
  AND  convocatoria = 1;

COMMIT;


-- Escenari B: 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;


SELECT COUNT(*) AS total_matricules
FROM   matricula
WHERE  convocatoria = 1;

SELECT a.id_alumne, a.nom, a.cognoms, m.codi, m.nom_modul
FROM   matricula mt
JOIN   alumne a ON a.id_alumne = mt.id_alumne
JOIN   modul  m ON m.id_modul  = mt.id_modul
WHERE  mt.convocatoria = 1
ORDER BY a.cognoms, a.nom;

COMMIT;

-- Escenari C:
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;

SELECT id_prof, nom, cognoms, salari
FROM   professor
WHERE  id_prof = 7;


COMMIT;
