-- Exercici resolt 9.2
-- Anàlisi de problemes de concurrència
-- Sintaxi: PostgreSQL

-- Solució amb FOR UPDATE
BEGIN;
SELECT seients_disponibles FROM vol WHERE id_vol = 123 FOR UPDATE;
-- 👁️ Si seients_disponibles >= 2 → continuem amb la reserva
-- 👁️ Si no → ROLLBACK
UPDATE vol SET seients_disponibles = seients_disponibles - 2 WHERE id_vol = 123;
INSERT INTO reserva ...;
COMMIT;

-- --- Bloc següent ---

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
-- Totes les lectures de l'informe veuran un snapshot consistent
SELECT SUM(import) FROM venda WHERE data = CURDATE();
SELECT * FROM venda WHERE data = CURDATE();  -- coherent amb la suma anterior
COMMIT;
