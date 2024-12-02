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
(1, 1, 'Asesoría Legal'),
(2, 1, 'Defensoría Móvil'),
(3, 1, 'Mesa Técnica de Justica de Géner'),
(4, 1, 'Representación en Causas Judiciales'),
(5, 1, 'Víctima de trata'),
(6, 1, 'Violencia de Genero ¿Cómo hacen los reportes, general o individual?'),
(7, 1, 'Actuación Procesal'),
(8, 2, 'Atención Psicológica'),
(9, 2, 'Atención Ginecológica'),
(10, 2, 'Casa a Casa'),
(11, 2, 'Conversatorio'),
(12, 2, 'Punto Violeta'),
(13, 2, 'Toma de Espacio'),
(14, 2, 'Dinámicas Preventivas'),
(15, 2, 'Cine Foro'),
(16, 2, 'Atención Telefónica'),
(17, 3, 'Defensoras Comunales Comunitarias'),
(18, 3, 'Defensoras Comunales Laborales'),
(19, 3, 'Defensoras Comunales Juveniles'),
(20, 3, 'Otros');

SELECT pg_catalog.setval('regions.type_activity_id_seq', 21, true);

INSERT INTO regions.type_femicide OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Femicidio agravado'),
(2, 'Femicidio frustrado'),
(3, 'Femicidio');

SELECT pg_catalog.setval('regions.type_femicide_id_seq', 4, true);

INSERT INTO regions.type_weapon OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Arma Blanca'),
(2, 'Fuerza Corporal'),
(3, 'Arma de fuego'),
(4, 'Objeto contundente'),
(5, 'Material inflamable'),
(6, 'Ahogamiento');

SELECT pg_catalog.setval('regions.type_weapon_id_seq', 7, true);

INSERT INTO regions.killer_status OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Privado de libertad'),
(2, 'Suicidio'),
(3, 'Prófugo'),
(4, 'Por determinar'),
(5, 'Sentenciado');

SELECT pg_catalog.setval('regions.killer_status_id_seq', 6, true);

INSERT INTO regions.status OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Logrado'),
(2, 'Agendado'),
(3, 'Cancelado');

SELECT pg_catalog.setval('regions.status_id_seq', 4, true);

INSERT INTO regions.place OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Sede MINMUJER'),
(2, 'CAFIM'),
(3, 'UAIM'),
(4, 'Comunidad'),
(5, 'Ministerio Público'),
(6, 'TSJ'),
(7, 'Palacio de Justicia'),
(8, 'Hospital'),
(9, 'Ambulatorio'),
(10, 'CDI'),
(11, 'Base de Misiones'),
(12, 'Unidad Educativa'),
(13, 'Universidad'),
(14, 'Otros');

SELECT pg_catalog.setval('regions.place_id_seq', 15, true);

INSERT INTO regions.age_range OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, '1-17'),
(2, '18-30'),
(3, '31-45'),
(4, '46-85');


SELECT pg_catalog.setval('regions.age_range_id_seq', 5, true);

INSERT INTO regions.management_unit OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'gerencia 1'),
(2, 'gerencia 2');

SELECT pg_catalog.setval('regions.management_unit_id_seq', 3, true);

INSERT INTO regions.type_telephone_service OVERRIDING SYSTEM VALUE VALUES
(0, 'NINGUNO'),
(1, 'Psicología'),
(2, 'legal'),
(3, 'Orientación');

SELECT pg_catalog.setval('regions.type_telephone_service_id_seq', 4, true);