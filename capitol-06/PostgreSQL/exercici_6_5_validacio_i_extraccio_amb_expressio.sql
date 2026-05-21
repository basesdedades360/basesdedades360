-- Exercici resolt 6.5
-- Validació i extracció amb expressions regulars
-- Sintaxi: PostgreSQL

SELECT
    nom || ' ' || cognoms                                                 AS nom_complet,
    email,
    CASE
        WHEN email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
            THEN 'OK'
        ELSE 'INVÀLID'
    END                                                                   AS email_valid,
    (regexp_match(email, '@(.+)$'))[1]                                    AS domini,
    regexp_replace(telefon, '[^0-9]', '', 'g')                            AS telefon_net,
    CASE
        WHEN regexp_replace(telefon, '[^0-9]', '', 'g') ~ '^[67][0-9]{8}$'
            THEN 'Sí'
        ELSE 'No'
    END                                                                   AS mobil_es
FROM   professor
ORDER BY cognoms, nom;
