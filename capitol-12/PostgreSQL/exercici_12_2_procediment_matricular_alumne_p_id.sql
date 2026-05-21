-- Exercici resolt 12.2
-- Procediment `matricular_alumne(p_id_alumne, p_id_modul, p_convocatoria)`
-- Sintaxi: PostgreSQL

CREATE OR REPLACE PROCEDURE matricular_alumne(
    IN p_id_alumne     INT,
    IN p_id_modul      SMALLINT,
    IN p_convocatoria  SMALLINT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_existeix INT;
BEGIN
    -- (1) Validació del rang de convocatòria
    IF p_convocatoria NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Convocatòria invàlida (ha de ser 1, 2 o 3)';
    END IF;
    
    -- Bloc protegit amb gestor d'excepcions
    BEGIN
        -- (2) Existència de l'alumne
        SELECT COUNT(*) INTO v_existeix
          FROM alumne
         WHERE id_alumne = p_id_alumne
         FOR UPDATE;
        
        IF v_existeix = 0 THEN
            RAISE EXCEPTION 'Alumne inexistent';
        END IF;
        
        -- (3) Existència del mòdul
        SELECT COUNT(*) INTO v_existeix
          FROM modul
         WHERE id_modul = p_id_modul
         FOR UPDATE;
        
        IF v_existeix = 0 THEN
            RAISE EXCEPTION 'Mòdul inexistent';
        END IF;
        
        -- (4) Comprovació de matrícula prèvia
        SELECT COUNT(*) INTO v_existeix
          FROM matricula
         WHERE id_alumne    = p_id_alumne
           AND id_modul     = p_id_modul
           AND convocatoria = p_convocatoria;
        
        IF v_existeix > 0 THEN
            RAISE EXCEPTION 'Matrícula duplicada per a aquesta convocatòria';
        END IF;
        
        -- (5) Inserció
        INSERT INTO matricula (id_alumne, id_modul, convocatoria, nota_final)
        VALUES (p_id_alumne, p_id_modul, p_convocatoria, NULL);
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;        -- propaga l'excepció original
    END;
END;
$$;

-- --- Bloc següent ---

-- Cas normal
CALL matricular_alumne(1, 5, 1);

-- Cas convocatòria invàlida
CALL matricular_alumne(1, 5, 9);
-- ERROR: Convocatòria invàlida (ha de ser 1, 2 o 3)

-- Cas alumne inexistent
CALL matricular_alumne(99999, 5, 1);
-- ERROR: Alumne inexistent

-- Cas duplicat (després d'haver-ho fet una vegada)
CALL matricular_alumne(1, 5, 1);
-- ERROR: Matrícula duplicada per a aquesta convocatòria
