-- Exercici resolt 8.3
-- PostgreSQL

-- 1 
SELECT pid, usename, now() - query_start AS durada,
       state, query
FROM pg_stat_activity
WHERE datname = 'institut'
  AND state = 'active'
  AND now() - query_start > interval '5 seconds'
ORDER BY durada DESC;


-- 2
-- intent suau
SELECT pg_cancel_backend(18472);

-- si no funciona intent forçat
SELECT pg_terminate_backend(18472);

-- 3
SELECT query, calls, total_exec_time, mean_exec_time
FROM pg_stat_statements
WHERE query ILIKE '%matricula%'
  AND query ILIKE '%curs_inici%'
ORDER BY total_exec_time DESC
LIMIT 5;


-- 4
EXPLAIN ANALYZE
SELECT a.nom, a.cognoms, AVG(ma.nota_final) AS mitjana
FROM alumne a
JOIN matricula ma ON a.id_alumne = ma.id_alumne
WHERE a.curs_inici = 2024
GROUP BY a.id_alumne, a.nom, a.cognoms
ORDER BY mitjana DESC;

-- 5
ANALYZE alumne;
ANALYZE matricula;

CREATE INDEX idx_alumne_curs_inici ON alumne(curs_inici);
ANALYZE alumne;

EXPLAIN ANALYZE SELECT ...;
-- Execution Time: 280 ms

CREATE INDEX idx_alumne_curs_cover
  ON alumne(curs_inici)
  INCLUDE (nom, cognoms);

