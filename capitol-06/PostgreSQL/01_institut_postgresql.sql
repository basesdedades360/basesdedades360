-- PostgreSQL

-- Crear la base de dades (amb codificació UTF8)
-- A PostgreSQL, la codificació es fixa al crear la BD i no es canvia després.

CREATE DATABASE institut
    WITH ENCODING 'UTF8'
    LC_COLLATE 'ca_ES.UTF-8'
    LC_CTYPE   'ca_ES.UTF-8'
    TEMPLATE template0;

\c institut   -- canviar de connexió a la nova BD (psql)

-- Taula de departaments
CREATE TABLE departament (
    id_dept   SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_dept  VARCHAR(100) NOT NULL UNIQUE,
    edifici   VARCHAR(50)
);

-- Taula de professors
CREATE TABLE professor (
    id_prof    SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom        VARCHAR(100) NOT NULL,
    cognoms    VARCHAR(100) NOT NULL,
    email      VARCHAR(254) UNIQUE NOT NULL,
    telefon    VARCHAR(15),
    salari     NUMERIC(8,2) NOT NULL CHECK (salari > 0),
    data_alta  DATE         NOT NULL DEFAULT CURRENT_DATE,
    actiu     BOOLEAN       NOT NULL DEFAULT TRUE,
    id_dept    SMALLINT     NOT NULL,
    FOREIGN KEY (id_dept) REFERENCES departament(id_dept)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Taula d'alumnes
CREATE TABLE alumne (
    id_alumne   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom         VARCHAR(100) NOT NULL,
    cognoms     VARCHAR(100) NOT NULL,
    email       VARCHAR(254) UNIQUE NOT NULL,
    data_naix   DATE,
    telefon     VARCHAR(15),
    curs_inici  SMALLINT     NOT NULL CHECK (curs_inici BETWEEN 1900 AND 2155)
);

-- Taula de mòduls (assignatures)
CREATE TABLE modul (
    id_modul   SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codi       CHAR(6)      UNIQUE NOT NULL,
    nom_modul  VARCHAR(200) NOT NULL,
    hores      SMALLINT     NOT NULL CHECK (hores BETWEEN 30 AND 300),
    curs       SMALLINT     NOT NULL CHECK (curs IN (1, 2)),
    id_prof    SMALLINT,
    FOREIGN KEY (id_prof) REFERENCES professor(id_prof)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Taula de matrícules
CREATE TABLE matricula (
    id_alumne     INT      NOT NULL,
    id_modul      SMALLINT NOT NULL,
    nota_final    NUMERIC(4,2) CHECK (nota_final BETWEEN 0 AND 10),
    convocatoria  SMALLINT NOT NULL DEFAULT 1
                          CHECK (convocatoria IN (1, 2, 3)),
    PRIMARY KEY (id_alumne, id_modul, convocatoria),
    FOREIGN KEY (id_alumne) REFERENCES alumne(id_alumne) ON DELETE CASCADE,
    FOREIGN KEY (id_modul)  REFERENCES modul(id_modul)   ON DELETE RESTRICT
);
