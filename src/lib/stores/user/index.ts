import type { User } from '$lib/types';
import { readonly, type Readable, type Writable } from 'svelte/store';
import { storage } from '../storage';

export const writableUser: Writable<User | null> = storage<User>('user', null, (set) => {
	set({
		id: '6d40b833-c4e3-475e-8f78-3dc97dca042f',
		username: 'user',
		email: 'user@neon.com',
		creationDate: new Date(),
		profilePicture: '',
		followers: [],
		following: []
	});
});
export const user: Readable<User | null> = readonly(writableUser);
