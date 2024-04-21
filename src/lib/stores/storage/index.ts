import { browser } from '$app/environment';
import type { StartStopNotifier, Writable } from 'svelte/store';
import { get, writable } from 'svelte/store';

export function storage<T>(
	key: string,
	initValue: T | null,
	start?: StartStopNotifier<T | null>
): Writable<T | null> {
	const store: Writable<T | null> = writable<T | null>(initValue, (set, update) => {
		if (!browser) {
			return;
		}

		const storedValue = localStorage.getItem(key);

		if (storedValue != null) {
			set(JSON.parse(storedValue));
			return;
		}

		if (start === undefined) {
			return;
		}

		start(set, update);
	});

	if (!browser) {
		return store;
	}

	store.subscribe((val) => {
		if (val == null) {
			localStorage.removeItem(key);
			return;
		}

		localStorage.setItem(key, JSON.stringify(val));
	});

	window.addEventListener('storage', (event) => {
		const { key: concernedKey, newValue } = event;

		if (!concernedKey) {
			store.set(null);
			return;
		}

		if (concernedKey !== key) {
			return;
		}

		if (newValue === null) {
			store.set(null);
			return;
		}

		const value: T = JSON.parse(newValue);

		if (value !== get(store)) {
			store.set(value);
		}
	});

	return store;
}
