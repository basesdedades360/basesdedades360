-- Exercici resolt 5.1
-- Tria de tipus de dades
-- Sintaxi: PostgreSQL



CREATE TABLE producte (
   id_producte   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  referencia    CHAR(9)        UNIQUE NOT NULL,
  nom           VARCHAR(200)   NOT NULL,
  descripcio    TEXT,
  preu_venda    NUMERIC(7,2)   NOT NULL CHECK (preu_venda >= 0),
  preu_cost     NUMERIC(7,2)   NOT NULL CHECK (preu_cost  >= 0),
  iva_percent   SMALLINT       NOT NULL DEFAULT 21
                               CHECK (iva_percent IN (0,4,10,21)),
  estoc         INT            NOT NULL DEFAULT 0 CHECK (estoc >= 0),
  estoc_minim   INT            NOT NULL DEFAULT 0 CHECK (estoc_minim >= 0),
  pes_kg        NUMERIC(6,3)   CHECK (pes_kg > 0),
  actiu         BOOLEAN        NOT NULL DEFAULT TRUE,
  data_alta     DATE           NOT NULL DEFAULT CURRENT_DATE,
  ultima_modif  TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
  CONSTRAINT chk_marges CHECK (preu_venda >= preu_cost)
);

-- Els veurem al capítol 10, així que encara no els coneixes. No et preocupis i no facis cas
-- Afegeixo com es faria per emular ON UPDATE CURRENT_TIMESTAMP amb un trigger
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
