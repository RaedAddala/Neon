import type { MessageUser } from '../profile';

export interface Message {
	id: string;
	message: string;
	user: MessageUser;
	date: string | Date;
}
