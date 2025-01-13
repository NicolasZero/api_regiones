const { query } = require("../db/postgresql");

const getAll = async (request, reply) => {
    try {
        const textQuery = `SELECT * FROM regions.view_achievements where status_id = 1;`
        const resp = await query(textQuery)
        return reply.send({ status: "ok", msg: `Se encontraron ${resp.rowCount} resultado(s)`, data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const countAll = async (request, reply) => {
    try {
        const textQuery = `SELECT count(*) FROM regions.view_achievements where status_id = 1;`
        const resp = await query(textQuery)
        return reply.send({ status: "ok", data: resp.rows[0] });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const countAllForMonth = (filter) => async (request, reply) => {
    try {
        const { month, year } = request.params
        if (!Number(year) || !Number(month)) {
            return reply.code(400).send({ error: "year or month not valid", status: "failed" });
        }
        const textQuery = `SELECT count(*) FROM regions.view_achievements WHERE status_id = 1 AND extract(month FROM created_on) = ${month} AND extract(year FROM created_on) = ${year};`
        const resp = await query(textQuery)
        return reply.send({ status: "ok",data: resp.rows[0] });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getAllByUser = async (request, reply) => {
    try {
        const textQuery = `SELECT * FROM regions.view_achievements where status_id = 1 AND created_by = $1;`
        const resp = await query(textQuery)
        return reply.send({ status: "ok", msg: `Se encontraron ${resp.rowCount} resultado(s)`, data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getById = async (request, reply) => {
    try {
        const id = request.params.id
        const textQuery = `SELECT * FROM regions.view_achievements WHERE id = $1;`
        const resp = await query(textQuery, [id])
        return reply.send({ status: "ok", msg: `Se encontro ${resp.rowCount} resultado`, data: resp.rows[0] });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getStatisticsAnnual = async (request, reply) => {
    try {
        const {year} = request.params
        if (!Number(year)) {
            return reply.code(400).send({ error: "year not valid", status: "failed" });
        }
        const textQuery = `
            SELECT m.month , coalesce(s.finished,0) as finished, coalesce(s.unfinished,0) as unfinished 
            FROM (
                SELECT 
                    extract(month FROM created_on) AS month,
                    COUNT(CASE WHEN status_id = 1 THEN status_id ELSE NULL END) AS finished,
                    COUNT(CASE WHEN status_id != 1 THEN status_id ELSE NULL END) AS unfinished
                FROM regions.view_achievements
                WHERE EXTRACT(YEAR FROM created_on) = ${year}
                group by month
            ) as s
            FULL JOIN month as m on m.id = s.month
            WHERE m.id != 0;`
        const resp = await query(textQuery)
        return reply.send({ status: "ok",data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getStatisticsActivity = (specific) => async (request, reply) => {
    try {
        let specificYear = ''
        if (specific) {
            const {year} = request.params
            if (!Number(year)) {
                return reply.code(400).send({ error: "year not valid", status: "failed" });
            }
            specificYear = `AND EXTRACT(YEAR FROM created_on) = ${year}`
        }
        const textQuery = `
            SELECT 
                type_activity as activity,
	            count(type_activity) as done
            FROM regions.view_achievements
            WHERE status_id = 1 ${specificYear}
            GROUP BY type_activity;`

        const resp = await query(textQuery)
        return reply.send({ status: "ok",data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const insert = async (request, reply) => {
    let id = 0
    try {
        if (!request.body) {
            return reply.code(400).send({ error: "body empty not valid", status: "failed" });
        }
        const {
            created_by,
            date,
            hour,
            action_id,
            activity_id,
            management_unit_id,
            state_id,
            municipality_id,
            parish_id,
            observation,
            previously_scheduled
        } = request.body

        const status = (previously_scheduled) ? 2 : 1

        let textQuery = `INSERT INTO regions.achievements_base (
                        created_by,
                        date,
                        hour,
                        action_id,
                        activity_id,
                        management_unit_id,
                        state_id,
                        municipality_id,
                        parish_id,
                        observation,
                        previously_scheduled,
                        status_id
                        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) RETURNING id;`
        let value = [created_by, date, hour, action_id, activity_id, management_unit_id, state_id, municipality_id, parish_id, observation, previously_scheduled, status]
        let resp = await query(textQuery, value)
        id = resp.rows[0].id

        if (activity_id == 5) {
            const {
                country_id,
                gender_id,
                age,
                collection_method,
                received
            } = request.body

            textQuery = `INSERT INTO regions.achievements_victim_traff (
                achievements_id,
                country_id,
                gender_id,
                age,
                collection_method,
                received
                ) VALUES ($1, $2, $3, $4, $5, $6);`
            value = [id, country_id, gender_id, age, collection_method, received]
            resp = await query(textQuery, value)
            console.log(resp)
        } else if (activity_id == 6) {
            const {
                age_range_id,
                type_weapon_id,
                type_femicide_id,
                killer_status_id
            } = request.body

            textQuery = `INSERT INTO regions.achievements_g_violence (
                achievements_id,
                age_range_id,
                type_weapon_id,
                type_femicide_id,
                killer_status_id
                ) VALUES ($1, $2, $3, $4, $5);`
            value = [id, age_range_id, type_weapon_id, type_femicide_id, killer_status_id]
            resp = await query(textQuery, value)
            console.log(resp)
        } else if (activity_id == 16) {
            const {
                type_telephone_service_id,
                great_mission
            } = request.body

            textQuery = `INSERT INTO regions.achievements_telephone_service (
                achievements_id,
                type_telephone_service_id,
                great_mission
                ) VALUES ($1, $2, $3);`
            value = [id, type_telephone_service_id, great_mission]
            resp = await query(textQuery, value)
            console.log(resp)
        } else {
            const {
                place_id,
                place_other,
                n_womans,
                n_man,
                n_unspecified,
                responsible,
                phone_number
            } = request.body

            textQuery = `INSERT INTO regions.achievements_others (
                achievements_id,
                place_id,
                place_other,
                n_womans,
                n_man,
                n_unspecified,
                responsible,
                phone_number
                ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);`
            value = [id, place_id, place_other, n_womans, n_man, n_unspecified, responsible, phone_number]
            resp = await query(textQuery, value)
            // console.log(resp)
        }

        // console.log(resp);

        if (resp.rowCount == 0) {
            return reply.code(500).send({ error: "error en la peticion", status: "failed" });
        }

        return reply.send({ status: "ok", msg: `Se registro con exito` });
        // return reply.send("En progreso")
    } catch (error) {
        console.log(error);
        if (id !== 0) {
            await query('DELETE FROM regions.achievements_base WHERE id = $1', [id])
        }
        return reply.code(500).send({ error: "error en la peticion", status: "failed", id });
    }
}

module.exports = {
    getAll,
    getById,
    insert,
    getAllByUser,
    getStatisticsAnnual,
    getStatisticsActivity,
    countAll,
    countAllForMonth
}