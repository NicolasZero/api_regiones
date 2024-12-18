const controller = require("../controllers/controller.archievement");

module.exports = async function (fastify) {
  fastify.get("/", controller.getAllArchievement);
  fastify.get("/id/:id", controller.getArchievementById);
  fastify.get("/user/:id", controller.getAllArchievementByUser);
  fastify.post("/", controller.insertArchievement);
}
