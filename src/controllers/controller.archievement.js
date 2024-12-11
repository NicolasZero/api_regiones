const { query } = require("../db/postgresql");

const getAllArchievement = async (request, reply) => {
    try {
        const textQuery = `SELECT * FROM regions.view_achievements;`
        const resp = await query(textQuery)
        return reply.send({ status: "ok", msg: `Se encontraron ${resp.rowCount} resultado(s)`, data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getArchievementById = async (request, reply) => {
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

const insertArchievement = async (request, reply) => {
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
            previously_scheduled,
        } = request.body

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
                        previously_scheduled
                        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING id;`
        let value = [created_by, date, hour, action_id, activity_id, management_unit_id, state_id, municipality_id, parish_id, observation, previously_scheduled]
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

            textQuery = `INSERT INTO regions.achievements_g_violence (
                achievements_id,
                type_telephone_service_id,
                great_mission
                ) VALUES ($1, $2, $3, $4, $5);`
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

        console.log(resp);

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

const updareArchievement = async (request, reply) => {
    if (!request.body) {
        return reply.code(400).send({ error: "body empty not valid", status: "failed" });
    }
    const { id } = request.body
    let base = false
    try {
        const { date, n_womans, n_man, observation } = request.body

        // sql
        let textQuery = `UPDATE regions.achievements_base
        SET date = $1, observation = $2, status_id = 1
        WHERE id = $3;`
        // Ejecuta el sql
        let resp = await query(textQuery, [date, observation, id])        

        // en caso de no encontrar el id, base es true
        if (resp.rowCount == 0) {
            base = true
        }

        textQuery = `UPDATE regions.achievements_others
        SET n_womans = $1, n_man = $2
        WHERE achievements_id = $3;`
        resp = await query(textQuery, [n_womans, n_man, id])

        // if (resp.rowCount == 0) {
        //     await query("UPDATE regions.achievements_base SET date = '1900-01-01', observation = '', status_id = 2 WHERE id = $1;", [id])
        // }

        return reply.send({ status: "ok", msg: `Se actualizaron ${resp.rowCount}`, data: resp.rowCount });
    } catch (error) {
        if (base) {
            await query("UPDATE regions.achievements_base SET date = '1900-01-01', observation = '', status_id = 2 WHERE id = $1;", [id])
        }
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

module.exports = {
    getAllArchievement,
    getArchievementById,
    insertArchievement,
    updareArchievement
}