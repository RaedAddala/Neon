export interface User {
	id: string;
	username: string;
	email: string;
	profilePicture: string;
	creationDate: Date;
	followers: User[];
	following: User[];
}

export type PartialUser = Pick<User, 'username'> & Partial<Pick<User, 'profilePicture'>>;
