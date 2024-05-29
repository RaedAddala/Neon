import { z } from 'zod';
const MAX_FILE_SIZE = 5000000;
const ACCEPTED_IMAGE_TYPES = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'];

export const signinFormSchema = z.object({
	profile_picture: z
		.any()
		.refine((file) => file?.size <= MAX_FILE_SIZE, `Max image size is 5MB.`)
		.refine(
			(file) => ACCEPTED_IMAGE_TYPES.includes(file?.type),
			'Only .jpg, .jpeg, .png and .webp formats are supported.'
		),
	username: z.string(),
	email: z.string().email(),
	password: z.string().regex(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,}$/, {
		message:
			'Password must contain uppercase and lowercase letters, symbols, digits and must be at least 8 characters long.'
	})
});

export type SigninFormSchema = typeof signinFormSchema;
