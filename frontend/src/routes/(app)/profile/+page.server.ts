import { fail, type Actions } from '@sveltejs/kit';
import { superValidate, withFiles } from 'sveltekit-superforms';
import { zod } from 'sveltekit-superforms/adapters';
import { editProfileFormSchema } from './schema.zod';
import type { PageServerLoad } from './$types.js';
import type { FetchData, UserFetchData } from '@/types';
import { jwtDecode } from 'jwt-decode';
import { getFetchWrapper } from '@/utils/fetch';
import { userMapper } from '@/utils/user';

export const load: PageServerLoad = async () => {
	return {
		form: await superValidate(zod(editProfileFormSchema))
	};
};
export const actions = {
	default: async (event) => {
		const form = await superValidate(event, zod(editProfileFormSchema));

		if (!form.valid) {
			return fail(
				400,
				withFiles({
					form
				})
			);
		}
		const userId = jwtDecode(form.data.token).sub as string;

		const formData = Object.entries(form.data).reduce((formData, [key, value]) => {
			if (value && key != 'token') {
				formData.append(key, value);
			}
			return formData;
		}, new FormData());
		console.log(formData);

		const apiGatewayFetch = getFetchWrapper(event.fetch);
		console.log(userId);

		try {
			const { data: fetchData } = await apiGatewayFetch<FetchData<UserFetchData>>(
				`/users/${userId}`,
				{
					method: 'PUT',
					body: formData
				}
			);
			const user = userMapper(fetchData);

			return withFiles({
				form,
				user
			});
		} catch (err) {
			// if (err instanceof FetchError) {
			// 	await handleSignupError(err, form);
			// }
			console.log('fail', err);

			return fail(400, withFiles({ form, message: 'Update - try again' }));
		}
	}
} satisfies Actions;
