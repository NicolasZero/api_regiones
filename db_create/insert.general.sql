INSERT INTO general.department OVERRIDING SYSTEM VALUE VALUES 
(0,'NINGUNA'),
(1,'AUDITORIA INTERNA'),
(2,'CONSULTORIA JURIDICA'),
(3,'DIRECCION GENERAL'),
(4,'GERENCIA DE ATENCION INTEGRAL Y PREVENCION DE LA VIOLENCIA CONTRA LAS MUJERES'),
(5,'GERENCIA DE DESARROLLO ALTERNATIVO Y POLITICA REGIONAL'),
(6,'GERENCIA DE INVESTIGACION Y CAPACITACION'),
(7,'GERENCIA DE LA DEFENSORIA NACIONAL DE LOS DERECHOS DE LA MUJER'),
(8,'OFICINA DE ADMINISTRACION Y SERVICIOS'),
(9,'OFICINA DE ATENCION A LA CIUDADANIA'),
(10,'OFICINA DE COMUNICACION E IMAGEN INSTITUCIONAL'),
(11,'OFICINA DE PLANIFICACION ORGANIZACION Y PRESUPUESTO'),
(12,'OFICINA DE RECURSOS HUMANOS'),
(13,'OFICINA DE RELACIONES INTERNACIONALES'),
(14,'OFICINA DE SISTEMAS Y TECNOLOGIA DE LA INFORMACION');

SELECT pg_catalog.setval('general.department_id_seq', 15, true);

INSERT INTO general.position OVERRIDING SYSTEM VALUE VALUES
(0,'NINGUNA'),
(1,'ABOGADA'),
(2,'ADJUNTO OFICINA DE ADMINISTRACION Y SERVICIOS'),
(3,'ALBAÑIL'),
(4,'ANALISTA'),
(5,'ANTROPÓLOGA'),
(6,'ARCHIVISTA'),
(7,'ARCHIVISTA DE CONTABILIDAD'),
(8,'ASEADORA'),
(9,'ASISTENTE ADMINISTRATIVO'),
(10,'ASISTENTE TECNICO'),
(11,'AUDITORA ( E )'),
(12,'AUXILIAR DE OFICINA MENSAJERA'),
(13,'AYUDANTE'),
(14,'CHOFER'),
(15,'COCINERA'),
(16,'CONSULTORA'),
(17,'COORDINADOR ARCHIVO'),
(18,'COORDINADOR DE BIENES NACIONALES'),
(19,'COORDINADOR DE BIENESTAR SOCIAL'),
(20,'COORDINADOR DE COMPRAS'),
(21,'COORDINADOR DE PROCEDIMIENTOS ADMINISTRATIVOS Y JURISDICCIONALES'),
(22,'COORDINADOR DE PROGRAMACION'),
(23,'COORDINADOR DE PROTOCOLO Y RELACIONES INTERINSTITUCIONALES'),
(24,'COORDINADOR DE REDES'),
(25,'COORDINADOR DE SEGURIDAD'),
(26,'COORDINADOR DE SERVICIOS GENERALES'),
(27,'COORDINADOR DEL AREA DE IMPLEMENTACION Y POLITICAS REGIONALES'),
(28,'COORDINADORA'),
(29,'COORDINADORA ( E) AREA RECLUTAMIENTO Y SELECCIÓN'),
(30,'COORDINADORA ( E) DE LAS UNIDADES DE ATENCION PARA LAS MUJERES'),
(31,'COORDINADORA (E ) DE PRENSA'),
(32,'COORDINADORA (E) DE ARTICULACION INTERINSTITUCIONALES'),
(33,'COORDINADORA (E) DE EJECUCION'),
(34,'COORDINADORA DE ACCIONES PARA LAS MUJERES EN SITUACION DE VULNERABILIDAD'),
(35,'COORDINADORA DE ACTUACION PROCESAL'),
(36,'COORDINADORA DE AREA DE PROGRAMAS DE CAPACITACION Y EVALUACION'),
(37,'COORDINADORA DE ARTICULACIÓN CON EL PODER POPULAR Y DEFENSORAS COMUNALES'),
(38,'COORDINADORA DE ATENCION DE LAS PRIVADAS DE LIBERTAD'),
(39,'COORDINADORA DE ATENCION Y ORIENTACION JURIDICA DEFENSORA'),
(40,'COORDINADORA DE DESARROLLO CULTURA Y EDUCACION ( E ) PROFESIONAL III (PIII)'),
(41,'COORDINADORA DE MECANISMOS DE INTEGRACION Y PARTICIPACION'),
(42,'COORDINADORA DE MUJERES Y ASUNTOS DE GENEROS ( E )'),
(43,'COORDINADORA DE NOMINA'),
(44,'COORDINADORA DE PREVENCIÓN'),
(45,'COORDINADORA DEL DESPACHO'),
(46,'COORDINADORA DEL SERVICIO 0800 MUJERES'),
(47,'DEFENSORA DELEGADA'),
(48,'DIRECTOR DE COMUNICACION E IMAGEN INSTITUCIONAL'),
(49,'DIRECTOR DE DESARROLLO ALTERNATIVO Y POLICA REGIONAL'),
(50,'DIRECTOR DE LA OFICINA DE SISTEMAS Y TECNOLOGIAS DE LA INFORMACION'),
(51,'DIRECTOR OFICINA DE ADMINISTARCIÓN Y SERVICIOS'),
(52,'DIRECTORA DE INVESTIGACION Y CAPACITACION'),
(53,'DIRECTORA DE LA DEFENSORIA NACIONAL DE LOS DERECHOS DE LA MUJER'),
(54,'DIRECTORA DE PLANIFICACION ORGANIZACION Y PRESUPUESTO'),
(55,'DIRECTORA DE RECURSOS HUMANOS'),
(56,'DIRECTORA DEL DESPACHO'),
(57,'DIRECTORA GENERAL'),
(58,'DIRECTORA( E ) DE LA OFICINA DE RELACIONES INTERNACIONALES'),
(59,'ELECTRICISTA'),
(60,'ENLACE INTERINSTITUCIONAL'),
(61,'FACILITADOR'),
(62,'FACILITADORA'),
(63,'FORMADORA'),
(64,'MOTORIZADO'),
(65,'OFICIAL DE SEGURIDAD'),
(66,'OFICINISTA'),
(67,'OPERADORA DEL 0800MUJERES'),
(68,'PERIODISTA'),
(69,'PRENSA'),
(70,'PROFESIONAL I'),
(71,'PROFESIONAL II'),
(72,'PROFESIONAL III'),
(73,'PROGRAMADOR'),
(74,'PROMOTORA'),
(75,'PROTOCOLO'),
(76,'PSICOPEDAGOGA'),
(77,'RECEPCIONISTA'),
(78,'RECEPTOR INFORMADOR'),
(79,'SECRETARIA'),
(80,'TECNICO ADMINISTRATIVO I'),
(81,'TRABAJADORA SOCIAL');

