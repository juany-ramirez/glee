let pkg = require('./package.json');
pkg.version =  process.env.APPVERSION || '0.0.1';
export function register(server, options, next) {
  server.route({
    method: 'GET',
    path: '/status',
    config: {
      auth: false,
      tags: ['api'],
      handler: (request, reply) => {
        reply(pkg);
      },
    },
  });
  next();
}

exports.register.attributes = pkg;
