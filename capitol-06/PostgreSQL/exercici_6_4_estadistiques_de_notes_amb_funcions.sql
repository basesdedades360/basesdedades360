-- Exercici resolt 6.4

-- 1
SELECT id_alumne, nom, cognoms, email
FROM   alumne
WHERE  email !~ '@alumnes\.cat$';

-- 2
SELECT id_prof, nom, cognoms, email
FROM   professor
WHERE  email !~ '@institut\.cat$';

-- 3
SELECT 'alumne' AS taula, id_alumne AS id, telefon
FROM   alumne
WHERE  telefon IS NOT NULL
  AND  telefon !~ '^[67][0-9]{8}$'
UNION ALL
SELECT 'professor', id_prof, telefon
FROM   professor
WHERE  telefon IS NOT NULL
  AND  telefon !~ '^[67][0-9]{8}$';

-- 4
SELECT id_modul, codi, nom_modul
FROM   modul
WHERE  codi !~ '^[A-Z]{3}[0-9]{3}$';
