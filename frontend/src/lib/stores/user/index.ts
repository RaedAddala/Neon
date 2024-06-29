import type { User } from '$lib/types';
import { readonly, type Readable, type Writable } from 'svelte/store';
import { storage } from '../storage';

export const writableUser: Writable<User | null> = storage<User>('user', null);
export const user: Readable<User | null> = readonly(writableUser);
