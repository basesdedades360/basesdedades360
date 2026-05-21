-- Exercici resolt 6.6
-- Auditoria de la qualitat de les dades textuals amb expressions regulars
-- Sintaxi: MySQL / MariaDB 8.0+
--
-- Objectiu: localitzar registres "sospitosos" a la base de dades 'institut'
-- que no segueixen els formats esperats:
--   - Emails d'alumne: han d'acabar en @alumnes.cat
--   - Emails de professor: han d'acabar en @institut.cat
--   - Telèfons: 9 dígits que comencen per 6 o 7
--   - Codis de mòdul: 3 lletres majúscules + 3 dígits (format XXX###)

USE institut;

-- ============================================================
-- PART 1 - Detectar problemes per taula (consultes individuals)
-- ============================================================

-- 1. Emails d'alumnes que NO acaben en @alumnes.cat
SELECT id_alumne, nom, cognoms, email
FROM   alumne
WHERE  NOT REGEXP_LIKE(email, '@alumnes\\.cat$');

-- 2. Emails de professors que NO acaben en @institut.cat
SELECT id_prof, nom, cognoms, email
FROM   professor
WHERE  NOT REGEXP_LIKE(email, '@institut\\.cat$');

-- 3. Telèfons amb format incorrecte (només els no nuls)
SELECT 'alumne' AS taula, id_alumne AS id, telefon
FROM   alumne
WHERE  telefon IS NOT NULL
  AND  NOT REGEXP_LIKE(telefon, '^[67][0-9]{8}$')
UNION ALL
SELECT 'professor', id_prof, telefon
FROM   professor
WHERE  telefon IS NOT NULL
  AND  NOT REGEXP_LIKE(telefon, '^[67][0-9]{8}$');

-- 4. Codis de mòdul que no segueixen XXX###
SELECT id_modul, codi, nom_modul
FROM   modul
WHERE  NOT REGEXP_LIKE(codi, '^[A-Z]{3}[0-9]{3}$');

-- ============================================================
-- PART 2 - Informe únic consolidat amb UNION ALL
-- ============================================================
-- Genera una llista unificada de tots els registres sospitosos,
-- indicant la taula, l'identificador, el camp i el valor.

SELECT 'alumne'    AS taula, id_alumne AS id,
       'email'     AS camp,  email     AS valor
FROM   alumne
WHERE  NOT REGEXP_LIKE(email, '@alumnes\\.cat$')

UNION ALL

SELECT 'professor', id_prof,
       'email',     email
FROM   professor
WHERE  NOT REGEXP_LIKE(email, '@institut\\.cat$')

UNION ALL

SELECT 'alumne',    id_alumne,
       'telefon',   telefon
FROM   alumne
WHERE  telefon IS NOT NULL
  AND  NOT REGEXP_LIKE(telefon, '^[67][0-9]{8}$')

UNION ALL

SELECT 'professor', id_prof,
       'telefon',   telefon
FROM   professor
WHERE  telefon IS NOT NULL
  AND  NOT REGEXP_LIKE(telefon, '^[67][0-9]{8}$')

UNION ALL

SELECT 'modul',     id_modul,
       'codi',      codi
FROM   modul
WHERE  NOT REGEXP_LIKE(codi, '^[A-Z]{3}[0-9]{3}$')

ORDER BY taula, id;

-- ============================================================
-- COMENTARIS CLAU
-- ============================================================
-- * NOT REGEXP_LIKE inverteix la coincidència: ens dona els registres
--   que NO compleixen el patró, és a dir, les anomalies.
-- * NULL no compleix cap regex: per això, quan és rellevant (telefon),
--   afegim 'IS NOT NULL' al WHERE per excloure'l explícitament.
-- * A MySQL, dins de cadenes literals, el punt s'escapa amb DOBLE barra:
--   '@alumnes\\.cat$'. A PostgreSQL una sola barra.
-- * UNION ALL preserva els duplicats (cosa que volem) i és més ràpid que
--   UNION, que en treuria automàticament. En aquest cas no n'hi ha de
--   reals perquè cada subconsulta produeix files diferents.
-- * Aquest patró d'auditoria és reutilitzable: validació de DNIs, codis
--   postals, identificadors interns, etc. Sempre amb la mateixa idea:
--   negar el patró que defineix "correcte".
