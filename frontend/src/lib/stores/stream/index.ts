import { writable, type Writable } from 'svelte/store';

export const mediaStream: Writable<MediaStream | null> = writable(null);
