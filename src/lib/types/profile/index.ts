export interface User {
	id: string;
	username: string;
	email: string;
	profilePicture: string;
	creationDate: Date;
	followers: User[];
	following: User[];
}

export const UserMapper = (user: any): User => {
	const mappedUser: User = {
		id: user.id,
		username: user.username,
		email: user.email,
		profilePicture: user.profile_picture,
		creationDate: new Date(user.inserted_at),
		followers: [],
		following: []
	};
	return mappedUser;
};

export type MessageUser = Pick<User, 'username'> & Partial<Pick<User, 'profilePicture'>>;
