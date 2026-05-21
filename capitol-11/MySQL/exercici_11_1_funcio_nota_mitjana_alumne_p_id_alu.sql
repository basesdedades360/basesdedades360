-- Exercici resolt 11.1
-- Funció `nota_mitjana_alumne(p_id_alumne)` amb validació
-- Sintaxi: MySQL / MariaDB

DELIMITER //

CREATE FUNCTION nota_mitjana_alumne(p_id_alumne INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_existeix  INT DEFAULT 0;
    DECLARE v_mitjana   DECIMAL(4,2);

    -- 1) Comprovar que l'alumne existeix
    SELECT COUNT(*) INTO v_existeix
      FROM alumne
     WHERE id_alumne = p_id_alumne;

    IF v_existeix = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Alumne inexistent';
    END IF;

    -- 2) Calcular la mitjana (només files amb nota)
    SELECT ROUND(AVG(nota_final), 2)
      INTO v_mitjana
      FROM matricula
     WHERE id_alumne = p_id_alumne
       AND nota_final IS NOT NULL;

    -- 3) Si no hi ha cap nota, retornem NULL deliberadament
    RETURN v_mitjana;
END //

DELIMITER ;

-- ============================================================
-- COMPROVACIÓ
-- ============================================================

-- Cas normal
SELECT nota_mitjana_alumne(1) AS mitjana_alumne_1;

-- Llistat top 10 d'alumnes per mitjana
SELECT a.id_alumne,
       CONCAT(a.nom, ' ', a.cognoms)        AS alumne,
       nota_mitjana_alumne(a.id_alumne)     AS mitjana
FROM   alumne a
HAVING mitjana IS NOT NULL
ORDER BY mitjana DESC
LIMIT 10;

-- Cas error: alumne inexistent
-- SELECT nota_mitjana_alumne(99999);
-- ERROR 1644 (45000): Alumne inexistent
