SELECT main.table_catalog AS base,
	            main.table_schema AS schema,
	            main.table_name AS nom,
	            (CASE main.table_type WHEN 'BASE TABLE' THEN 'TYPE DE BASE'
			 			                                           WHEN 'VIEW'       THEN 'VUE'
		     			                                         ELSE main.table_type END) AS type,
	            (CASE main.is_insertable_into WHEN 'YES' THEN 'OUI'
			 	                                                            WHEN 'NO'  THEN 'NON'
		                                                                ELSE is_insertable_into END) AS peut_t_on_y_inserer_des_donnees,
		          sub.nb_value AS nb_contrainte_de_valeur,
		          sub.nb_fk AS nb_contrainte_cle_etrangere,
		          sub.nb_pk AS nb_contrainte_cle_primaire,
		          sub.nb_unique AS nb_contrainte_unicite
FROM information_schema.tables main INNER JOIN (
        SELECT SUM(CASE constraint_type WHEN 'CHECK' THEN 1 ELSE 0 END) AS nb_value,
		                  SUM(CASE constraint_type WHEN 'PRIMARY KEY' THEN 1 ELSE 0 END) AS nb_pk,
		                  SUM(CASE constraint_type WHEN 'FOREIGN KEY' THEN 1 ELSE 0 END) AS nb_fk,
		                  SUM(CASE constraint_type WHEN 'UNIQUE' THEN 1 ELSE 0 END) AS nb_unique,
		                  table_name
        FROM information_schema.table_constraints
        WHERE constraint_schema = 'public'
        GROUP BY table_name) AS sub
ON main.table_name=sub.table_name AND main.table_schema ='public'
ORDER BY main.table_catalog, main.table_schema, main.table_name;
