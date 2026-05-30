-- Exercici resolt 6.2
-- Filtratge 
-- Sintaxi: MySQL / MariaDB

INSERT INTO alumne (nom, cognoms, email, data_naix, curs_inici) VALUES
    ('Laia',  'Puig',   'laia@mail.com',  '2003-05-15', 2022),
    ('Joan',  'Mas',    'joan@mail.com',  '2002-11-30', 2021),
    ('Marta', 'Ferrer', 'marta@mail.com', '2004-02-20', 2023),
    ('Pere',  'Vila',   'pere@mail.com',  '2001-08-10', 2021),
    ('Anna',  'Soler',  'anna@mail.com',  '2003-09-05', 2022);

INSERT INTO modul (codi, nom_modul, hores, curs, id_prof) VALUES
    ('DAW01', 'Bases de Dades',       120, 1, 1),
    ('DAW02', 'Programació',          165, 1, 2),
    ('DAW03', 'Desenvolupament Web',  120, 2, 1);

INSERT INTO matricula (id_alumne, id_modul, nota_final) VALUES
    (1,1,7.5), (1,2,8.0), (1,3,6.5),
    (2,1,5.0), (2,2,4.5), (2,3,NULL),
    (3,1,9.0), (3,2,8.5),
    (4,1,3.5), (4,2,6.0), (4,3,7.0),
    (5,1,NULL),(5,2,7.5);

-- ------------------------------------------------------------------------------------------


-- 1
SELECT nom, cognoms, data_naix
FROM   alumne
WHERE  data_naix BETWEEN '2002-01-01' AND '2003-12-31'
ORDER BY data_naix;

-- 2
SELECT COUNT(DISTINCT id_alumne) AS alumnes_amb_nota
FROM   matricula
WHERE  nota_final IS NOT NULL;

-- 3 versió MySQL
SELECT
  UPPER(CONCAT(nom, ' ', cognoms))           AS nom_complet,
  TIMESTAMPDIFF(YEAR, data_naix, CURDATE())  AS edat
FROM alumne
WHERE data_naix IS NOT NULL;



-- 4
SELECT codi, nom_modul, hores
FROM   modul
WHERE  id_prof IS NULL OR hores < 100;

-- 5
SELECT
  CONCAT(nom, ' ', cognoms) AS professor,
  COALESCE(telefon, email, 'Sense contacte') AS contacte
FROM professor;

