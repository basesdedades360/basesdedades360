-- Exercici resolt 6.4
-- Estadístiques de notes amb funcions numèriques i gestió segura de `NULL`
-- Sintaxi: MySQL / MariaDB

SELECT
    id_modul,
    COUNT(*)                                                         AS total_matricules,
    COUNT(nota_final)                                                AS notes_registrades,
    SUM(CASE WHEN nota_final >= 5 THEN 1 ELSE 0 END)                 AS aprovats,
    SUM(CASE WHEN nota_final <  5 THEN 1 ELSE 0 END)                 AS suspesos,
    -- Taxa d'aprovats: protegim contra la divisió per zero amb NULLIF i COALESCE
    COALESCE(
        ROUND(
            100.0 * SUM(CASE WHEN nota_final >= 5 THEN 1 ELSE 0 END)
                  / NULLIF(COUNT(nota_final), 0),
            1
        ),
        0.0
    )                                                                AS taxa_aprovats_pct,
    ROUND(AVG(nota_final),    2)                                     AS nota_mitja_arrod,
    TRUNCATE(AVG(nota_final), 1)                                     AS nota_mitja_truncada,
    MAX(nota_final)                                                  AS nota_max,
    MIN(nota_final)                                                  AS nota_min,
    COALESCE(MAX(nota_final) - MIN(nota_final), 0)                   AS rang
FROM matricula
GROUP BY id_modul
HAVING COUNT(*) >= 1
ORDER BY taxa_aprovats_pct DESC;
