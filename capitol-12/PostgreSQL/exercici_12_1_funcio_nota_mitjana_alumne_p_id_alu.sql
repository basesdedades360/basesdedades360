-- Exercici resolt 12.1
-- Funció `nota_mitjana_alumne(p_id_alumne)` amb validació
-- Sintaxi: PostgreSQL

CREATE OR REPLACE FUNCTION nota_mitjana_alumne(p_id_alumne INT)
RETURNS NUMERIC(4,2)
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_existeix INT := 0;
    v_mitjana  NUMERIC(4,2);
BEGIN
    -- 1) Comprovar que l'alumne existeix
    SELECT COUNT(*) INTO v_existeix
      FROM alumne
     WHERE id_alumne = p_id_alumne;
    
    IF v_existeix = 0 THEN
        RAISE EXCEPTION 'Alumne inexistent' USING ERRCODE = '45000';
    END IF;
    
    -- 2) Calcular la mitjana (només files amb nota)
    SELECT ROUND(AVG(nota_final), 2)::NUMERIC(4,2)
      INTO v_mitjana
      FROM matricula
     WHERE id_alumne = p_id_alumne
       AND nota_final IS NOT NULL;
    
    -- 3) Si no hi ha cap nota, retornem NULL deliberadament
    RETURN v_mitjana;
END;
$$;

-- --- Bloc següent ---

-- Cas normal
SELECT nota_mitjana_alumne(1) AS mitjana_alumne_1;

-- Llistat top 10 d'alumnes per mitjana
SELECT a.id_alumne,
       a.nom || ' ' || a.cognoms          AS alumne,
       nota_mitjana_alumne(a.id_alumne)   AS mitjana
FROM   alumne a
WHERE  nota_mitjana_alumne(a.id_alumne) IS NOT NULL
ORDER BY mitjana DESC
LIMIT 10;

-- Cas error: alumne inexistent
SELECT nota_mitjana_alumne(99999);
-- ERROR: Alumne inexistent
