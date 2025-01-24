-- Ejecutar este archivo para actualizar la base de datos a la version 1.25.1.24

-- achievements_analysis
CREATE VIEW regions.view_achievements_analysis AS
SELECT 
    b.id,
	b.status_id,
	EXTRACT(month FROM b.date) as month,
    EXTRACT(year FROM b.date) AS year,
	b.action_id,
	b.activity_id,
	b.state_id,
	coalesce(o.n_womans,0) as women,
	coalesce(o.n_man,0) as men,
	CASE WHEN v.gender_id IS NOT NULL THEN 1 ELSE 0 END as victim_traff,
	CASE WHEN g.age_range_id IS NOT NULL THEN 1 ELSE 0 END as g_violence
FROM regions.achievements_base as b
LEFT JOIN regions.achievements_others as o on o.achievements_id = b.id
LEFT JOIN regions.achievements_g_violence as g on g.achievements_id = b.id
LEFT JOIN regions.achievements_telephone_service as t on t.achievements_id = b.id
LEFT JOIN regions.achievements_victim_traff as v on v.achievements_id = b.id;

-- insert type activity
INSERT INTO regions.type_activity OVERRIDING SYSTEM VALUE VALUES(21, 4, 'SIN INFORMACIÓN');

-- update type activity
UPDATE regions.achievements_base SET activity_id = 21 WHERE activity_id = 0;