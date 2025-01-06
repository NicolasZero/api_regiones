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

        // Verifica que el id exista
        const verification = query(`SELECT * FROM regions.social_day_achievements WHERE id = $1;`,[id])

        if (verification.rowCount == 0) {
            return reply.code(500).send({ error: "No se logro registrar", status: "failed" });
        }

        // Agregar verificacion de que no exista otros detalles de unidades moviles, aquí :v

        // Tipo de atencion
        let textType = `${id},`
        let textTypeValue = ""

        // Discapacidad
        let textDisability = `${id},`
        let textDisabilityValue = ""

        // Etnia
        let textEthnicity = `${id},`
        let textEthnicityValue = ""

        // Variables para los foreach
        let a = 1 // Tipo
        let b = 1 // Discapacidad
        let c = 1 // Etnia

        attentionTypes.forEach(attention => {
            attention.ageRanges.forEach(e => {
                textType += `${attention.type},${attention.subType?attention.subType:0},${e.range},${e.men},${e.women},`
                textTypeValue += `($1,$${a+1},$${a+2},$${a+3},$${a+4},$${a+5}),`
                a += 5
            })

            attention.disabilities.forEach(disability => {
                disability.ageRanges.forEach(e => {
                    textDisability += `${attention.type},${disability.type},${e.range},${e.men},${e.women},`
                    textDisabilityValue += `($1,$${b+1},$${b+2},$${b+3},$${b+4},$${b+5}),`
                    b += 5
                })
            })

            attention.ethnicities.forEach(ethnicity => {
                ethnicity.ageRanges.forEach(e => {
                    textEthnicity += `${attention.type},${ethnicity.type},${e.range},${e.men},${e.women},`
                    textEthnicityValue += `($1,$${c+1},$${c+2},$${c+3},$${c+4},$${c+5}),`
                    c += 5
                })
            })
        })

        // ===== Tipo de servicio ===== //
        let values = textType.slice(0, -1).split(",") // Transformar en array y eliminar la ultima coma
        let textInsert = textTypeValue.slice(0, -1) // Eliminar la ultima coma
        let textQuery = `INSERT INTO regions.social_day_service_types(social_day_id,service_type_id,service_subtype_id,age_range_id,n_mans,n_womans) VALUES ${textInsert};`

        let resp = await query(textQuery, values)

        if (resp.rowCount == 0) {
            return reply.code(500).send({ error: "No se logro registrar", status: "failed" });
        }

        // ===== Discapacidad ===== //
        values = textDisability.slice(0, -1).split(",")
        textInsert = textDisabilityValue.slice(0, -1)
        textQuery = `INSERT INTO regions.social_day_disability (social_day_id,service_type_id,disability_id,age_range_id,n_mans,n_womans) VALUES ${textInsert};`

        resp = await query(textQuery, values)

        if (resp.rowCount == 0) {
            query(`DELETE FROM regions.social_day_service_types WHERE id = $1;`,[id])
            return reply.code(500).send({ error: "No se logro registrar", status: "failed" });
        }

        // ===== Etnia ===== //
        values = textEthnicity.slice(0, -1).split(",")
        textInsert = textEthnicityValue.slice(0, -1)
        textQuery = `INSERT INTO regions.social_day_ethnicity (social_day_id,service_type_id,ethnicity_id,age_range_id,n_mans,n_womans) VALUES ${textInsert};`

        resp = await query(textQuery, values)

        if (resp.rowCount == 0) {
            query(`DELETE FROM regions.social_day_service_types WHERE id = $1;`,[id])
            query(`DELETE FROM regions.social_day_disability WHERE id = $1;`,[id])
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