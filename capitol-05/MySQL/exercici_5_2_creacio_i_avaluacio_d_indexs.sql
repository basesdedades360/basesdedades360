-- Exercici resolt 5.2
-- Creació i avaluació d'índexs
-- Sintaxi: MySQL / MariaDB


CREATE TABLE comanda (
  id_comanda   BIGINT        PRIMARY KEY AUTO_INCREMENT,
  referencia   CHAR(12)      UNIQUE NOT NULL,
  id_client    INT           NOT NULL,
  data_comanda DATE          NOT NULL,
  estat        ENUM('pendent','enviada','lliurada','cancel·lada') NOT NULL,
  total        DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_client) REFERENCES client(id_client)
);

---- ---------------------------------------------------------------------------------
--  1
CREATE INDEX idx_comanda_client_data ON comanda(id_client, data_comanda DESC);

-- 2
CREATE INDEX idx_comanda_estat_data ON comanda(estat, data_comanda);

-- 3
CREATE INDEX idx_comanda_total ON comanda(total);

--  4
--   No cal crear-ne un de nou. Ja està cobert per l'índex UNIQUE creat automàticament amb la restricció UNIQUE.


-- ---------------------------------------------------------------------------------

EXPLAIN SELECT id_comanda, data_comanda, total
FROM comanda
WHERE id_client = 1234
ORDER BY data_comanda DESC;
