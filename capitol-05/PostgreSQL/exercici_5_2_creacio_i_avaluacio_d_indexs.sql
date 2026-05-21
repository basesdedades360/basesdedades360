-- Exercici resolt 5.2
-- Creació i avaluació d'índexs
-- Sintaxi: PostgreSQL

-- PostgreSQL

CREATE TYPE estat_comanda_t AS ENUM ('pendent','enviada','lliurada','cancel·lada');

CREATE TABLE comanda (
  id_comanda   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  referencia   CHAR(12)        UNIQUE NOT NULL,
  id_client    INT             NOT NULL REFERENCES client(id_client),
  data_comanda DATE            NOT NULL,
  estat        estat_comanda_t NOT NULL,
  total        NUMERIC(10,2)   NOT NULL
);

-- --- Bloc següent ---

-- PostgreSQL

-- IMPORTANT: a PostgreSQL, la FK sobre id_client NO crea índex automàticament.
-- L'índex compost (id_client, data_comanda) ja cobreix aquest cas.

-- Consulta 1
CREATE INDEX idx_comanda_client_data ON comanda(id_client, data_comanda DESC);

-- Consulta 2: aprofitem un índex PARCIAL (només files amb estat='pendent')
-- Això és una optimització exclusiva de PostgreSQL:
CREATE INDEX idx_comanda_pendents ON comanda(data_comanda)
  WHERE estat = 'pendent';
-- Alternativa "clàssica" compatible:
-- CREATE INDEX idx_comanda_estat_data ON comanda(estat, data_comanda);

-- Consulta 3: cerques per rang
CREATE INDEX idx_comanda_total ON comanda(total);

-- Consulta 4: ja cobert per UNIQUE de referencia.

-- --- Bloc següent ---

-- PostgreSQL

EXPLAIN ANALYZE SELECT id_comanda, data_comanda, total
FROM comanda
WHERE id_client = 1234
ORDER BY data_comanda DESC;
-- Esperat: Index Scan using idx_comanda_client_data on comanda
