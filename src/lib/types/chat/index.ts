import type { MessageUser } from '../profile';

export interface Message {
	user: MessageUser;
	messageId: string;
	date: Date;
	message: string;
}
