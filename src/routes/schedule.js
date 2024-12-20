const controller = require("../controllers/controller.schedule");

module.exports = async function (fastify) {
  fastify.get("/", controller.getAllScheduled);
  fastify.get("/id/:id", controller.getScheduledById);
  fastify.get("/user/:id", controller.getAllScheduledbyUser);
  fastify.put("/", controller.updateScheduled);
}
