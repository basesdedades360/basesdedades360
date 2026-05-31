-- 1
SELECT nom, cognoms
FROM alumne a
WHERE EXISTS (
  SELECT 1 FROM matricula
  WHERE id_alumne = a.id_alumne
    AND nota_final IS NOT NULL
)
AND NOT EXISTS (
  SELECT 1 FROM matricula
  WHERE id_alumne = a.id_alumne
    AND nota_final < 5
);

-- 2
SELECT
  m.codi,
  m.nom_modul,
  ROUND(AVG(ma.nota_final), 2) AS nota_mitja
FROM modul m
INNER JOIN matricula ma ON m.id_modul = ma.id_modul
WHERE ma.nota_final IS NOT NULL
GROUP BY m.id_modul, m.codi, m.nom_modul
HAVING AVG(ma.nota_final) > (
  SELECT AVG(ma2.nota_final)
  FROM matricula ma2
  INNER JOIN modul m2 ON ma2.id_modul = m2.id_modul
  WHERE m2.codi = 'DAW01'
    AND ma2.nota_final IS NOT NULL
)
ORDER BY nota_mitja DESC;


-- 3
SELECT
  d.nom_dept,
  CASE
    WHEN EXISTS (
      SELECT 1 FROM professor p
      WHERE p.id_dept = d.id_dept
        AND p.salari > 3000
        AND p.actiu = TRUE
    ) THEN 'Sí'
    ELSE 'No'
  END AS te_prof_alt_salari
FROM departament d
ORDER BY d.nom_dept;
