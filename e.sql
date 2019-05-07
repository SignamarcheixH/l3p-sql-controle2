
SELECT table_catalog AS base,
              table_schema AS schema,
              table_name AS nom,
              privilege_type AS type_de_privilege,
              grantor AS attributaire,
              grantee AS beneficiaire
FROM information_schema.role_table_grants
WHERE table_name in (SELECT table_name FROM information_schema.tables WHERE table_schema = 'public')
ORDER BY table_catalog, table_schema, table_name, type_de_privilege;
