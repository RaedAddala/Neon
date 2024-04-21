export interface User {
	id: string;
	username: string;
	email: string;
	profilePicture: string;
	creationDate: Date;
	followers: User[];
	following: User[];
}

export type MessageUser = Pick<User, 'username' | 'profilePicture'>;
