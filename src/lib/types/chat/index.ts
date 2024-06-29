import type { PartialUser } from '../profile';

export interface Message {
	id: string;
	message: string;
	user: PartialUser;
	date: string | Date;
}
