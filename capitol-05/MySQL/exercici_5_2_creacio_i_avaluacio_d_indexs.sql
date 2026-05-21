-- Exercici resolt 5.2
-- Creació i avaluació d'índexs
-- Sintaxi: MySQL / MariaDB

-- MySQL / MariaDB

CREATE TABLE comanda (
  id_comanda   BIGINT        PRIMARY KEY AUTO_INCREMENT,
  referencia   CHAR(12)      UNIQUE NOT NULL,
  id_client    INT           NOT NULL,
  data_comanda DATE          NOT NULL,
  estat        ENUM('pendent','enviada','lliurada','cancel·lada') NOT NULL,
  total        DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_client) REFERENCES client(id_client)
);

-- --- Bloc següent ---

-- MySQL / MariaDB

-- Consulta 1: comandes d'un client ordenades per data (desc)
-- → Índex compost (id_client, data_comanda)
CREATE INDEX idx_comanda_client_data ON comanda(id_client, data_comanda DESC);

-- Consulta 2: estat = 'pendent' AND data_comanda = AVUI
-- → Índex compost (estat, data_comanda)
CREATE INDEX idx_comanda_estat_data ON comanda(estat, data_comanda);

-- Consulta 3: total BETWEEN x AND y
-- → Índex simple (total) per a cerques per rang
CREATE INDEX idx_comanda_total ON comanda(total);

-- Consulta 4: referencia exacta
-- → Ja cobert per l'índex UNIQUE creat automàticament amb la restricció UNIQUE.
--   No cal crear-ne un de nou.

-- També cal recordar que MySQL ja crea automàticament l'índex de id_client
-- per la FK, però el substituïm per l'índex compost de la consulta 1.

-- --- Bloc següent ---

-- MySQL / MariaDB

EXPLAIN SELECT id_comanda, data_comanda, total
FROM comanda
WHERE id_client = 1234
ORDER BY data_comanda DESC;
-- Esperat: type=ref, key=idx_comanda_client_data
