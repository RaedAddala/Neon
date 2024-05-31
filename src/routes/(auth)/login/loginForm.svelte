<script lang="ts">
	import * as Form from '$lib/components/ui/form';
	import { Input } from '$lib/components/ui/input';
	import { type SuperValidated, type Infer, superForm } from 'sveltekit-superforms';
	import { zodClient } from 'sveltekit-superforms/adapters';
	import { loginFormSchema, type LoginFormSchema } from './schema.zod';
	import { page } from '$app/stores';

	export let data: SuperValidated<Infer<LoginFormSchema>>;

	const form = superForm(data, {
		validators: zodClient(loginFormSchema)
	});

	const { form: formData, enhance } = form;
	$: errorMessage = $page.form?.message;
</script>

<form method="POST" use:enhance class="flex flex-col">
	<Form.Field {form} name="email">
		<Form.Control let:attrs>
			<Form.Label>Email</Form.Label>
			<Input {...attrs} bind:value={$formData.email} />
		</Form.Control>
		<Form.Description>This is your account email.</Form.Description>
		<Form.FieldErrors />
	</Form.Field>
	<Form.Field {form} name="password">
		<Form.Control let:attrs>
			<Form.Label>Password</Form.Label>
			<Input {...attrs} bind:value={$formData.password} type="password" />
		</Form.Control>
		<Form.Description>This is your password.</Form.Description>
		<Form.FieldErrors />
	</Form.Field>
	<Form.Button type="submit" style="background-color:#F7DD72" class="w-full">Login</Form.Button>
	{#if errorMessage != undefined}
		<div class="text-red-900">{errorMessage}</div>
	{/if}
	<div>New here? <a href="/signup" style="color: #5AB1BB;"> Sign up here </a></div>
</form>
