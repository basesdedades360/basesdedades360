-- Exercici resolt 9.3 (versió Institut)
-- Provocar i evitar un deadlock reassignant mòduls a professors
-- Sintaxi: MySQL / MariaDB

BEGIN;
-- Sempre bloqueja primer el menor i després el major,
-- independentment de l'ordre en què t'arribin els paràmetres.
SELECT * FROM modul WHERE id_modul = LEAST(:id_a, :id_b)    FOR UPDATE;
SELECT * FROM modul WHERE id_modul = GREATEST(:id_a, :id_b) FOR UPDATE;

-- Ara ja pots fer els UPDATEs en l'ordre que vulguis,
-- les files ja estan totes bloquejades en l'ordre correcte.
UPDATE modul SET id_prof = :nou_prof_a WHERE id_modul = :id_a;
UPDATE modul SET id_prof = :nou_prof_b WHERE id_modul = :id_b;

COMMIT;
