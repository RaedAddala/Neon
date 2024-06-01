import type { FetchError } from '@/errors';
import { type SuperValidated } from 'sveltekit-superforms';

type SignupSchema = {
	username: string;
	email: string;
	password: string;
	profile_picture?: File;
};

type ZodSignupForm = SuperValidated<SignupSchema>;

export async function handleSignupError(
	{ response }: FetchError,
	form: ZodSignupForm
): Promise<ZodSignupForm> {
	if (response.status !== 422) {
		return form;
	}

	const errorData = await response.json();

	if (!errorData.errors) {
		return form;
	}

	const { errors } = errorData as { errors: { [key in keyof SignupSchema]: string[] } };

	Object.entries(errors).forEach(([key, values]) => {
		const message = values.find((message) => message.match(/taken/i));

		if (!message) {
			return;
		}

		form.errors[key as keyof SignupSchema] = [message];
	});

	return form;
}
