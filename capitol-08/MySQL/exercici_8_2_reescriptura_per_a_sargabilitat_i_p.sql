-- Exercici resolt 8.2
-- Reescriptura per a sargabilitat i paginació
-- Sintaxi: MySQL / MariaDB

SELECT * FROM alumne
WHERE YEAR(CURRENT_DATE) - YEAR(data_naix) = 18;

-- --- Bloc següent ---

SELECT * FROM alumne ORDER BY id_alumne LIMIT 20 OFFSET 9980;

-- --- Bloc següent ---

SELECT * FROM professor
WHERE id_prof NOT IN (SELECT id_prof FROM modul);

-- --- Bloc següent ---

-- ✅ Sargable: comparació directa amb un rang fix
SELECT * FROM alumne
WHERE data_naix >= '2007-01-01'
  AND data_naix <  '2008-01-01';

-- --- Bloc següent ---

SELECT * FROM alumne
WHERE data_naix <= CURRENT_DATE - INTERVAL '18 years'
  AND data_naix >  CURRENT_DATE - INTERVAL '19 years';

-- --- Bloc següent ---

-- ✅ Paginació per cursor: rendiment constant siguin quina sigui la pàgina
SELECT * FROM alumne
WHERE id_alumne > :ultim_id_de_la_pagina_500
ORDER BY id_alumne
LIMIT 20;

-- --- Bloc següent ---

-- ✅ NOT EXISTS és immune al problema dels NULLs
SELECT * FROM professor p
WHERE NOT EXISTS (
  SELECT 1 FROM modul m WHERE m.id_prof = p.id_prof
);
