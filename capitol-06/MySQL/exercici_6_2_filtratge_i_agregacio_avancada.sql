-- Exercici resolt 6.2
-- Filtratge i agregació avançada
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

-- --- Bloc següent ---

-- a) Alumnes nascuts entre 2002 i 2003
SELECT nom, cognoms, data_naix
FROM   alumne
WHERE  data_naix BETWEEN '2002-01-01' AND '2003-12-31'
ORDER BY data_naix;

-- Resultat: Joan Mas (2002-11-30), Laia Puig (2003-05-15), Anna Soler (2003-09-05)

-- b) Alumnes amb almenys una nota registrada
-- COUNT(nota_final) ignora NULLs, per tant només compta files amb nota real
SELECT COUNT(DISTINCT id_alumne) AS alumnes_amb_nota
FROM   matricula
WHERE  nota_final IS NOT NULL;
-- Resultat: 5 (tots tenen almenys una nota)

-- c) Nota mitjana per mòdul dels aprovats, amb filtre de HAVING
SELECT
    m.codi,
    m.nom_modul,
    COUNT(ma.nota_final)             AS num_aprovats,
    ROUND(AVG(ma.nota_final), 2)     AS nota_mitja_aprovats
FROM   modul m
JOIN   matricula ma ON m.id_modul = ma.id_modul
WHERE  ma.nota_final >= 5      -- filtra suspesos i NULLs ABANS d'agrupar
GROUP BY m.id_modul, m.codi, m.nom_modul
HAVING AVG(ma.nota_final) > 6.5
ORDER BY nota_mitja_aprovats DESC;

-- d) Resum per alumne
SELECT
    a.nom,
    a.cognoms,
    COUNT(*)                                     AS total_matricules,
    COUNT(ma.nota_final)                         AS notes_registrades,
    COALESCE(ROUND(AVG(ma.nota_final), 2), 0)    AS nota_mitja
FROM   alumne a
JOIN   matricula ma ON a.id_alumne = ma.id_alumne
GROUP BY a.id_alumne, a.nom, a.cognoms
ORDER BY nota_mitja DESC;
