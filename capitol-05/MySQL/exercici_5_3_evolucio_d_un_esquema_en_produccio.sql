-- Exercici resolt 5.3
-- Evolució d'un esquema en producció
-- Sintaxi: MySQL / MariaDB

-- MySQL / MariaDB
CREATE TABLE client (
    id_client  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom        VARCHAR(50)  NOT NULL,
    cognoms    VARCHAR(80)  NOT NULL,
    email      VARCHAR(100),
    telefon    VARCHAR(15),
    adreca     VARCHAR(150),
    data_alta  DATE         NOT NULL DEFAULT (CURRENT_DATE)
);

-- --- Bloc següent ---

-- MySQL / MariaDB

-- 1. Ampliar nom — atenció: MODIFY exigeix repetir NOT NULL!
ALTER TABLE client
    MODIFY COLUMN nom VARCHAR(80) NOT NULL;

-- 2. Fer cognoms opcional
ALTER TABLE client
    MODIFY COLUMN cognoms VARCHAR(80) NULL;

-- 3. Renombrar adreca → adreca_postal (MySQL ≥ 8.0)
ALTER TABLE client
    RENAME COLUMN adreca TO adreca_postal;
-- Versió clàssica equivalent (cal repetir el tipus):
-- ALTER TABLE client CHANGE COLUMN adreca adreca_postal VARCHAR(150);

-- 4. Afegir actiu (els registres existents reben TRUE automàticament)
ALTER TABLE client
    ADD COLUMN actiu BOOLEAN NOT NULL DEFAULT TRUE;

-- 5. Afegir tipus_client + CHECK amb nom (dues operacions, un sol ALTER)
ALTER TABLE client
    ADD COLUMN tipus_client VARCHAR(20) NOT NULL DEFAULT 'particular',
    ADD CONSTRAINT chk_tipus_client
        CHECK (tipus_client IN ('particular','autonom','empresa'));

-- 6. Crear taula pais i afegir la FK a client
CREATE TABLE pais (
    codi_pais CHAR(2)     PRIMARY KEY,
    nom_pais  VARCHAR(60) NOT NULL
);

ALTER TABLE client
    ADD COLUMN codi_pais CHAR(2),
    ADD CONSTRAINT fk_client_pais
        FOREIGN KEY (codi_pais) REFERENCES pais(codi_pais);

-- 7. CHECK de format d'email
ALTER TABLE client
    ADD CONSTRAINT chk_client_email_format
        CHECK (email IS NULL OR email LIKE '%@%');
