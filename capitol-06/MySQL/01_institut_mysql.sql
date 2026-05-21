-- MySQL / MariaDB
-- Crear la base de dades

CREATE DATABASE IF NOT EXISTS institut
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE institut;

-- Taula de departaments
CREATE TABLE departament (
    id_dept   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom_dept  VARCHAR(100)     NOT NULL UNIQUE,
    edifici   VARCHAR(50)
);

-- Taula de professors
CREATE TABLE professor (
    id_prof    SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom        VARCHAR(100)      NOT NULL,
    cognoms    VARCHAR(100)      NOT NULL,
    email      VARCHAR(254)      UNIQUE NOT NULL,
    telefon    VARCHAR(15),
    salari     DECIMAL(8,2)      NOT NULL CHECK (salari > 0),
    data_alta  DATE              NOT NULL DEFAULT (CURRENT_DATE),
    actiu      BOOLEAN           NOT NULL DEFAULT TRUE,
    id_dept    TINYINT UNSIGNED  NOT NULL,
    FOREIGN KEY (id_dept) REFERENCES departament(id_dept)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Taula d'alumnes
CREATE TABLE alumne (
    id_alumne   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom         VARCHAR(100) NOT NULL,
    cognoms     VARCHAR(100) NOT NULL,
    email       VARCHAR(254) UNIQUE NOT NULL,
    data_naix   DATE,
    telefon     VARCHAR(15),
    curs_inici  YEAR         NOT NULL
);

-- Taula de mòduls (assignatures)
CREATE TABLE modul (
    id_modul   SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    codi       CHAR(6)           UNIQUE NOT NULL,
    nom_modul  VARCHAR(200)      NOT NULL,
    hores      SMALLINT UNSIGNED NOT NULL CHECK (hores BETWEEN 30 AND 300),
    curs       TINYINT  UNSIGNED NOT NULL CHECK (curs IN (1, 2)),
    id_prof    SMALLINT UNSIGNED,
    FOREIGN KEY (id_prof) REFERENCES professor(id_prof)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Taula de matrícules
CREATE TABLE matricula (
    id_alumne     INT UNSIGNED      NOT NULL,
    id_modul      SMALLINT UNSIGNED NOT NULL,
    nota_final    DECIMAL(4,2)      CHECK (nota_final BETWEEN 0 AND 10),
    convocatoria  TINYINT UNSIGNED  NOT NULL DEFAULT 1
                                    CHECK (convocatoria IN (1, 2, 3)),
    PRIMARY KEY (id_alumne, id_modul, convocatoria),
    FOREIGN KEY (id_alumne) REFERENCES alumne(id_alumne) ON DELETE CASCADE,
    FOREIGN KEY (id_modul)  REFERENCES modul(id_modul)   ON DELETE RESTRICT
);
