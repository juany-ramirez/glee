// Types
// Domain entities
export type Message = {
    id: number,
    title: string,
    mensaje: string,
    public: boolean
  };
  
  // Commands
  export type Command = {
    type: string
  };
  
  export type GetAllMessagesCommand = {
    type: string
  };
  
  export type GetOneMessageCommand = {
    type: string,
    id: number
  };
  
  export type RemoveMessageCommand = {
    type: string,
    id: number
  };
  
  export type CreateMessageCommand = {
    type: string,
    message: Message
  };
  
  export type UpdateMessageCommand = {
    type: string,
    id: number,
    modify: Message
  };