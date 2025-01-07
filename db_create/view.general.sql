-- general
CREATE OR REPLACE VIEW general.view_location_workers AS SELECT l.*, v.state, v.municipality, v.parish FROM general.location AS l
LEFT JOIN view_location AS v ON l.parish_id = v.parish_id;

CREATE OR REPLACE VIEW general.view_workers AS SELECT w.*, g.gender, d.department, p.position, t.name AS payroll_type, a.area, l.state_id, l.state, l.municipality_id, l.municipality, l.parish_id, l.parish, l.address FROM general.workers AS w
LEFT JOIN genders AS g ON g.id = w.gender_id
LEFT JOIN general.view_location_workers AS l ON w.id = l.worker_id
LEFT JOIN general.department AS d ON d.id = w.department_id
LEFT JOIN general.position AS p ON p.id = w.position_id
LEFT JOIN general.payroll_type AS t ON t.id = w.payroll_type_id
lEFT JOIN general.area_coordination AS a ON a.id = w.area_coordination_id;