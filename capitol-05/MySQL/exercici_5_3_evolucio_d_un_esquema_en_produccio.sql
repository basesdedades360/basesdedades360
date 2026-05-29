-- Exercici resolt 5.3
-- Evolució d'un esquema en producció
-- Sintaxi: MySQL / MariaDB

CREATE TABLE client (
    id_client  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom        VARCHAR(50)  NOT NULL,
    cognoms    VARCHAR(80)  NOT NULL,
    email      VARCHAR(100),
    telefon    VARCHAR(15),
    adreca     VARCHAR(150),
    data_alta  DATE         NOT NULL DEFAULT (CURRENT_DATE)
);



-- 1
ALTER TABLE client
    MODIFY COLUMN nom VARCHAR(80) NOT NULL;

-- 2
ALTER TABLE client
    MODIFY COLUMN cognoms VARCHAR(80) NULL;

-- 3
ALTER TABLE client
    RENAME COLUMN adreca TO adreca_postal;

-- 4
ALTER TABLE client
    ADD COLUMN actiu BOOLEAN NOT NULL DEFAULT TRUE;

-- 5
ALTER TABLE client
    ADD COLUMN tipus_client VARCHAR(20) NOT NULL DEFAULT 'particular',
    ADD CONSTRAINT chk_tipus_client
        CHECK (tipus_client IN ('particular','autonom','empresa'));

-- 6
CREATE TABLE pais (
    codi_pais CHAR(2)     PRIMARY KEY,
    nom_pais  VARCHAR(60) NOT NULL
);

ALTER TABLE client
    ADD COLUMN codi_pais CHAR(2),
    ADD CONSTRAINT fk_client_pais
        FOREIGN KEY (codi_pais) REFERENCES pais(codi_pais);

-- 7
ALTER TABLE client
    ADD CONSTRAINT chk_client_email_format
        CHECK (email IS NULL OR email LIKE '%@%');
