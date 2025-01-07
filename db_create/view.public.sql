-- Public
CREATE OR REPLACE VIEW view_location AS SELECT m.state_id, s.state, p.municipality_id, m.municipality, p.id AS parish_id, p.parish FROM parishes AS p
LEFT JOIN municipalities AS m ON p.municipality_id = m.id 
LEFT JOIN states AS s ON m.state_id = s.id;