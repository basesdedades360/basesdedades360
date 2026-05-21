-- Exercici resolt 5.1
-- Tria de tipus de dades
-- Sintaxi: MySQL / MariaDB

-- MySQL / MariaDB

CREATE TABLE producte (
  -- INT AUTO_INCREMENT: identificador artificial, rang suficient per a milions de productes
  id_producte   INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,

  -- CHAR(9): longitud sempre fixa (REF-XXXXX = exactament 9 caràcters)
  referencia    CHAR(9)          UNIQUE NOT NULL,

  -- VARCHAR(200): longitud variable
  nom           VARCHAR(200)     NOT NULL,

  -- TEXT: descripció llarga, sense límit pràctic
  descripcio    TEXT,

  -- DECIMAL(7,2): fins a 9.999,99 → 7 dígits totals, 2 decimals. Mai FLOAT per a diners
  preu_venda    DECIMAL(7,2)     NOT NULL CHECK (preu_venda >= 0),
  preu_cost     DECIMAL(7,2)     NOT NULL CHECK (preu_cost  >= 0),

  -- TINYINT UNSIGNED: valors discrets (0,4,10,21). Cap supera 255.
  iva_percent   TINYINT UNSIGNED NOT NULL DEFAULT 21,

  -- INT UNSIGNED: estoc no pot ser negatiu
  estoc         INT UNSIGNED     NOT NULL DEFAULT 0,
  estoc_minim   INT UNSIGNED     NOT NULL DEFAULT 0,

  -- DECIMAL(6,3): fins a 999,999 kg
  pes_kg        DECIMAL(6,3)     CHECK (pes_kg > 0),

  -- BOOLEAN (= TINYINT(1))
  actiu         BOOLEAN          NOT NULL DEFAULT TRUE,

  -- DATE: sols data
  data_alta     DATE             NOT NULL DEFAULT (CURRENT_DATE),

  -- TIMESTAMP ON UPDATE: s'actualitza automàticament
  ultima_modif  TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                 ON UPDATE CURRENT_TIMESTAMP,

  -- El preu de venda ha de ser >= cost (marge positiu o zero)
  CONSTRAINT chk_marges CHECK (preu_venda >= preu_cost)
);
