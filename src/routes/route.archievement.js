const controller = require("../controllers/controller.archievement");

module.exports = async function (fastify) {
  fastify.get("/", controller.fun);
}
