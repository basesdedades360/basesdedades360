-- Exercici resolt 6.3
-- Funcions integrades en una sola consulta
-- Sintaxi: PostgreSQL

SELECT
    UPPER(nom || ' ' || cognoms)                                            AS nom_complet,
    LEFT(nom, 1) || '. ' || UPPER(cognoms)                                  AS inicial_cognom,
    CHAR_LENGTH(email)                                                      AS llargada_email,
    SUBSTRING(email FROM POSITION('@' IN email) + 1)                        AS domini,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_naix))::INT                    AS edat,
    TO_CHAR(data_naix, 'DD/MM/YYYY')                                        AS data_naix_local,
    CASE
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_naix)) >= 18 THEN 'Major'
        ELSE                                                            'Menor'
    END                                                                     AS estat_civil
FROM alumne
WHERE data_naix IS NOT NULL
ORDER BY edat DESC;
