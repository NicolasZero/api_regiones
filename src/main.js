const fastify = require('fastify')()
require('dotenv').config()


fastify.get('/', async (request, reply) => {
    return { hello: 'world' }
})

// Nombre de las rutas
const routeName = ['archievement', 'user', 'worker']

routeName.forEach((route) => {
    fastify.register(require(`./routes/route.${route}.js`), { prefix: `${route}` })
})

const start = async () => {
    const port = process.env.PORT || 3000;
    const host = process.env.HOST || "0.0.0.0";
    try {
      // Start the server on port 3000, listening on all network interfaces
      await fastify.listen({ port: port, host: host });
      // Log a message to indicate that the API is online
      console.log(`API running on the port ${port} and host ${host}`);
    } catch (err) {
      // Log any error that occurs during server startup and exit the process
      fastify.log.error(err);
      process.exit(1);
    }
  };
  
start()