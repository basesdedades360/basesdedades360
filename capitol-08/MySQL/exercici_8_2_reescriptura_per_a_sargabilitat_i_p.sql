-- Exercici resolt 8.2
-- MySQL / MariaDB

SELECT * FROM alumne
WHERE YEAR(CURRENT_DATE) - YEAR(data_naix) = 18;

SELECT * FROM alumne ORDER BY id_alumne LIMIT 20 OFFSET 9980;


SELECT * FROM professor
WHERE id_prof NOT IN (SELECT id_prof FROM modul);

-- ---------------------------------------------------------------

--  1
SELECT * FROM alumne
WHERE data_naix >= '2007-01-01'
  AND data_naix <  '2008-01-01';

-- 

SELECT * FROM alumne
WHERE data_naix <= CURRENT_DATE - INTERVAL '18 years'
  AND data_naix >  CURRENT_DATE - INTERVAL '19 years';

-- 2

SELECT * FROM alumne
WHERE id_alumne > :ultim_id_de_la_pagina_500
ORDER BY id_alumne
LIMIT 20;

-- 3
SELECT * FROM professor p
WHERE NOT EXISTS (
  SELECT 1 FROM modul m WHERE m.id_prof = p.id_prof
);
