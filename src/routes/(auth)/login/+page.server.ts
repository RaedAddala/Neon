import type { PageServerLoad, Actions } from './$types.js';
import { fail } from '@sveltejs/kit';
import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { loginFormSchema } from './schema.zod.js';
import apiGatewayFetch from '@/utils/apiGatewayFetch.js';
import { UserMapper, type Auth, type User } from '@/types';
import { jwtDecode } from 'jwt-decode';

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
				body: JSON.stringify(data)
			});
			const userId: string | undefined = jwtDecode(auth.token).sub;

			let user: User = (
				await apiGatewayFetch(`/auth/users/${userId}`, {
					method: 'GET'
				})
			)?.data;
			user = UserMapper(user);

			return {
				form,
				auth,
				user
			};
		} catch (err) {
			return fail(400, { form, message: 'Login unsuccessful - verify your credentials' });
		}
	}
} satisfies Actions;
