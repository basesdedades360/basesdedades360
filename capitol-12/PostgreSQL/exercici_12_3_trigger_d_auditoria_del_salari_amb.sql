-- Exercici resolt 12.3
-- Trigger d'auditoria del salari amb límit de rebaixa
-- Sintaxi: PostgreSQL

CREATE OR REPLACE FUNCTION fn_validar_rebaixa_max()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.salari < OLD.salari * 0.90 THEN
        RAISE EXCEPTION 'No es permet una rebaixa salarial superior al 10%%';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_professor_validar_rebaixa
BEFORE UPDATE ON professor
FOR EACH ROW
EXECUTE FUNCTION fn_validar_rebaixa_max();

-- --- Bloc següent ---

-- Suposem que el professor 1 té salari 3000
UPDATE professor SET salari = 3200 WHERE id_prof = 1;
-- ✅ OK: registrat a auditoria_salari

UPDATE professor SET salari = 3500 WHERE id_prof = 1;
-- ✅ OK: nou registre a auditoria_salari

UPDATE professor SET salari = 3100 WHERE id_prof = 1;
-- 3500 * 0.90 = 3150 → 3100 < 3150 → falla!
-- ERROR: No es permet una rebaixa salarial superior al 10%

UPDATE professor SET nom = 'Marc' WHERE id_prof = 1;
-- ✅ OK: el salari no canvia, l'AFTER UPDATE no insereix res a auditoria
--      (perquè la condició OLD.salari <> NEW.salari és falsa)

-- Veure l'historial:
SELECT * FROM auditoria_salari WHERE id_prof = 1 ORDER BY moment;
