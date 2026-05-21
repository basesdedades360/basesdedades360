-- Exercici resolt 5.4
-- Refactor amb conversió de tipus de dades
-- Sintaxi: PostgreSQL

-- PostgreSQL
CREATE TABLE historic_temperatura (
    id_lectura  BIGINT      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_sensor   VARCHAR(10) NOT NULL,
    temperatura VARCHAR(10) NOT NULL,
    correcta    CHAR(1)     NOT NULL DEFAULT 'S',
    timestamp   VARCHAR(20) NOT NULL
);

-- --- Bloc següent ---

-- 1. id_sensor: extreure la part numèrica i convertir a INT
ALTER TABLE historic_temperatura
    ALTER COLUMN id_sensor TYPE INT
        USING SUBSTRING(id_sensor FROM 2)::int;

-- 2. temperatura: TRIM, buides → NULL, conversió a NUMERIC
ALTER TABLE historic_temperatura
    ALTER COLUMN temperatura TYPE NUMERIC(5,2)
        USING NULLIF(TRIM(temperatura), '')::numeric;

-- 2b. Permetre NULL ara que les cadenes buides s'hi mapen
ALTER TABLE historic_temperatura
    ALTER COLUMN temperatura DROP NOT NULL;

-- 3. correcta: cal eliminar primer el DEFAULT 'S' (incompatible amb BOOLEAN),
--    fer la conversió, i tornar a posar el DEFAULT correcte
ALTER TABLE historic_temperatura
    ALTER COLUMN correcta DROP DEFAULT;

ALTER TABLE historic_temperatura
    ALTER COLUMN correcta TYPE BOOLEAN
        USING (correcta = 'S');

ALTER TABLE historic_temperatura
    ALTER COLUMN correcta SET DEFAULT TRUE;

-- 4. timestamp → data_lectura, com a TIMESTAMPTZ
ALTER TABLE historic_temperatura
    RENAME COLUMN timestamp TO data_lectura;

ALTER TABLE historic_temperatura
    ALTER COLUMN data_lectura TYPE TIMESTAMPTZ
        USING data_lectura::timestamptz;
