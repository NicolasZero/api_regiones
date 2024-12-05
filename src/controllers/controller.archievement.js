const { query } = require("../db/postgresql");

const getAllArchievement = async (request, reply) => {
    try {
        const textQuery = `SELECT * FROM regions.view_achievements;`
        const resp = await query(textQuery)
        return reply.send({status: "ok", msg:`Se encontraron ${resp.rowCount} resultado(s)`, data: resp.rows});
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getArchievementById = async (request, reply) => {
    try {
        const id = request.params.id
        const textQuery = `SELECT * FROM regions.view_achievements WHERE id = $1;`
        const resp = await query(textQuery,[id])
        return reply.send({status: "ok", msg:`Se encontro ${resp.rowCount} resultado`, data: resp.rows[0]});
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const insertArchievement = async (request, reply) => {
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
        let resp = await query(textQuery,value)
        const id = resp.rows[0].id

        if (activity_id == 5) {
            const {
                place_id,
                place_other,
                n_womans,
                n_man,
                n_unspecified
            } = request.body

            textQuery = `INSERT INTO regions.achievements_others (
                achievements_id,
                place_id,
                place_other,
                n_womans,
                n_man,
                n_unspecified
                ) VALUES ($1, $2, $3, $4, $5, $6);`
            value = [id, place_id, place_other, n_womans, n_man, n_unspecified]
            resp = await query(textQuery,value)
        }

        // console.log(resp);
        return reply.send({status: "ok", msg:`Se encontro ${resp.rowCount} resultado`, data: resp.rows[0]});
        // return reply.send("En progreso")
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}


module.exports = {
    getAllArchievement,
    getArchievementById,
    insertArchievement
}