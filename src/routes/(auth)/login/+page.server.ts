import type { PageServerLoad, Actions } from './$types.js';
import { fail } from '@sveltejs/kit';
import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { loginFormSchema } from './schema.zod.js';
import apiGatewayFetch from '@/utils/apiGatewayFetch.js';
import type { Auth } from '@/types';

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

		try {
			const data = form.data;
			const auth: Auth = await apiGatewayFetch('/auth/login', {
				method: 'POST',
				body: JSON.stringify({ user: data })
			});

			return {
				form,
				auth
			};
		} catch (err) {
			return fail(400, { form, message: 'Login unsuccessful - verify your credentials' });
		}
	}
} satisfies Actions;
