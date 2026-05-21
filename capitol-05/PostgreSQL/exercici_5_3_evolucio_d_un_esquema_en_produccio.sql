-- Exercici resolt 5.3
-- Evolució d'un esquema en producció
-- Sintaxi: PostgreSQL

-- PostgreSQL
CREATE TABLE client (
    id_client  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom        VARCHAR(50)  NOT NULL,
    cognoms    VARCHAR(80)  NOT NULL,
    email      VARCHAR(100),
    telefon    VARCHAR(15),
    adreca     VARCHAR(150),
    data_alta  DATE         NOT NULL DEFAULT CURRENT_DATE
);

-- --- Bloc següent ---

-- PostgreSQL

-- 1. Ampliar nom — TYPE només afecta el tipus; NOT NULL es manté
ALTER TABLE client
    ALTER COLUMN nom TYPE VARCHAR(80);

-- 2. Treure NOT NULL de cognoms
ALTER TABLE client
    ALTER COLUMN cognoms DROP NOT NULL;

-- 3. Renombrar adreca → adreca_postal
ALTER TABLE client
    RENAME COLUMN adreca TO adreca_postal;

-- 4. Afegir actiu
ALTER TABLE client
    ADD COLUMN actiu BOOLEAN NOT NULL DEFAULT TRUE;

-- 5. Afegir tipus_client + CHECK amb nom
ALTER TABLE client
    ADD COLUMN tipus_client VARCHAR(20) NOT NULL DEFAULT 'particular',
    ADD CONSTRAINT chk_tipus_client
        CHECK (tipus_client IN ('particular','autonom','empresa'));

-- 6. Crear taula pais i afegir la FK
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
