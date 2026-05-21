-- Exercici resolt 9.1 (versió Institut)
-- Matricular un alumne a diversos mòduls amb transacció
-- Sintaxi: MySQL / MariaDB

-- alumne   (id_alumne, nom, cognoms, email, data_naix, telefon, curs_inici)
-- modul    (id_modul, codi, nom_modul, hores, curs, id_prof)
-- matricula(id_alumne, id_modul, nota_final, convocatoria)
--          PK = (id_alumne, id_modul, convocatoria)

-- --- Bloc següent ---

-- ============================================================
--  MATRÍCULA: alumne 1, mòduls = [1, 2], convocatòria = 1
--  Patró: validar → crear matrícules → verificar → decidir
-- ============================================================

BEGIN;

-- ════════════════════════════════════════════════════════════
-- FASE 1: Validar que l'alumne existeix (i bloquejar la fila)
-- ════════════════════════════════════════════════════════════
SELECT id_alumne, nom, cognoms, email
FROM   alumne
WHERE  id_alumne = 1
FOR UPDATE;
-- 👁️ Mira el resultat:
--    · Si NO retorna cap fila → l'alumne no existeix → ROLLBACK al final
--    · Si retorna la fila    → continuem

-- ════════════════════════════════════════════════════════════
-- FASE 2: Validar els mòduls (i bloquejar-los)
-- ════════════════════════════════════════════════════════════

-- 2.1) Mòdul 1
SELECT id_modul, codi, nom_modul, hores, curs
FROM   modul
WHERE  id_modul = 1
FOR UPDATE;
-- 👁️ Si NO retorna cap fila → el mòdul no existeix → ROLLBACK al final.

-- 2.2) Mòdul 2
SELECT id_modul, codi, nom_modul, hores, curs
FROM   modul
WHERE  id_modul = 2
FOR UPDATE;
-- 👁️ Mateixes comprovacions que abans.

-- ════════════════════════════════════════════════════════════
-- FASE 3: Comprovar que no hi ha matrícula prèvia
--         per a aquests mòduls en la convocatòria 1
-- ════════════════════════════════════════════════════════════
SELECT id_alumne, id_modul, convocatoria, nota_final
FROM   matricula
WHERE  id_alumne   = 1
  AND  id_modul    IN (1, 2)
  AND  convocatoria = 1;
-- 👁️ Si retorna ALGUNA fila → l'alumne ja està matriculat
--    en aquesta convocatòria a algun d'aquests mòduls → ROLLBACK al final.
-- 👁️ Si retorna 0 files     → continuem amb les insercions.

-- ════════════════════════════════════════════════════════════
-- FASE 4: Crear les matrícules (una per mòdul)
-- ════════════════════════════════════════════════════════════
INSERT INTO matricula (id_alumne, id_modul, convocatoria, nota_final)
VALUES (1, 1, 1, NULL);

INSERT INTO matricula (id_alumne, id_modul, convocatoria, nota_final)
VALUES (1, 2, 1, NULL);

-- ════════════════════════════════════════════════════════════
-- FASE 5: Verificació final i decisió COMMIT/ROLLBACK
-- ════════════════════════════════════════════════════════════
SELECT a.nom, a.cognoms,
       m.codi, m.nom_modul,
       mt.convocatoria, mt.nota_final
FROM   matricula mt
JOIN   alumne a ON a.id_alumne = mt.id_alumne
JOIN   modul  m ON m.id_modul  = mt.id_modul
WHERE  mt.id_alumne   = 1
  AND  mt.convocatoria = 1
  AND  mt.id_modul    IN (1, 2);
-- 👁️ Mira el resultat:
--    · Han d'aparèixer 2 files (una per cada mòdul matriculat).
--    · Les dades de l'alumne i dels mòduls han de quadrar.
--    · La nota_final ha de ser NULL (encara no avaluada).
-- Si tot quadra → COMMIT
-- Si has detectat qualsevol problema en CUALSEVOL fase anterior → ROLLBACK

COMMIT;
-- ROLLBACK;
