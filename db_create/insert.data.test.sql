-- This is test data for testing the database

-- Users
INSERT INTO regions.users OVERRIDING SYSTEM VALUE VALUES 
(1, 63, 'admin', '$2a$10$z/N3ZdEEs6K7az5lQvVGMeDMCGcDadI4q5NGVJgzQv91RJF0I2o96', 1);
(2, 165, 'ranthony86', '$2a$10$z/N3ZdEEs6K7az5lQvVGMeDMCGcDadI4q5NGVJgzQv91RJF0I2o96', 2);
-- password admin

SELECT pg_catalog.setval('regions.users_id_seq', 3, true);