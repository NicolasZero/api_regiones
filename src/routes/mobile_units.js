const controller = require("../controllers/controller.mobile_units");

module.exports = async function (fastify) {
  // Todos
  fastify.get("/", controller.getAllMobileUnits(''));
  // Todos los logrados
  fastify.get("/achieved", controller.getAllMobileUnits('WHERE status_id = 1'));
  // Todos los agendados
  fastify.get("/scheduled", controller.getAllMobileUnits('WHERE status_id = 2'));
  // Todos los no logrados
  fastify.get("/unachieved", controller.getAllMobileUnits('WHERE status_id = 3'));
  // Por id del registro 
  fastify.get("/id/:id", controller.getMobileUnitsById);
  // Todos de un usuario especifico
  fastify.get("/user/:id", controller.getMobileUnitsByUser);
  // Todos de un usuario especifico
  fastify.get("/achieved/user/:id", controller.getMobileUnitsByUser('AND status_id = 1'));
  // Todos de un usuario especifico
  fastify.get("/scheduled/user/:id", controller.getMobileUnitsByUser('AND status_id = 2'));
  // Todos de un usuario especifico
  fastify.get("/unachieved/user/:id", controller.getMobileUnitsByUser('AND status_id = 3'));
  fastify.post("/", controller.insertMobileUnits);
  fastify.post("/details", controller.insertMobileUnitsDetails);
}
