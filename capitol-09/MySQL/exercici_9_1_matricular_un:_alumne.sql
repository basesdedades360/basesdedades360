-- ============================================================
--  MATRÍCULA: alumne 1, mòduls = [1, 2], convocatòria = 1
-- ============================================================

BEGIN;

-- 1

SELECT id_alumne, nom, cognoms, email
FROM   alumne
WHERE  id_alumne = 1
FOR UPDATE;

--  Si NO retorna cap fila → l'alumne no existeix → ROLLBACK al final
--  Si retorna la fila    → continuem

-- 2
-- Mòdul 1
SELECT id_modul, codi, nom_modul, hores, curs
FROM   modul
WHERE  id_modul = 1
FOR UPDATE;
-- Si NO retorna cap fila → el mòdul no existeix → ROLLBACK al final

-- Mòdul 2
SELECT id_modul, codi, nom_modul, hores, curs
FROM   modul
WHERE  id_modul = 2
FOR UPDATE;
-- Si NO retorna cap fila → el mòdul no existeix → ROLLBACK al final

-- 3
SELECT id_alumne, id_modul, convocatoria, nota_final
FROM   matricula
WHERE  id_alumne   = 1
  AND  id_modul    IN (1, 2)
  AND  convocatoria = 1;

-- Si retorna ALGUNA fila → l'alumne ja està matriculat → ROLLBACK al final.
-- Si retorna 0 files     → continuem amb les insercions.


-- 4
INSERT INTO matricula (id_alumne, id_modul, convocatoria, nota_final)
VALUES (1, 1, 1, NULL);

INSERT INTO matricula (id_alumne, id_modul, convocatoria, nota_final)
VALUES (1, 2, 1, NULL);


-- 5

COMMIT;
-- ROLLBACK;
