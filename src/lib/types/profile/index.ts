export interface User {
	id: string;
	username: string;
	email: string;
	profilePicture: string;
	insertedAt: Date;
	updatedAt: Date;
	followers: User[];
	following: User[];
}

export interface UserFetchData extends Omit<User, 'profilePicture' | 'insertedAt' | 'updatedAt'> {
	profile_picture: string;
	inserted_at: string;
	updated_at: string;
}

export type MessageUser = Pick<User, 'username'> & Partial<Pick<User, 'profilePicture'>>;
