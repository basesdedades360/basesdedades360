-- Exercici resolt 10.1
-- Vista de notes aprovades: per què no és actualitzable
-- Sintaxi: PostgreSQL

CREATE OR REPLACE VIEW vista_notes_aprovats AS
SELECT a.id_alumne,
       CONCAT(a.nom, ' ', a.cognoms)     AS alumne,
       m.codi                             AS codi_modul,
       m.nom_modul,
       mt.convocatoria,
       mt.nota_final
FROM   matricula mt
JOIN   alumne a ON a.id_alumne = mt.id_alumne
JOIN   modul  m ON m.id_modul  = mt.id_modul
WHERE  mt.nota_final >= 5;

-- --- Bloc següent ---

SELECT * FROM vista_notes_aprovats
ORDER BY alumne, codi_modul, convocatoria
LIMIT 10;

-- --- Bloc següent ---

UPDATE vista_notes_aprovats
SET    nota_final = nota_final + 0.5
WHERE  id_alumne   = 1
  AND  codi_modul  = 'M01-D1'
  AND  convocatoria = 1;
