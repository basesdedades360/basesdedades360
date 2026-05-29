-- Exercici resolt 5.1
-- Tria de tipus de dades
-- Sintaxi: MySQL / MariaDB

-- MySQL / MariaDB

CREATE TABLE producte (
  id_producte   INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,
  referencia    CHAR(9)          UNIQUE NOT NULL,
  nom           VARCHAR(200)     NOT NULL,
  descripcio    TEXT,
  preu_venda    DECIMAL(7,2)     NOT NULL CHECK (preu_venda >= 0),
  preu_cost     DECIMAL(7,2)     NOT NULL CHECK (preu_cost  >= 0),
  iva_percent   TINYINT UNSIGNED NOT NULL DEFAULT 21,
  estoc         INT UNSIGNED     NOT NULL DEFAULT 0,
  estoc_minim   INT UNSIGNED     NOT NULL DEFAULT 0,
  pes_kg        DECIMAL(6,3)     CHECK (pes_kg > 0),
  actiu         BOOLEAN          NOT NULL DEFAULT TRUE,
  data_alta     DATE             NOT NULL DEFAULT (CURRENT_DATE),
  ultima_modif  TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                 ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT chk_marges CHECK (preu_venda >= preu_cost)
);
