import type { Auth } from '$lib/types';
import { readonly, type Readable, type Writable } from 'svelte/store';
import { storage } from '../storage';

export const writableAuth: Writable<Auth | null> = storage<Auth>('auth', null);
export const auth: Readable<Auth | null> = readonly(writableAuth);
