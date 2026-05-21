-- Exercici resolt 10.3
-- Generar el "diccionari" d'una taula a partir de `information_schema`
-- Sintaxi: PostgreSQL

SELECT
    c.column_name                                AS columna,
    c.data_type                                  AS tipus,
    c.is_nullable                                AS admet_null,
    c.column_default                             AS valor_defecte,
    MAX(CASE WHEN tc.constraint_type = 'PRIMARY KEY'
             THEN 'PK' ELSE NULL END)            AS pk,
    MAX(CASE WHEN tc.constraint_type = 'FOREIGN KEY'
             THEN ccu.table_name || '.' || ccu.column_name
             ELSE NULL END)                      AS fk_apunta_a
FROM   information_schema.columns c
LEFT JOIN information_schema.key_column_usage kcu
       ON kcu.table_schema = c.table_schema
      AND kcu.table_name   = c.table_name
      AND kcu.column_name  = c.column_name
LEFT JOIN information_schema.table_constraints tc
       ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema    = kcu.table_schema
LEFT JOIN information_schema.constraint_column_usage ccu
       ON ccu.constraint_name = tc.constraint_name
      AND tc.constraint_type  = 'FOREIGN KEY'
WHERE  c.table_schema = 'public'
  AND  c.table_name   = 'matricula'
GROUP BY c.column_name, c.data_type, c.is_nullable,
         c.column_default, c.ordinal_position
ORDER BY c.ordinal_position;
