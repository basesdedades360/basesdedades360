-- ============================================================
--  INSERCIÓ DE DADES DE PROVA — base de dades 'institut'
-- ============================================================

USE institut;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE matricula;
TRUNCATE TABLE modul;
TRUNCATE TABLE alumne;
TRUNCATE TABLE professor;
TRUNCATE TABLE departament;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------
--  DEPARTAMENTS
-- ------------------------------------------------------------
INSERT INTO departament (id_dept, nom_dept, edifici) VALUES
    (1, 'Informàtica','Edifici A'),
    (2, 'Disseny', 'Edifici B'),
    (3, 'Anglès', 'Edifici A'),
    (4, 'Orientació Laboral', 'Edifici C'),
    (5, 'Sanitat', 'Edifici D'),
    (6, 'Administració', 'Edifici C'),
    (7, 'Electrònica', 'Edifici A');

-- ------------------------------------------------------------
--  PROFESSORS
-- ------------------------------------------------------------
--  Salaris entre 2200 i 2950 € (variació per fer mitjanes/màxims).
--  Dates d'alta entre 2009 i 2021.
--  Dos professors inactius: Eva Romero (Informàtica) i Laia Puig (Sanitat).
INSERT INTO professor (id_prof, nom, cognoms, email, telefon, salari, data_alta, actiu, id_dept) VALUES
    ( 1, 'Héctor', 'Maeso', 'hmaeso@institut.cat', '600111222', 2950.00, '2010-09-01', TRUE,  1),
    ( 2, 'Marta', 'Soler', 'msoler@institut.cat', '600222333', 2700.50, '2015-09-01', TRUE,  1),
    ( 3, 'Jordi', 'Vila', 'jvila@institut.cat', '600333444', 2450.00, '2018-09-01', TRUE,  1),
    ( 4, 'Eva', 'Romero', 'eromero@institut.cat', '600444555', 2600.00, '2012-09-01', FALSE, 1),
    ( 5, 'Dori', 'Garcia', 'dgarcia@institut.cat', '600555666', 2800.00, '2011-09-01', TRUE,  2),
    ( 6, 'Anna', 'Martí', 'amarti@institut.cat', '600666777', 2300.00, '2020-09-01', TRUE,  2),
    ( 7, 'Ramón', 'Redondo', 'rredondo@institut.cat', '600777888', 2550.00, '2014-09-01', TRUE,  3),
    ( 8, 'Sergi', 'Mas', 'smas@institut.cat', '600888999', 2200.00, '2021-09-01', TRUE,  3),
    ( 9, 'Isabel', 'Garcia', 'igarcia@institut.cat', '600999000', 2750.00, '2013-09-01', TRUE,  4),
    (10, 'Pere', 'Roca', 'proca@institut.cat', '601111222', 2900.00, '2009-09-01', TRUE,  5),
    (11, 'Laia', 'Puig', 'lpuig@institut.cat', '601222333', 2400.00, '2019-09-01', FALSE, 5),
    (12, 'Núria', 'Camps', 'ncamps@institut.cat', '601333444', 2650.00, '2016-09-01', TRUE,  6),
    (13, 'Carles', 'Bosch', 'cbosch@institut.cat', '601444555', 2850.00, '2012-09-01', TRUE,  7);

-- ------------------------------------------------------------
--  ALUMNES
-- ------------------------------------------------------------

