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
            id,
            obs2,
            attentionTypes
        } = request.body

        // insertar consulta para verificar que existe una unidad movil con ese id aqui :v

        const numAttention = attentionTypes.length

        let text = ""
        let text2 = ""

        let a = 0
        attentionTypes.forEach(attention => {
            return attention.ageRanges.forEach(e => {
                text += `${id},${attention.type},${attention.subType?attention.subType:0},${e.range},${e.men},${e.women},`
                text2 += `($${a+1},$${a+2},$${a+3},$${a+4},$${a+5},$${a+6}),`
                a += 6
            })
        })

        text = text.slice(0, -1)

        const values = text.split(",")

        // for (let i = 1; i <= values.length; i++) {
        //     text += `$${i},`;
        // }

        text = text2.slice(0, -1)
        
        const textQuery = `INSERT INTO regions.social_day_service_types(social_day_id,service_type_id,service_subtype_id,age_range_id,n_mans,n_womans) VALUES ${text};`
            
        // return {textQuery,values}
        // Insertar tipo de servicio
        const resp = await query(textQuery, values)

        if (resp.rowCount == 0) {
            return reply.code(500).send({ error: "No se logro registrar", status: "failed" });
        }

        return reply.send({ status: "ok", msg: `Se registro con exito` });


    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

module.exports = {
    getAllMobileUnits,
    getMobileUnitsById,
    insertMobileUnits,
    insertMobileUnitsDetails,
    getMobileUnitsByUser
}