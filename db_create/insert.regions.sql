INSERT INTO regions.roles OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Administrador(a)'),
(2, 'Usuario(a)');

SELECT pg_catalog.setval('regions.roles_id_seq', 3, true);

INSERT INTO regions.type_action OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Atención Jurídica'),
(2, 'Prevención'),
(3, 'Formación');

SELECT pg_catalog.setval('regions.type_action_id_seq', 4, true);

INSERT INTO regions.type_activity OVERRIDING SYSTEM VALUE VALUES
(0, 0,'NINGUNO'),
(1, 1, ''),
(2, 1, ''),
(3, 1, ''),
(4, 1, ''),
(5, 1, ''),
(6, 1, ''),
(7, 1, ''),
(8, 2, ''),
(9, 2, ''),
(10, 2, ''),
(11, 2, ''),
(12, 2, ''),
(13, 2, ''),
(14, 2, ''),
(15, 2, ''),
(16, 2, ''),
(17, 3, ''),
(18, 3, ''),
(19, 3, ''),
(20, 3, '');

SELECT pg_catalog.setval('regions.type_activity_id_seq', 21, true);

INSERT INTO regions.type_femicide OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, ''),
(2, '');

SELECT pg_catalog.setval('regions.type_femicide_id_seq', 3, true);

INSERT INTO regions.type_weapon OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, ''),
(2, '');

SELECT pg_catalog.setval('regions.type_weapon_id_seq', 3, true);

INSERT INTO regions.killer_status OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, ''),
(2, '');

SELECT pg_catalog.setval('regions.killer_status_id_seq', 3, true)

INSERT INTO regions.status OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Logrado'),
(2, 'Agendado'),
(3, 'Cancelado');

SELECT pg_catalog.setval('regions.status_id_seq', 4, true);

INSERT INTO regions.place OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, ''),
(2, ''),
(3, ''),
(4, '');

SELECT pg_catalog.setval('regions.place_id_seq', 5, true);

INSERT INTO regions.age_range OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, ''),
(2, ''),
(3, ''),
(4, '');

SELECT pg_catalog.setval('regions.age_range_id_seq', 5, true);

INSERT INTO regions.management_unit OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, ''),
(2, '');

SELECT pg_catalog.setval('regions.management_unit_id_seq', 3, true);

INSERT INTO regions.type_telephone_service OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Psicología'),
(2, 'legal')
(3, 'Orientación');

SELECT pg_catalog.setval('regions.type_telephone_service_id_seq', 4, true);