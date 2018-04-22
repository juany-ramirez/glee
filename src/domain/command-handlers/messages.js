import type {
  Message,
  GetOneMessageCommand,
  RemoveMessageCommand,
  CreateMessageCommand,
  UpdateMessageCommand,
} from '../types/message';
import type { CommandHandler, Repository } from '../types/common';

export default class Messages implements CommandHandler {
  repository: Repository<any, Message>;

  constructor({ messagesRepository }: Object) {
    console.log(messsagesRepository);
    this.repository = messagesRepository;
  }

  getAllMessages(): Promise<Array<Message>> {
    console.log("asdasda")
    return this.repository.getAll();
  }

  getOneMessage({ id }: GetOneMessageCommand): Promise<Message> {
    return this.repository.getById(id);
  }

  removeMessage({ id }: RemoveMessageCommand) {
    this.repository.delete(id);
  }

  createMessage({ message }: CreateMessageCommand): Promise<Message> {
    return this.repository.create(message);
  }

  modifyMessage({ id, modify }: UpdateMessageCommand): Promise<Message> {
    return this.repository.update(id, modify);
  }
}
