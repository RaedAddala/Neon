import type { PageServerLoad, Actions } from './$types.js';
import { fail } from '@sveltejs/kit';
import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { loginFormSchema } from './schema.zod.js';
import apiGatewayFetch from '@/utils/apiGatewayFetch.js';
import type { Auth } from '../../lib/types/index.js';
import { writableAuth } from '../../lib/stores/index.js';

export const load: PageServerLoad = async () => {
	return {
		form: await superValidate(zod(loginFormSchema))
	};
};
export const actions = {
	default: async (event) => {
		const form = await superValidate(event, zod(loginFormSchema));

		if (!form.valid) {
			return fail(400, {
				form
			});
		}

		//login request here

		const data = form.data;
		const res: Auth = await apiGatewayFetch('/auth/login', {
			method: 'POST',
			body: JSON.stringify({ user: data })
		});

		writableAuth.set(res);

		return {
			form
		};
	}
} satisfies Actions;
