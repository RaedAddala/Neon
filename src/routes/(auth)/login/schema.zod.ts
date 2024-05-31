import { z } from 'zod';

export const loginFormSchema = z.object({
	email: z.string(),
	password: z.string()
});

export type LoginFormSchema = typeof loginFormSchema;
