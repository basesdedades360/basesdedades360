-- Exercici resolt 5.4
-- Refactor amb conversió de tipus de dades
-- Sintaxi: MySQL / MariaDB

-- MySQL / MariaDB
CREATE TABLE historic_temperatura (
    id_lectura  BIGINT      PRIMARY KEY AUTO_INCREMENT,
    id_sensor   VARCHAR(10) NOT NULL,           -- "S00001", "S00002"...
    temperatura VARCHAR(10) NOT NULL,           -- "23.5", " 21.0 ", "-3.2", ""
    correcta    CHAR(1)     NOT NULL DEFAULT 'S',  -- 'S' o 'N'
    `timestamp` VARCHAR(20) NOT NULL            -- "2024-03-15 14:30:00"
);

-- --- Bloc següent ---

-- 1. id_sensor: primer netejar amb UPDATE, després canviar el tipus
UPDATE historic_temperatura
    SET id_sensor = SUBSTRING(id_sensor, 2);

ALTER TABLE historic_temperatura
    MODIFY COLUMN id_sensor INT NOT NULL;
-- MySQL casteja "00001" → 1 implícitament

-- 2. temperatura: TRIM, treure NOT NULL, mapar buides a NULL, canviar tipus
UPDATE historic_temperatura
    SET temperatura = TRIM(temperatura);

ALTER TABLE historic_temperatura
    MODIFY COLUMN temperatura VARCHAR(10) NULL;

UPDATE historic_temperatura
    SET temperatura = NULL
    WHERE temperatura = '';

ALTER TABLE historic_temperatura
    MODIFY COLUMN temperatura DECIMAL(5,2) NULL;

-- 3. correcta: patró "afegir-copiar-substituir"
ALTER TABLE historic_temperatura
    ADD COLUMN correcta_bool BOOLEAN NOT NULL DEFAULT TRUE;

UPDATE historic_temperatura
    SET correcta_bool = (correcta = 'S');

ALTER TABLE historic_temperatura
    DROP COLUMN correcta;

ALTER TABLE historic_temperatura
    CHANGE COLUMN correcta_bool correcta BOOLEAN NOT NULL DEFAULT TRUE;

-- 4. `timestamp` → data_lectura amb canvi de tipus
ALTER TABLE historic_temperatura
    CHANGE COLUMN `timestamp` data_lectura TIMESTAMP NOT NULL;
-- Els valors "2024-03-15 14:30:00" són convertibles directament a TIMESTAMP
