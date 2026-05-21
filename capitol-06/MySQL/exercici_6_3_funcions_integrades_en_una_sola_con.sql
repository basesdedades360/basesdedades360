-- Exercici resolt 6.3
-- Funcions integrades en una sola consulta
-- Sintaxi: MySQL / MariaDB

SELECT
    UPPER(CONCAT(nom, ' ', cognoms))                                   AS nom_complet,
    CONCAT(LEFT(nom, 1), '. ', UPPER(cognoms))                         AS inicial_cognom,
    CHAR_LENGTH(email)                                                 AS llargada_email,
    SUBSTRING(email, INSTR(email, '@') + 1)                            AS domini,
    TIMESTAMPDIFF(YEAR, data_naix, CURDATE())                          AS edat,
    DATE_FORMAT(data_naix, '%d/%m/%Y')                                 AS data_naix_local,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, data_naix, CURDATE()) >= 18 THEN 'Major'
        ELSE                                                       'Menor'
    END                                                                 AS estat_civil
FROM alumne
WHERE data_naix IS NOT NULL
ORDER BY edat DESC;
