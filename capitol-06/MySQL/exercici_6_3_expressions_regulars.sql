-- Exercici resolt 6.3
-- MySQL / MariaDB
SELECT
    CONCAT(nom, ' ', cognoms)              AS nom_complet,
    email,
    email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'     AS email_valid,
    REGEXP_SUBSTR(email, '[^@]+$')         AS domini,
    REGEXP_REPLACE(telefon, '[^0-9]', '')  AS telefon_net,
    telefon REGEXP '^[67][0-9]{8}$'        AS mobil_es
FROM   professor
ORDER BY cognoms, nom;
