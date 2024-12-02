INSERT INTO regions.roles OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Administrador(a)'),
(2, 'Usuario(a)');

SELECT pg_catalog.setval('regions.roles_id_seq', 3, true);