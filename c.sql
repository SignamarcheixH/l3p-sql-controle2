
SELECT
 table_catalog AS base,
 table_schema AS schema,
 table_name AS nom,
 ordinal_position AS position_colonne,
 column_name AS nom,
 data_type AS type_colonne,
 (CASE is_nullable WHEN 'YES' THEN 'OUI'
			 	   WHEN 'NO'  THEN 'NON'
		     ELSE is_nullable END) AS peut_etre_null,
 (CASE is_updatable WHEN 'YES' THEN 'OUI'
			 	   WHEN 'NO'  THEN 'NON'
		     ELSE is_updatable END) AS peut_etre_modifie,
 character_maximum_length AS chaine_longueur_max
FROM
 information_schema.COLUMNS b
WHERE
 TABLE_NAME IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'public') ORDER BY b.table_catalog, b.table_schema, b.table_name, b.ordinal_position;
