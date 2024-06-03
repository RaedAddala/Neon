import type { PageServerLoad, Actions } from './$types.js';
import { fail } from '@sveltejs/kit';
import { superValidate } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { loginFormSchema } from './schema.zod.js';
import type { FetchData, Auth, UserFetchData } from '@/types';
import { jwtDecode } from 'jwt-decode';
import { getFetchWrapper } from '@/utils/fetch';
import { userMapper } from '@/utils/user';

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

		const apiGatewayFetch = getFetchWrapper(event.fetch);

		try {
			const data = form.data;
			const auth: Auth = await apiGatewayFetch('/auth/login', {
				method: 'POST',
				body: JSON.stringify(data)
			});

			const userId = jwtDecode(auth.token).sub as string;

			const { data: fetchData } = await apiGatewayFetch<FetchData<UserFetchData>>(
				`/users/${userId}`,
				{
					method: 'GET'
				}
			);

			const user = userMapper(fetchData);

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
