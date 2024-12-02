const { query } = require("../db/postgresql");

const getAllArchievement = async (request, reply) => {
    try {
        const textQuery = `SELECT * FROM regions.achievements;`
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
        const textQuery = `SELECT * FROM regions.achievements WHERE id = $1;`
        const resp = await query(textQuery,[id])
        return reply.send({status: "ok", msg:`Se encontro ${resp.rowCount} resultado`, data: resp.rows[0]});
    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}

const insertArchievement = async (request, reply) => {
    try {
        const {} = request.body


    } catch (error) {
        console.log(error);
        return reply.code(500).send({ error: "error en la peticion", status: "failed" });
    }
}


module.exports = {
    getAllArchievement,
    getArchievementById
}