-- Exercici resolt 6.5
-- Validació i extracció amb expressions regulars
-- Sintaxi: MySQL / MariaDB

SELECT
    CONCAT(nom, ' ', cognoms)                                            AS nom_complet,
    email,
    CASE
        WHEN email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
            THEN 'OK'
        ELSE 'INVÀLID'
    END                                                                   AS email_valid,
    REGEXP_SUBSTR(email, '[^@]+$')                                        AS domini,
    REGEXP_REPLACE(telefon, '[^0-9]', '')                                 AS telefon_net,
    CASE
        WHEN REGEXP_REPLACE(telefon, '[^0-9]', '') REGEXP '^[67][0-9]{8}$'
            THEN 'Sí'
        ELSE 'No'
    END                                                                   AS mobil_es
FROM   professor
ORDER BY cognoms, nom;
