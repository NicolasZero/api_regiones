const controller = require("../controllers/controller.archievement");

module.exports = async function (fastify) {
  fastify.get("/", controller.getAllArchievement);
  fastify.get("/id/:id", controller.getArchievementById);
  fastify.post("/", controller.insertArchievement);
}