INSERT INTO alumne (id_alumne, nom, cognoms, email, data_naix, telefon, curs_inici) VALUES
    ( 1, 'Marc', 'Puig Vidal', 'marcpv@alumnes.cat', '2005-03-12', '610111111', 2024),
    ( 2, 'Laia', 'Solé Mas', 'laiasm@alumnes.cat', '2004-07-22', '610222222', 2023),
    ( 3, 'Pol', 'Riera Bosch', 'polrb@alumnes.cat', '2005-11-05', '610333333', 2024),
    ( 4, 'Júlia', 'Font Casas', 'juliafc@alumnes.cat', '2003-02-18', '610444444', 2023),
    ( 5, 'Aleix', 'Roca Vila', 'aleixrv@alumnes.cat', '2005-09-30', NULL, 2024),
    ( 6, 'Berta', 'Camps Tort', 'bertact@alumnes.cat', '2004-05-14', '610666666', 2023),
    ( 7, 'Nil', 'Bosch Soler', 'nilbs@alumnes.cat', '2006-01-08', '610777777', 2025),
    ( 8, 'Clara', 'Vidal Puig', 'claravp@alumnes.cat', '2005-04-25', '610888888', 2024),
    ( 9, 'Arnau', 'Mas Riera', 'arnaumr@alumnes.cat', '2004-10-11', '610999999', 2023),
    (10, 'Maria', 'Tort Font', 'mariatf@alumnes.cat', '2005-06-19', '611000000', 2024),
    (11, 'Èlia', 'Soler Camps', 'eliasc@alumnes.cat', '2006-03-03', '611111111', 2025),
    (12, 'Roger', 'Garcia Roca', 'rogergr@alumnes.cat', '2003-12-27', '611222222', 2022),
    (13, 'Ona', 'Casas Bosch', 'onacb@alumnes.cat', '2005-08-15', NULL, 2024),
    (14, 'Biel', 'Vila Mas', 'bielvm@alumnes.cat', '2004-02-09', '611444444', 2023),
    (15, 'Jana', 'Puig Tort', 'janapt@alumnes.cat', '2006-05-21', '611555555', 2025),
    (16, 'Aitor', 'Riera Camps', 'aitorrc@alumnes.cat', '2003-09-06', '611666666', 2022),
    (17, 'Lluc', 'Mas Vidal', 'llucmv@alumnes.cat', '2005-12-14', '611777777', 2024),
    (18, 'Gal·la', 'Bosch Riera', 'gallabr@alumnes.cat', '2004-04-02', '611888888', 2023),
    (19, 'Quim', 'Font Soler', 'quimfs@alumnes.cat', '2005-10-28', NULL, 2024),
    (20, 'Adriana', 'Roca Garcia', 'adrianarg@alumnes.cat', '2006-07-17', '612000000', 2025);

-- ------------------------------------------------------------
--  MÒDULS
-- ------------------------------------------------------------

INSERT INTO modul (id_modul, codi, nom_modul, hores, curs, id_prof) VALUES
    ( 1, 'INF101', 'Bases de dades', 165, 1,  1), 
    ( 2, 'INF102', 'Programació', 297, 1,  2),  
    ( 3, 'INF103', 'Llenguatges de marques', 99, 1,  3), 
    ( 4, 'INF104', 'Entorns de desenvolupament', 66, 1,  4), 
    ( 5, 'INF105', 'Sistemes informàtics', 165, 1,  2),  
    ( 6, 'INF201', 'Accés a dades', 132, 2,  1),  
    ( 7, 'INF202', 'Desenvolupament d''interfícies', 132, 2,  3),  
    ( 8, 'DIS101', 'Tipografia', 99, 1,  5),  
    ( 9, 'DIS102', 'Dibuix artístic', 132, 1,  6),  
    (10, 'DIS201', 'Disseny gràfic editorial', 165, 2,  5),  
    (11, 'ENG101', 'Anglès tècnic I', 99, 1,  7), 
    (12, 'ENG201', 'Anglès tècnic II', 99, 2,  8),  
    (13, 'FOL101', 'Formació i orientació laboral', 99, 1,  9), 
    (14, 'FOL201', 'Empresa i iniciativa emprenedora', 66, 2,  9),  
    (15, 'SAN101', 'Anatomia patològica', 132, 1, 10),  
    (16, 'SAN201', 'Biologia molecular', 165, 2, 10),  
    (17, 'ELE101', 'Electrònica analògica', 165, 1, 13),  
    (18, 'ELE201', 'Electrònica digital', 132, 2, 13),  
    (19, 'ADM101', 'Comptabilitat', 132, 1, 12),  
    (20, 'ADM201', 'Gestió logística', 99, 2, NULL); 

