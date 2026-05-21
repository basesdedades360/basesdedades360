-- Exercici resolt 11.3
-- Triggers d'auditoria del salari del professor amb validació
-- de rebaixes superiors al 10%.
-- Sintaxi: MySQL / MariaDB

-- ============================================================
-- PAS 1 — Taula d'auditoria
-- ============================================================

CREATE TABLE IF NOT EXISTS auditoria_salari (
    id_auditoria INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_prof      SMALLINT UNSIGNED NOT NULL,
    salari_antic DECIMAL(8,2) NOT NULL,
    salari_nou   DECIMAL(8,2) NOT NULL,
    usuari       VARCHAR(100) NOT NULL,
    moment       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_prof) REFERENCES professor(id_prof)
);

-- ============================================================
-- PAS 2 — Trigger BEFORE UPDATE per a la validació
--          (rebaixes superiors al 10%)
-- ============================================================

DELIMITER //

CREATE TRIGGER trg_professor_validar_rebaixa
BEFORE UPDATE ON professor
FOR EACH ROW
BEGIN
    IF NEW.salari < OLD.salari * 0.90 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No es permet una rebaixa salarial superior al 10%';
    END IF;
END //

DELIMITER ;

-- ============================================================
-- PAS 3 — Trigger AFTER UPDATE per a l'auditoria
--          (només si canvia el salari)
-- ============================================================

DELIMITER //

CREATE TRIGGER trg_auditoria_salari
AFTER UPDATE ON professor
FOR EACH ROW
BEGIN
    IF OLD.salari <> NEW.salari THEN
        INSERT INTO auditoria_salari
            (id_prof, salari_antic, salari_nou, usuari)
        VALUES
            (NEW.id_prof, OLD.salari, NEW.salari, CURRENT_USER());
    END IF;
END //

DELIMITER ;

-- ============================================================
-- COMPROVACIÓ
-- ============================================================

-- Canvi acceptable: registrat a auditoria
-- UPDATE professor SET salari = 3200 WHERE id_prof = 1;

-- Canvi acceptable (segon registre)
-- UPDATE professor SET salari = 3500 WHERE id_prof = 1;

-- Rebaixa massa gran (3500 -> 3100, més del 10%)
-- UPDATE professor SET salari = 3100 WHERE id_prof = 1;
-- ERROR 1644 (45000): No es permet una rebaixa salarial superior al 10%

-- Canvi d'un altre camp: no afecta l'auditoria
-- UPDATE professor SET nom = 'Marc' WHERE id_prof = 1;

-- Veure historial
-- SELECT * FROM auditoria_salari WHERE id_prof = 1 ORDER BY moment;
