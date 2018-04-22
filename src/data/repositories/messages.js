import type { Message } from '../../domain/types/message';
import type { Repository, Model, Error } from '../../domain/types/common';

export default class Messages implements Repository<number, Message> {
  model: Model<number, Message>;
  constructor({ model }: Object) {
    this.model = model;
  }

  getAll(): Promise<Array<Message>> {
    return this.model.findAll({ order: ['id'] });
  }

  getById(id: number): Promise<Message> {
    return this.model.findById(id);
  }

  create(message: Message): Promise<Message> {
    return this.model.create(message);
  }

  update(id: number, message: Message): Promise<any> {
    return this.model
      .update(message, {
        where: { id },
        returning: true,
        plain: true,
      })
      .then((result: any) => ((result && result[1] ? result[1] : { error: 'Message not found' }): Error))
      .catch(() => ({ error: 'Message not found' }: Error));
  }

  delete(id: number): Promise<number> {
    return this.model.destroy({
      where: {
        id,
      },
    });
  }
}