SELECT pg_catalog.setval('general.position_id_seq', 82, true);

INSERT INTO general.payroll_type OVERRIDING SYSTEM VALUE VALUES 
(0,'NINGUNA'),
(1,'DEF. DELG'),
(2,'DIRECTIVO'),
(3,'EMP CONTRA'),
(4,'EMP FIJO'),
(5,'OBRERO CONTRA'),
(6,'OBRERO FIJO');

SELECT pg_catalog.setval('general.payroll_type_id_seq', 7, true);

INSERT INTO general.area_coordination OVERRIDING SYSTEM VALUE VALUES
(0,'NINGUNA'),
(1,'AUDITORIA INTERNA'),
(2,'CONSULTORIA JURIDICA'),
(3,'COORDINACION DE ARCHIVO'),
(4,'COORDINACION DE BIENESTAR SOCIAL '),
(5,'COORDINACION DE DESARROLLO CULTURA Y EDUCACION'),
(6,'COORDINACION DE NOMINA'),
(7,'COORDINACION DE RECLUTAMIENTO Y SELECCION'),
(8,'COORDINACION DE SEGURIDAD'),
(9,'COORDINACION SERVICIOS GENERALES'),
(10,'COORDINADORA DE MUJERES Y ASUNTOS DE GENEROS ( E )'),
(11,'DIRECCION GENERAL'),
(12,'DIRECCION GENERAL DEL DESPACHO'),
(13,'GERENCIA DE ATENCION INTEGRAL Y PREVENCION DE LA VIOLENCIA CONTRA LAS MUJERES'),
(14,'GERENCIA DE DESARROLLO ALTERNATIVO Y POLITICA REGIONAL'),
(15,'GERENCIA DE INVESTIGACION Y CAPACITACION'),
(16,'GERENCIA DE LA DEFENSORIA NACIONAL DE LOS DERECHOS DE LA MUJER'),
(17,'OFICINA DE ADMINISTRACION Y SERVICIOS'),
(18,'OFICINA DE ATENCION A LA CIUDADANIA'),
(19,'OFICINA DE COMUNICACION E IMAGEN INSTITUCIONAL'),
(20,'OFICINA DE PLANIFICACION ORGANIZACION Y PRESUPUESTO'),
(21,'OFICINA DE RECURSOS HUMANOS'),
(22,'OFICINA DE RELACIONES INTERNACIONALES'),
(23,'OFICINA DE SISTEMAS Y TECNOLOGIA DE LA INFORMACION');

SELECT pg_catalog.setval('general.area_coordination_id_seq', 24, true);