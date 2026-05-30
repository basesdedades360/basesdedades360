-- Exercici resolt 6.3
-- PostgreSQL
SELECT
    nom || ' ' || cognoms                       AS nom_complet,
    email,
    email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'           AS email_valid,
    (regexp_match(email, '@(.+)$'))[1]          AS domini,
    regexp_replace(telefon, '[^0-9]', '', 'g')  AS telefon_net,
    telefon ~ '^[67][0-9]{8}$'                  AS mobil_es
FROM   professor
ORDER BY cognoms, nom;
 
