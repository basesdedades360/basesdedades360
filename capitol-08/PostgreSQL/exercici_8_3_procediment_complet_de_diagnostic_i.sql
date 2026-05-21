-- Exercici resolt 8.3
-- Procediment complet de diagnòstic i monitoratge
-- Sintaxi: PostgreSQL

CREATE INDEX idx_alumne_curs_cover
  ON alumne(curs_inici)
  INCLUDE (nom, cognoms);

-- --- Bloc següent ---

SELECT a.nom, a.cognoms, AVG(ma.nota_final) AS mitjana
FROM alumne a
JOIN matricula ma ON a.id_alumne = ma.id_alumne
WHERE a.curs_inici = 2024
GROUP BY a.id_alumne, a.nom, a.cognoms
ORDER BY mitjana DESC;

-- --- Bloc següent ---

SELECT pid, usename, now() - query_start AS durada,
       state, query
FROM pg_stat_activity
WHERE datname = 'institut'
  AND state = 'active'
  AND now() - query_start > interval '5 seconds'
ORDER BY durada DESC;

-- --- Bloc següent ---

-- Pas 1: intent suau
SELECT pg_cancel_backend(18472);

-- Pas 2: si no funciona en 30 segons, intent forçat
SELECT pg_terminate_backend(18472);

-- --- Bloc següent ---

SELECT query, calls, total_exec_time, mean_exec_time
FROM pg_stat_statements
WHERE query ILIKE '%matricula%'
  AND query ILIKE '%curs_inici%'
ORDER BY total_exec_time DESC
LIMIT 5;

-- --- Bloc següent ---

EXPLAIN ANALYZE
SELECT a.nom, a.cognoms, AVG(ma.nota_final) AS mitjana
FROM alumne a
JOIN matricula ma ON a.id_alumne = ma.id_alumne
WHERE a.curs_inici = 2024
GROUP BY a.id_alumne, a.nom, a.cognoms
ORDER BY mitjana DESC;
-- Execution Time: 3450 ms

-- --- Bloc següent ---

ANALYZE alumne;
ANALYZE matricula;

-- --- Bloc següent ---

CREATE INDEX idx_alumne_curs_inici ON alumne(curs_inici);
ANALYZE alumne;

EXPLAIN ANALYZE SELECT ...;
-- Execution Time: 280 ms
