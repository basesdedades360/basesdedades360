-- Exercici resolt 8.1
-- PostgreSQL


-- 2
EXPLAIN ANALYZE
SELECT a.nom, a.cognoms, ma.nota_final
FROM alumne a
JOIN matricula ma ON a.id_alumne = ma.id_alumne
JOIN modul m      ON ma.id_modul  = m.id_modul
WHERE m.codi = 'DAW01' AND ma.nota_final < 5;

-- 3

-- Opció 1: índex per a la FK matricula.id_modul
CREATE INDEX idx_matricula_modul ON matricula(id_modul);

-- Opció 2: índex parcial sobre suspesos (només PostgreSQL)
CREATE INDEX idx_matricula_suspesos
  ON matricula(id_modul)
  WHERE nota_final < 5;

-- 4

\timing on
EXPLAIN ANALYZE SELECT ...;

CREATE INDEX idx_matricula_suspesos
  ON matricula(id_modul) WHERE nota_final < 5;

EXPLAIN ANALYZE SELECT ...;


