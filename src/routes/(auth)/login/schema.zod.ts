import { z } from 'zod';

export const loginFormSchema = z.object({
	email: z.string().email(),
	password: z.string().regex(/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,}$/, {
		message:
			'Password must contain uppercase and lowercase letters, symbols, digits and must be at least 8 characters long.'
	})
});

export type LoginFormSchema = typeof loginFormSchema;
