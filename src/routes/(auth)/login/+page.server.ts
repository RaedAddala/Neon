import type { PageServerLoad, Actions } from './$types.js';
import { error, fail, redirect } from '@sveltejs/kit';
import { message, superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { loginFormSchema } from './schema.zod.js';
import apiGatewayFetch from '@/utils/apiGatewayFetch.js';
import type { Auth } from '@/types';
import { writableAuth } from '@/stores';

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
		try {
			const data = form.data;
			const res: Auth = await apiGatewayFetch('/auth/login', {
				method: 'POST',
				body: JSON.stringify({ user: data })
			});

			writableAuth.set(res);
		} catch (err) {
			return fail(400, { form, message: 'login unsuccessful - verify your credentials' });
		}

		redirect(303, '/');
	}
} satisfies Actions;
