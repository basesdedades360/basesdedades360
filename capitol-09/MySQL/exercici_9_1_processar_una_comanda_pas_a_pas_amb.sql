-- Exercici resolt 9.1
-- Processar una comanda pas a pas amb transacció
-- Sintaxi: MySQL / MariaDB

CREATE TABLE IF NOT EXISTS producte_botiga (
  id_producte INT          PRIMARY KEY AUTO_INCREMENT,
  nom         VARCHAR(200) NOT NULL,
  estoc       INT UNSIGNED NOT NULL DEFAULT 0,
  preu        DECIMAL(8,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS comanda_botiga (
  id_comanda  INT       PRIMARY KEY AUTO_INCREMENT,
  id_client   INT       NOT NULL,
  data_cmd    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  total       DECIMAL(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS linia_botiga (
  id_comanda  INT            NOT NULL,
  id_producte INT            NOT NULL,
  quantitat   INT UNSIGNED   NOT NULL,
  preu_unit   DECIMAL(8,2)   NOT NULL,
  PRIMARY KEY (id_comanda, id_producte),
  FOREIGN KEY (id_comanda)  REFERENCES comanda_botiga(id_comanda),
  FOREIGN KEY (id_producte) REFERENCES producte_botiga(id_producte)
);

-- Dades de prova
INSERT INTO producte_botiga (nom, estoc, preu) VALUES
  ('Llibre BD',  10, 25.00),
  ('Calculadora', 5, 12.50),
  ('Bolígraf',    50, 1.20);

-- --- Bloc següent ---

-- ============================================================
--  COMANDA: client 1, items = [(producte 1, qty 2), (producte 2, qty 1)]
--  Patró: validar → crear capçalera → afegir línies → totalitzar → decidir
-- ============================================================

BEGIN;

-- ════════════════════════════════════════════════════════════
-- FASE 1: Validar estoc de tots els productes (amb FOR UPDATE)
-- ════════════════════════════════════════════════════════════

-- 1.1) Producte 1: necessitem 2 unitats
SELECT id_producte, nom, estoc, preu
FROM   producte_botiga
WHERE  id_producte = 1
FOR UPDATE;
-- 👁️ Mira el resultat:
--    · Si NO retorna fila → producte no existeix → ROLLBACK al final
--    · Si estoc < 2       → estoc insuficient    → ROLLBACK al final
--    · Si estoc >= 2      → continuem (apunta't el preu, el necessitaràs)

-- 1.2) Producte 2: necessitem 1 unitat
SELECT id_producte, nom, estoc, preu
FROM   producte_botiga
WHERE  id_producte = 2
FOR UPDATE;
-- 👁️ Mateixes comprovacions que abans.

-- ════════════════════════════════════════════════════════════
-- FASE 2: Crear la capçalera de la comanda
-- ════════════════════════════════════════════════════════════
INSERT INTO comanda_botiga (id_client, total) VALUES (1, 0);

-- Necessitem l'id de la comanda recentment creada
SELECT LAST_INSERT_ID() AS id_comanda;     -- MySQL
-- A PostgreSQL: usa RETURNING:
-- INSERT INTO comanda_botiga (id_client, total) VALUES (1, 0) RETURNING id_comanda;

-- 👁️ Apunta't el id_comanda obtingut. Suposem que és 1001.

-- ════════════════════════════════════════════════════════════
-- FASE 3: Afegir línies i descomptar estoc
-- ════════════════════════════════════════════════════════════

-- 3.1) Línia del producte 1 (2 unitats × preu)
INSERT INTO linia_botiga (id_comanda, id_producte, quantitat, preu_unit)
SELECT 1001, id_producte, 2, preu
FROM   producte_botiga
WHERE  id_producte = 1;

UPDATE producte_botiga
SET    estoc = estoc - 2
WHERE  id_producte = 1;

-- 3.2) Línia del producte 2 (1 unitat × preu)
INSERT INTO linia_botiga (id_comanda, id_producte, quantitat, preu_unit)
SELECT 1001, id_producte, 1, preu
FROM   producte_botiga
WHERE  id_producte = 2;

UPDATE producte_botiga
SET    estoc = estoc - 1
WHERE  id_producte = 2;

-- ════════════════════════════════════════════════════════════
-- FASE 4: Calcular i actualitzar el total de la comanda
-- ════════════════════════════════════════════════════════════
UPDATE comanda_botiga
SET    total = (
         SELECT SUM(quantitat * preu_unit)
         FROM   linia_botiga
         WHERE  id_comanda = 1001
       )
WHERE  id_comanda = 1001;

-- ════════════════════════════════════════════════════════════
-- FASE 5: Verificació final i decisió COMMIT/ROLLBACK
-- ════════════════════════════════════════════════════════════
SELECT c.id_comanda, c.id_client, c.total,
       l.id_producte, l.quantitat, l.preu_unit
FROM   comanda_botiga c
JOIN   linia_botiga l ON l.id_comanda = c.id_comanda
WHERE  c.id_comanda = 1001;
-- 👁️ Mira el resultat:
--    · Total > 0
--    · Dues línies (productes 1 i 2)
--    · Estoc descomptat correctament
-- Si tot quadra → COMMIT
-- Si has detectat qualsevol problema en CUALSEVOL fase anterior → ROLLBACK

COMMIT;
-- ROLLBACK;
