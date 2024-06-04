import { z } from 'zod';
const MAX_FILE_SIZE = 2_000_000;
const ACCEPTED_IMAGE_TYPES = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'];

export const editProfileFormSchema = z.object({
	token: z.string(),
	profile_picture: z
		.instanceof(File, { message: 'Please upload a file.' })
		.refine((file) => file.size <= MAX_FILE_SIZE, `Max image size is 2MB.`)
		.refine(
			(file) => ACCEPTED_IMAGE_TYPES.includes(file.type),
			'Only .jpg, .jpeg, .png and .webp formats are supported.'
		)
		.optional(),
	username: z
		.string()
		// .refine(
		// 	(value) => !/[^\w-]/.test(value),
		// 	"Only alphanumeric characters, '_' and '-' are allowed."
		// )
		.optional(),
	password: z
		.string()
		// .refine((value) => /[a-z]/.test(value), 'Missing a lowercase letter.')
		// .refine((value) => /[A-Z]/.test(value), 'Missing an uppercase letter.')
		// .refine((value) => /[0-9]/.test(value), 'Missing a number.')
		// .refine((value) => /[^a-zA-Z0-9]/.test(value), 'Missing a symbol.')
		// .refine((value) => !/\s/.test(value), 'No whitespace characters.')
		.optional(),
	confirmPassword: z
		.string()
		.min(8)
		.refine((value) => /[a-z]/.test(value), 'Missing a lowercase letter.')
		.refine((value) => /[A-Z]/.test(value), 'Missing an uppercase letter.')
		.refine((value) => /[0-9]/.test(value), 'Missing a number.')
		.refine((value) => /[^a-zA-Z0-9]/.test(value), 'Missing a symbol.')
		.refine((value) => !/\s/.test(value), 'No whitespace characters.')
});

export type EditProfileFormSchema = typeof editProfileFormSchema;
