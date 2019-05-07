
SELECT
      constraint_catalog AS base,
      constraint_schema AS schema,
      constraint_name AS nom,
      (CASE constraint_type WHEN 'CHECK' THEN 'contrainte de valeur'
                                              WHEN 'PRIMARY KEY' THEN 'contrainte de clé primaire'
                                              WHEN 'FOREIGN KEY' THEN 'contrainte de clé etrangére'
      ELSE constraint_type END) AS type_de_contrainte,
      CONCAT(constraint_catalog,'.',constraint_schema,'.',table_name)
FROM
      information_schema.table_constraints
WHERE constraint_schema = 'public';
