import { fail, type Actions } from '@sveltejs/kit';
import { superValidate, withFiles } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { signupFormSchema } from './schema.zod.js';
import type { PageServerLoad } from './$types.js';
import type { Auth, FetchData, UserFetchData } from '@/types';
import { jwtDecode } from 'jwt-decode';
import { getFetchWrapper } from '@/utils/fetch';
import { userMapper } from '@/utils/user';
import { FetchError } from '@/errors';
import { handleSignupError } from '@/utils/errors';

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

		const apiGatewayFetch = getFetchWrapper(event.fetch);

		try {
			const auth: Auth = await apiGatewayFetch('/auth/register', {
				method: 'POST',
				body: formData
			});

			const userId = jwtDecode(auth.token).sub as string;

			const { data: fetchData } = await apiGatewayFetch<FetchData<UserFetchData>>(
				`/auth/users/${userId}`,
				{
					method: 'GET'
				}
			);

			const user = userMapper(fetchData);

			return withFiles({
				form,
				auth,
				user
			});
		} catch (err) {
			if (err instanceof FetchError) {
				await handleSignupError(err, form);
			}

			return fail(400, withFiles({ form, message: 'Sign-up failed - try again' }));
		}
	}
} satisfies Actions;
