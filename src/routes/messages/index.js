import Joi from 'joi';

import type { Command } from '../../domain/types/message';

export function register(server: Object, options: Object, next: () => mixed) {
  const dispatch = (cmd: Command) =>
    new Promise((resolve) => {
      server.app.dispatcher.dispatch(cmd).subscribe((response) => {
        resolve(response);
      });
    });
  server.route([
    {
      method: 'GET',
      path: '/messages',
      config: {
        tags: ['api'],
        auth: false,
        handler: (request, reply) => {
          reply(
            dispatch({
              type: 'getAllMessages',
            }),
          );
        },
      },
    },
    // {
    //   method: 'POST',
    //   path: '/messages',
    //      auth: false,
    //   config: {
    //     tags: ['api'],
    //     handler: (request, reply) => {
    //       reply(
    //         dispatch({
    //           type: 'createMessages',
    //           name: 'purple-urple',
    //           age: 25,
    //           bloodType: 'B+',
    //         }),
    //       );
    //     },
    //   },
    // },
  ]);

  next();
}

exports.register.attributes = require('./package.json');