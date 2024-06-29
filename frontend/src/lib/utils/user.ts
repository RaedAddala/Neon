import type { User, UserFetchData } from '@/types';

export function userMapper({
	profile_picture,
	updated_at,
	inserted_at,
	...data
}: UserFetchData): User {
	return {
		...data,
		profilePicture: profile_picture,
		insertedAt: new Date(inserted_at),
		updatedAt: new Date(updated_at),
		followers: [],
		following: []
	};
}