-- ------------------------------------------------------------
--  MATRÍCULES
-- ------------------------------------------------------------
--  PK composta: (id_alumne, id_modul, convocatoria).
--  Inclou:
--    · Notes >= 5 (aprovats) i < 5 (suspesos)
--    · Notes NULL (avaluació pendent)
--    · Múltiples convocatòries per al mateix alumne i mòdul
--    · Alumnes amb moltes matrícules i alumnes amb cap (Quim, Adriana)
INSERT INTO matricula (id_alumne, id_modul, nota_final, convocatoria) VALUES
    -- Marc (1) — Informàtica curs 1
    ( 1,  1, 7.50, 1),
    ( 1,  2, 6.25, 1),
    ( 1,  3, 8.00, 1),
    ( 1,  4, 4.50, 1),   -- suspès 1a conv
    ( 1,  4, 5.50, 2),   -- aprovat 2a conv
    ( 1,  5, 9.00, 1),
    ( 1, 11, 7.00, 1),
    ( 1, 13, 6.50, 1),

    -- Laia (2) — Informàtica curs 2
    ( 2,  6, 8.50, 1),
    ( 2,  7, 7.25, 1),
    ( 2, 12, 6.00, 1),
    ( 2, 14, NULL, 1),   -- pendent

    -- Pol (3) — repetidor a Bases de dades (3 convocatòries)
    ( 3,  1, 4.25, 1),
    ( 3,  1, 3.00, 2),
    ( 3,  1, 5.10, 3),   -- aprovat in extremis
    ( 3,  2, 5.00, 1),
    ( 3,  3, 6.50, 1),

    -- Júlia (4) — Disseny curs 2 (arrossega un de curs 1)
    ( 4, 10, 8.75, 1),
    ( 4,  8, 7.00, 1),
    ( 4, 12, 5.50, 1),

    -- Aleix (5) — Informàtica curs 1, alguna nota pendent
    ( 5,  1, NULL, 1),
    ( 5,  2, 7.80, 1),
    ( 5,  3, 9.10, 1),

    -- Berta (6) — Disseny curs 1
    ( 6,  8, 8.20, 1),
    ( 6,  9, 6.50, 1),
    ( 6, 11, 4.00, 1),
    ( 6, 11, 6.10, 2),
    ( 6, 13, 7.50, 1),

    -- Nil (7) — acabat de començar (2025): tot pendent
    ( 7,  1, NULL, 1),
    ( 7,  2, NULL, 1),
    ( 7,  3, NULL, 1),

    -- Clara (8) — Sanitat
    ( 8, 15, 8.00, 1),
    ( 8, 16, 7.40, 1),
    ( 8, 13, 6.80, 1),

    -- Arnau (9) — Electrònica curs 2
    ( 9, 17, 7.00, 1),
    ( 9, 18, 8.50, 1),

    -- Maria (10) — Administració + Anglès
    (10, 19, 6.20, 1),
    (10, 11, 5.30, 1),

    -- Èlia (11) — Disseny curs 1, bona alumna
    (11,  8, 9.50, 1),
    (11,  9, 8.80, 1),
    (11, 11, 7.20, 1),
    (11, 13, 8.00, 1),

    -- Roger (12) — Informàtica curs 2 amb assignatures arrossegades
    (12,  6, 4.00, 1),
    (12,  6, 5.20, 2),
    (12,  7, 6.00, 1),

    -- Ona (13) — Sanitat (només una matrícula)
    (13, 15, 7.30, 1),

    -- Biel (14) — Electrònica curs 1 + Anglès suspès i recuperat
    (14, 17, 5.80, 1),
    (14, 11, 4.50, 1),
    (14, 11, 5.00, 2),

    -- Jana (15) — Administració, just començada
    (15, 19, NULL, 1),
    (15, 11, NULL, 1),

    -- Aitor (16) — Informàtica curs 2
    (16,  6, 8.20, 1),
    (16,  7, 7.50, 1),

    -- Lluc (17) — Informàtica, aprovat just
    (17,  1, 5.00, 1),
    (17,  2, 5.10, 1),
    (17,  3, 5.20, 1),

    -- Gal·la (18) — Sanitat curs 2
    (18, 16, 9.20, 1),
    (18, 12, 8.10, 1);

    -- Quim (19) i Adriana (20): SENSE matrícules a propòsit.


