const { query } = require("../db/postgresql");

const getAllMobileUnits = async (request, reply) => {
    try {
        const textQuery = `SELECT * FROM regions.view_achievements;`
        const resp = await query(textQuery)
        return reply.send({ status: "ok", msg: `Se encontraron ${resp.rowCount} resultado(s)`, data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getMobileUnitsById = async (request, reply) => {
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

const insertMobileUnits= async (request, reply) => {
    try {
        if (!request.body) {
            return reply.code(400).send({ error: "body empty not valid", status: "failed" });
        }
        const {
            id,
            user,
            status,
            activitie,
            cantMobileUnitsRequired,
            cantUltrasoundRequired,
            logisticalSupport,
            state,
            municipality,
            parish,
            place,
            responsible,
            obs,
            date
        } = request.body

        const approximate = request.body.approximate ? request.body.approximate : null // Esto se debe de borrar

        const textQuery = `
            INSERT INTO regions.social_day_achievements(
            created_by, date, num_mobile_units, num_ultrasounds, responsible, state_id, municipality_id, parish_id, place, approximate, logistical_support, observation1)
            VALUES (
            id, date, cantMobileUnitsRequired, cantUltrasoundRequired, responsible, state, municipality, parish, place, ?, logisticalSupport, obs);`
        const value = [id, date, cantMobileUnitsRequired, cantUltrasoundRequired, responsible, state, municipality, parish, place, approximate, logisticalSupport, obs]
        const resp = await query(textQuery, value)

        if (resp.rowCount == 0) {
            return reply.code(500).send({ error: "error en la peticion", status: "failed" });
        }

        return reply.send({ status: "ok", msg: `Se registro con exito` });
    } catch (error) {
        console.log(error);
        if (id !== 0) {
            await query('DELETE FROM regions.achievements_base WHERE id = $1', [id])
        }
        return reply.code(500).send({ error: "error en la peticion", status: "failed", id });
    }
}

const insertMobileUnitsDetails = async (request, reply) =>{
    try {
        if (!request.body) {
            return reply.code(400).send({ error: "body empty not valid", status: "failed" });
        }
        const {
            
        } = request.body

        const textQuery = `
            INSERT INTO regions.social_day_achievements(
                
            ) VALUES (
            
            );`
        const value = []
        const resp = await query(textQuery, value)

    } catch (error) {
        
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