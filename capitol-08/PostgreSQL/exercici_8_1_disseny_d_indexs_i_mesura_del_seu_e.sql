-- Exercici resolt 8.1
-- Disseny d'índexs i mesura del seu efecte
-- Sintaxi: PostgreSQL

EXPLAIN ANALYZE
SELECT a.nom, a.cognoms, ma.nota_final
FROM alumne a
JOIN matricula ma ON a.id_alumne = ma.id_alumne
JOIN modul m      ON ma.id_modul  = m.id_modul
WHERE m.codi = 'DAW01' AND ma.nota_final < 5;

-- --- Bloc següent ---

-- Opció 1: índex per a la FK matricula.id_modul
CREATE INDEX idx_matricula_modul ON matricula(id_modul);

-- --- Bloc següent ---

-- Opció 2: índex parcial sobre suspesos (només PostgreSQL)
CREATE INDEX idx_matricula_suspesos
  ON matricula(id_modul)
  WHERE nota_final < 5;

-- --- Bloc següent ---

-- Pas 1: anotar el baseline
\timing on
EXPLAIN ANALYZE SELECT ...;
-- Execution Time: 4200 ms

-- Pas 2: crear l'índex
CREATE INDEX idx_matricula_suspesos
  ON matricula(id_modul) WHERE nota_final < 5;

-- Pas 3: actualitzar estadístiques perquè el motor el vegi
ANALYZE matricula;

-- Pas 4: tornar a mesurar
EXPLAIN ANALYZE SELECT ...;
-- Execution Time: 12 ms

-- --- Bloc següent ---

SELECT a.nom, a.cognoms, ma.nota_final
FROM alumne a
JOIN matricula ma ON a.id_alumne = ma.id_alumne
JOIN modul m      ON ma.id_modul  = m.id_modul
WHERE m.codi = 'DAW01' AND ma.nota_final < 5;
