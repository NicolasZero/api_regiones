const { query } = require("../db/postgresql");

const getAllMobileUnits = (filter) => async (request, reply) => {
    try {
        const textQuery = `SELECT * FROM regions.mobile_units ${filter};`
        const resp = await query(textQuery)
        return reply.send({ status: "ok", msg: `Se encontraron ${resp.rowCount} resultado(s)`, data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getMobileUnitsByUser = (filter) => async (request, reply) => {
    try {
        const id = request.params.id
        const textQuery = `SELECT * FROM regions.mobile_units WHERE user_id = $1 ${filter};`
        const resp = await query(textQuery, [id])
        return reply.send({ status: "ok", msg: `Se encontro ${resp.rowCount} resultado`, data: resp.rows });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const getMobileUnitsById = async (request, reply) => {
    try {
        const id = request.params.id
        const textQuery = `SELECT * FROM regions.mobile_units WHERE id = $1;`
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
            cantMobileUnitsRequired,
            cantUltrasoundRequired,
            logisticalSupport,
            state,
            municipality,
            parish,
            place,
            responsible,
            approximate,
            obs,
            date
        } = request.body

        const textQuery = `
            INSERT INTO regions.social_day_achievements(
            created_by, date, num_mobile_units, num_ultrasounds, responsible, state_id, municipality_id, parish_id, place, approximate, logistical_support, observation1)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);`
        const value = [id, date, cantMobileUnitsRequired, cantUltrasoundRequired, responsible, state, municipality, parish, place, approximate, logisticalSupport, obs]
        const resp = await query(textQuery, value)

        if (resp.rowCount == 0) {
            return reply.code(500).send({ error: "No se logro registrar", status: "failed" });
        }

        return reply.send({ status: "ok", msg: `Se registro con exito` });
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const insertMobileUnitsDetails = async (request, reply) =>{
    try {
        if (!request.body) {
            return reply.code(400).send({ error: "body empty not valid", status: "failed" });
        }
        const {
            obs2,
            attentionTypes
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

module.exports = {
    getAllMobileUnits,
    getMobileUnitsById,
    insertMobileUnits,
    insertMobileUnitsDetails,
    getMobileUnitsByUser
}