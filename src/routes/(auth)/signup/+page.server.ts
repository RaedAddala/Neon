import { fail, type Actions } from '@sveltejs/kit';
import { superValidate, withFiles } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { signupFormSchema } from './schema.zod.js';
import type { PageServerLoad } from './$types.js';
import { UserMapper, type Auth, type User } from '@/types';
import apiGatewayFetch from '@/utils/apiGatewayFetch.js';
import { jwtDecode } from 'jwt-decode';

export const load: PageServerLoad = async () => {
	return {
		form: await superValidate(zod(signupFormSchema))
	};
};
export const actions = {
	default: async (event) => {
		const form = await superValidate(event, zod(signupFormSchema));

		if (!form.valid) {
			return fail(
				400,
				withFiles({
					form
				})
			);
		}

		const formData = Object.entries(form.data).reduce((formData, [key, value]) => {
			if (value) {
				formData.append(key, value);
			}
			return formData;
		}, new FormData());

		try {
			const auth: Auth = await apiGatewayFetch('/auth/register', {
				method: 'POST',
				body: formData
			});
			const userId: string | undefined = jwtDecode(auth.token).sub;

			let user: User = (
				await apiGatewayFetch(`/auth/users/${userId}`, {
					method: 'GET'
				})
			)?.data;

			user=UserMapper(user)

			return withFiles({
				form,
				auth,
				user
			});
		} catch (err) {
			return fail(400, withFiles({ form, message: 'Sign-up failed - try again' }));
		}
	}
} satisfies Actions;
