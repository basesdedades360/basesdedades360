-- Exercici resolt 5.1
-- Tria de tipus de dades
-- Sintaxi: PostgreSQL

-- PostgreSQL

CREATE TABLE producte (
  -- GENERATED AS IDENTITY: equivalent modern a SERIAL (SQL estàndard)
  id_producte   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

  -- CHAR(9): format de longitud fixa
  referencia    CHAR(9)        UNIQUE NOT NULL,

  -- VARCHAR(200)
  nom           VARCHAR(200)   NOT NULL,

  -- TEXT: sense límit pràctic
  descripcio    TEXT,

  -- NUMERIC(7,2): equivalent a DECIMAL(7,2)
  preu_venda    NUMERIC(7,2)   NOT NULL CHECK (preu_venda >= 0),
  preu_cost     NUMERIC(7,2)   NOT NULL CHECK (preu_cost  >= 0),

  -- SMALLINT: PostgreSQL no té TINYINT. 0-255 cap en un SMALLINT.
  iva_percent   SMALLINT       NOT NULL DEFAULT 21
                               CHECK (iva_percent IN (0,4,10,21)),

  -- INT + CHECK per imposar "no negatiu" (no hi ha UNSIGNED)
  estoc         INT            NOT NULL DEFAULT 0 CHECK (estoc >= 0),
  estoc_minim   INT            NOT NULL DEFAULT 0 CHECK (estoc_minim >= 0),

  -- NUMERIC(6,3)
  pes_kg        NUMERIC(6,3)   CHECK (pes_kg > 0),

  -- BOOLEAN natiu
  actiu         BOOLEAN        NOT NULL DEFAULT TRUE,

  -- DATE
  data_alta     DATE           NOT NULL DEFAULT CURRENT_DATE,

  -- TIMESTAMPTZ + trigger (més avall)
  ultima_modif  TIMESTAMPTZ    NOT NULL DEFAULT NOW(),

  CONSTRAINT chk_marges CHECK (preu_venda >= preu_cost)
);

-- Trigger per emular ON UPDATE CURRENT_TIMESTAMP
CREATE OR REPLACE FUNCTION fn_producte_touch()
RETURNS TRIGGER AS $$
BEGIN
  NEW.ultima_modif := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_producte_touch
BEFORE UPDATE ON producte
FOR EACH ROW EXECUTE FUNCTION fn_producte_touch();
