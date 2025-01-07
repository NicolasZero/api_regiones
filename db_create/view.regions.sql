-- regions
CREATE VIEW regions.view_users AS SELECT u.*, r.role, w.identity_card, w.full_name, w.status, w.gender, w.position, w.position_id, w.gender_id, w.department, w.department_id FROM regions.users AS u
LEFT JOIN regions.roles AS r ON r.id = u.role_id
LEFT JOIN general.view_workers AS w ON w.id = u.worker_id;

CREATE VIEW regions.view_achievements AS select 
	b.id,
	b.status_id,
	st.status,
    b.created_on,
	b.created_by as user_id,
    u.username,
    b.date,
    b.hour,
    ta1.type_action,
	ta2.type_activity,
    mu.management_unit,
    s.state,
    m.municipality,
    p.parish,
    b.observation,
    b.previously_scheduled,
	pl.place,
	o.place_other,
	o.n_womans,
	o.n_man,
	o.n_unspecified,
	o.responsible,
	o.phone_number,
	g.age_range_id,
	g.type_weapon_id,
	g.type_femicide_id,
	g.killer_status_id,
	t.type_telephone_service_id,
	t.great_mission,
	v.country_id,
	v.gender_id,
	v.age,
	v.collection_method,
	v.received
from regions.achievements_base as b 
-- joins --
LEFT JOIN regions.achievements_others as o on o.achievements_id = b.id
LEFT JOIN regions.achievements_g_violence as g on g.achievements_id = b.id
LEFT JOIN regions.achievements_telephone_service as t on t.achievements_id = b.id
LEFT JOIN regions.achievements_victim_traff as v on v.achievements_id = b.id
LEFT JOIN regions.users as u on u.id = b.created_by
LEFT JOIN regions.status as st on b.status_id = st.id
LEFT JOIN regions.type_action as ta1 on ta1.id = b.action_id
LEFT JOIN regions.type_activity as ta2 on ta2.id = b.activity_id
LEFT JOIN regions.management_unit as mu on mu.id = b.management_unit_id
LEFT JOIN regions.place as pl on pl.id = o.place_id
LEFT JOIN states as s on s.id = b.state_id
LEFT JOIN municipalities as m on m.id = b.municipality_id
LEFT JOIN parishes as p on p.id = b.parish_id;

--mobile_unite
CREATE VIEW regions.mobile_units AS SELECT 
    a.id,
    a.status_id,
    st.status,
    a.created_by as user_id,
 	u.username,
	a.created_on,
	a.date,
    a.num_mobile_units,
    a.num_ultrasounds,
    a.responsible,
    a.state_id,
    s.state,
    a.municipality_id,
    m.municipality,
    a.parish_id,
    p.parish,
    a.place,
    a.approximate,
    a.observation1,
    a.observation2,
    a.logistical_support
FROM regions.social_day_achievements a
LEFT JOIN regions.users u ON u.id = a.created_by
LEFT JOIN regions.status st ON a.status_id = st.id
LEFT JOIN states s ON s.id = a.state_id
LEFT JOIN municipalities m ON m.id = a.municipality_id
LEFT JOIN parishes p ON p.id = a.parish_id;

-- mobile_units_details

CREATE VIEW regions.mobile_units_disability AS select s.id, social_day_id, service_type, subtype, disability, age_range
from regions.social_day_disability as s
left join regions.service_types as st on st.id = s.service_type_id
left join regions.service_subtypes as ss on ss.id = s.service_subtype_id
left join regions.disabilitys as d on d.id = s.disability_id
left join regions.age_range as r on r.id = s.age_range_id;

CREATE VIEW regions.mobile_units_ethnicity AS select s.id, social_day_id, service_type, subtype, ethnicity, age_range
from regions.social_day_ethnicity as s
left join regions.service_types as st on st.id = s.service_type_id
left join regions.service_subtypes as ss on ss.id = s.service_subtype_id
left join regions.ethnicities as d on d.id = s.ethnicity_id
left join regions.age_range as r on r.id = s.age_range_id;

CREATE VIEW regions.mobile_units_service AS select s.id, social_day_id, st.service_type, subtype, age_range
from regions.social_day_service_types as s
left join regions.service_types as st on st.id = s.service_type_id
left join regions.service_subtypes as ss on ss.id = s.service_subtype_id
left join regions.age_range as r on r.id = s.age_range_id;