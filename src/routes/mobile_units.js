const controller = require("../controllers/controller.mobile_units");

module.exports = async function (fastify) {
  fastify.get("/", controller.getAllMobileUnits);
  fastify.get("/id/:id", controller.getMobileUnitsById);
  fastify.post("/", controller.insertMobileUnits);
  fastify.post("/details", controller.insertMobileUnitsDetails);
}
