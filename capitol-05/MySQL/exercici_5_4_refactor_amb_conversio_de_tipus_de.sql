-- Exercici resolt 5.4
-- Refactor amb conversió de tipus de dades
-- Sintaxi: MySQL / MariaDB


CREATE TABLE historic_temperatura (
    id_lectura  BIGINT      PRIMARY KEY AUTO_INCREMENT,
    id_sensor   VARCHAR(10) NOT NULL,          
    temperatura VARCHAR(10) NOT NULL,
    correcta    CHAR(1)     NOT NULL DEFAULT 'S',
    `timestamp` VARCHAR(20) NOT NULL
);



-- 1
UPDATE historic_temperatura
    SET id_sensor = SUBSTRING(id_sensor, 2);

ALTER TABLE historic_temperatura
    MODIFY COLUMN id_sensor INT NOT NULL;

-- 2
UPDATE historic_temperatura
    SET temperatura = TRIM(temperatura);

ALTER TABLE historic_temperatura
    MODIFY COLUMN temperatura VARCHAR(10) NULL;

UPDATE historic_temperatura
    SET temperatura = NULL
    WHERE temperatura = '';

ALTER TABLE historic_temperatura
    MODIFY COLUMN temperatura DECIMAL(5,2) NULL;

-- 3
ALTER TABLE historic_temperatura
    ADD COLUMN correcta_bool BOOLEAN NOT NULL DEFAULT TRUE;

UPDATE historic_temperatura
    SET correcta_bool = (correcta = 'S');

ALTER TABLE historic_temperatura
    DROP COLUMN correcta;

ALTER TABLE historic_temperatura
    CHANGE COLUMN correcta_bool correcta BOOLEAN NOT NULL DEFAULT TRUE;

-- 4
ALTER TABLE historic_temperatura
    CHANGE COLUMN `timestamp` data_lectura TIMESTAMP NOT NULL;
