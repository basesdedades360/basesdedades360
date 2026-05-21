-- Exercici resolt 11.2
-- Procediment `matricular_alumne(p_id_alumne, p_id_modul, p_convocatoria)`
-- amb validacions, transacció i propagació d'errors.
-- Sintaxi: MySQL / MariaDB

DELIMITER //

CREATE PROCEDURE matricular_alumne(
    IN p_id_alumne    INT,
    IN p_id_modul     SMALLINT UNSIGNED,
    IN p_convocatoria TINYINT UNSIGNED
)
BEGIN
    DECLARE v_existeix INT;

    -- Handler per a errors no previstos: rollback + propagació
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- (1) Validació del rang de convocatòria
    IF p_convocatoria NOT IN (1, 2, 3) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Convocatòria invàlida (ha de ser 1, 2 o 3)';
    END IF;

    START TRANSACTION;

    -- (2) Existència de l'alumne (bloquegem la fila)
    SELECT COUNT(*) INTO v_existeix
      FROM alumne
     WHERE id_alumne = p_id_alumne
     FOR UPDATE;

    IF v_existeix = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Alumne inexistent';
    END IF;

    -- (3) Existència del mòdul (bloquegem la fila)
    SELECT COUNT(*) INTO v_existeix
      FROM modul
     WHERE id_modul = p_id_modul
     FOR UPDATE;

    IF v_existeix = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Mòdul inexistent';
    END IF;

    -- (4) Comprovació de matrícula prèvia
    SELECT COUNT(*) INTO v_existeix
      FROM matricula
     WHERE id_alumne    = p_id_alumne
       AND id_modul     = p_id_modul
       AND convocatoria = p_convocatoria;

    IF v_existeix > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Matrícula duplicada per a aquesta convocatòria';
    END IF;

    -- (5) Inserció
    INSERT INTO matricula (id_alumne, id_modul, convocatoria, nota_final)
    VALUES (p_id_alumne, p_id_modul, p_convocatoria, NULL);

    COMMIT;
END //

DELIMITER ;

-- ============================================================
-- COMPROVACIÓ
-- ============================================================

-- Cas normal
-- CALL matricular_alumne(1, 5, 1);

-- Cas convocatòria invàlida
-- CALL matricular_alumne(1, 5, 9);
-- ERROR 1644 (45000): Convocatòria invàlida (ha de ser 1, 2 o 3)

-- Cas alumne inexistent
-- CALL matricular_alumne(99999, 5, 1);
-- ERROR 1644 (45000): Alumne inexistent

-- Cas duplicat
-- CALL matricular_alumne(1, 5, 1);
-- ERROR 1644 (45000): Matrícula duplicada per a aquesta convocatòria
