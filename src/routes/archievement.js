const controller = require("../controllers/controller.archievement");

module.exports = async function (fastify) {
  // Todos los logrados
  fastify.get("/", controller.getAll);
  // Total de todos los logrados
  fastify.get("/total", controller.countAll);
  // Total de todos los logrados
  fastify.get("/total/month/:month/year/:year", controller.countAllForMonth);
  // Logrado por id
  fastify.get("/id/:id", controller.getById);
  // los logrados de un usuario
  fastify.get("/user/:id", controller.getAllByUser);
  // Estadistica
  fastify.get("/statistics/annual/:year",controller.getStatisticsAnnual);
  fastify.get("/statistics/activity",controller.getStatisticsActivity(false));
  fastify.get("/statistics/activity/year/:year",controller.getStatisticsActivity(true));
  // insertar logros o agendar
  fastify.post("/", controller.insert);
}
