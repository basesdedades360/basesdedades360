-- Exercici resolt 7.1
-- Consultes multi-taula amb JOINs i agregació
-- Sintaxi: PostgreSQL

-- a) Tots els alumnes amb les seves notes (LEFT JOIN per incloure els sense notes)
SELECT
  CONCAT(a.nom, ' ', a.cognoms) AS alumne,
  m.nom_modul,
  ma.nota_final,
  CASE
    WHEN ma.nota_final IS NULL THEN 'Pendent'
    WHEN ma.nota_final >= 5    THEN 'Aprovat'
    ELSE 'Suspès'
  END AS estat
FROM alumne a
LEFT JOIN matricula ma ON a.id_alumne = ma.id_alumne
LEFT JOIN modul m      ON ma.id_modul  = m.id_modul
ORDER BY a.cognoms, a.nom, m.nom_modul;

-- b) Alumnes amb nota mitjana superior a la mitjana global
-- Estratègia: GROUP BY per alumne i HAVING amb subconsulta sobre la mitjana global
SELECT
  CONCAT(a.nom, ' ', a.cognoms) AS alumne,
  ROUND(AVG(ma.nota_final), 2)  AS nota_mitja_alumne
FROM alumne a
INNER JOIN matricula ma ON a.id_alumne = ma.id_alumne
WHERE ma.nota_final IS NOT NULL
GROUP BY a.id_alumne, a.nom, a.cognoms
HAVING AVG(ma.nota_final) > (
  SELECT AVG(nota_final) FROM matricula WHERE nota_final IS NOT NULL
)
ORDER BY nota_mitja_alumne DESC;

-- c) Professors amb resum de mòduls (LEFT JOIN per incloure sense mòduls)
SELECT
  CONCAT(p.nom, ' ', p.cognoms)   AS professor,
  d.nom_dept                      AS departament,
  COUNT(m.id_modul)               AS num_moduls,
  COALESCE(SUM(m.hores), 0)       AS total_hores
FROM professor p
INNER JOIN departament d ON p.id_dept  = d.id_dept
LEFT  JOIN modul m       ON m.id_prof  = p.id_prof
GROUP BY p.id_prof, p.nom, p.cognoms, d.nom_dept
ORDER BY total_hores DESC;
