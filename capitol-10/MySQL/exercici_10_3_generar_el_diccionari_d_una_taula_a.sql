-- Exercici resolt 10.3
-- Generar el "diccionari" d'una taula a partir de `information_schema`
-- Sintaxi: MySQL / MariaDB

SELECT
    c.column_name                                   AS columna,
    c.column_type                                   AS tipus,
    c.is_nullable                                   AS admet_null,
    c.column_default                                AS valor_defecte,
    -- És PK?
    MAX(CASE WHEN tc_pk.constraint_type = 'PRIMARY KEY'
             THEN 'PK' ELSE NULL END)               AS pk,
    -- És FK i a on apunta?
    MAX(CASE WHEN tc_fk.constraint_type = 'FOREIGN KEY'
             THEN CONCAT(kcu_fk.referenced_table_name, '.',
                         kcu_fk.referenced_column_name)
             ELSE NULL END)                         AS fk_apunta_a
FROM   information_schema.columns c
LEFT JOIN information_schema.key_column_usage kcu_pk
       ON kcu_pk.table_schema = c.table_schema
      AND kcu_pk.table_name   = c.table_name
      AND kcu_pk.column_name  = c.column_name
LEFT JOIN information_schema.table_constraints tc_pk
       ON tc_pk.constraint_name   = kcu_pk.constraint_name
      AND tc_pk.table_schema      = kcu_pk.table_schema
      AND tc_pk.constraint_type   = 'PRIMARY KEY'
LEFT JOIN information_schema.key_column_usage kcu_fk
       ON kcu_fk.table_schema = c.table_schema
      AND kcu_fk.table_name   = c.table_name
      AND kcu_fk.column_name  = c.column_name
      AND kcu_fk.referenced_table_name IS NOT NULL
LEFT JOIN information_schema.table_constraints tc_fk
       ON tc_fk.constraint_name   = kcu_fk.constraint_name
      AND tc_fk.table_schema      = kcu_fk.table_schema
      AND tc_fk.constraint_type   = 'FOREIGN KEY'
WHERE  c.table_schema = 'institut'
  AND  c.table_name   = 'matricula'
GROUP BY c.column_name, c.column_type, c.is_nullable,
         c.column_default, c.ordinal_position
ORDER BY c.ordinal_position;
