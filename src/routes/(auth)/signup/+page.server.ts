import { fail, redirect, type Actions } from '@sveltejs/kit';
import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { signupFormSchema } from './schema.zod.js';
import type { PageServerLoad } from './$types.js';
import type { Auth } from '@/types';
import { writableAuth } from '@/stores';
import apiGatewayFetch from '@/utils/apiGatewayFetch.js';

export const load: PageServerLoad = async () => {
	return {
		form: await superValidate(zod(signupFormSchema))
	};
};
export const actions = {
	default: async (event) => {
		const form = await superValidate(event, zod(signupFormSchema));

		if (!form.valid) {
			return fail(400, {
				form
			});
		}

		//signup request here

		const data = form.data;
		try {
			const res: Auth = await apiGatewayFetch('/auth/register', {
				method: 'POST',
				body: JSON.stringify(data)
			});

			writableAuth.set(res);
		} catch (err) {
			return fail(400, { form, message: 'Sign-up failed - try again ' });
		}
		redirect(303, '/');
		return {
			form
		};
	}
} satisfies Actions;
