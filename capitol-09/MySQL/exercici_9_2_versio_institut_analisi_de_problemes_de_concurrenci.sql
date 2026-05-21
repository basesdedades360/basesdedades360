-- Exercici resolt 9.2 (versió Institut)
-- Anàlisi de problemes de concurrència en l'entorn acadèmic
-- Sintaxi: MySQL / MariaDB

-- Solució amb FOR UPDATE (bloqueig pessimista)
BEGIN;

SELECT id_alumne, id_modul, convocatoria, nota_final
FROM   matricula
WHERE  id_alumne    = 5
  AND  id_modul     = 3
  AND  convocatoria = 1
FOR UPDATE;
-- 👁️ Si el primer professor encara no ha fet COMMIT,
--    aquesta sentència queda esperant que ho faci.
--    Quan es desbloqueja, el segon professor llegeix
--    JA la nota que ha posat el primer i pot decidir
--    si fer-ne la mitjana correctament o avortar.

UPDATE matricula
SET    nota_final = 7.50
WHERE  id_alumne    = 5
  AND  id_modul     = 3
  AND  convocatoria = 1;

COMMIT;

-- --- Bloc següent ---

-- Solució: forçar un snapshot consistent
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;

-- Totes les lectures següents veuran el mateix estat de la BD,
-- malgrat que altres connexions estiguin inserint matrícules.
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
-- El COUNT i el llistat ara són coherents entre si.

-- --- Bloc següent ---

-- Solució: assegurar-se que NO usem READ UNCOMMITTED
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;

SELECT id_prof, nom, cognoms, salari
FROM   professor
WHERE  id_prof = 7;
-- 👁️ Ara veurem 3 500 € (el valor confirmat),
--    independentment de quants UPDATE no confirmats
--    hi hagi en altres connexions.

COMMIT;
