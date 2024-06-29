<script lang="ts">
	import * as Form from '$lib/components/ui/form';
	import { Input } from '$lib/components/ui/input';
	import { type SuperValidated, type Infer, superForm, fileProxy } from 'sveltekit-superforms';
	import { zodClient } from 'sveltekit-superforms/adapters';
	import { signupFormSchema, type SignupFormSchema } from './schema.zod';
	import { page } from '$app/stores';
	import { FileInput } from '@/components/ui/file-input';

	export let data: SuperValidated<Infer<SignupFormSchema>>;

	const form = superForm(data, {
		validators: zodClient(signupFormSchema)
	});

	const { form: formData, enhance } = form;

	const file = fileProxy(formData, 'profile_picture');

	$: errorMessage = $page.form?.message;
</script>

<form method="POST" enctype="multipart/form-data" use:enhance>
	<Form.Field {form} name="email">
		<Form.Control let:attrs>
			<Form.Label>Email</Form.Label>
			<Input {...attrs} bind:value={$formData.email} />
		</Form.Control>
		<Form.Description>This is your account email.</Form.Description>
		<Form.FieldErrors />
	</Form.Field>

	<Form.Field {form} name="username">
		<Form.Control let:attrs>
			<Form.Label>Username</Form.Label>
			<Input {...attrs} bind:value={$formData.username} />
		</Form.Control>
		<Form.Description>This is your username, choose it well.</Form.Description>
		<Form.FieldErrors />
	</Form.Field>

	<Form.Field {form} name="profile_picture">
		<Form.Control let:attrs>
			<Form.Label>Profile Picture</Form.Label>
			<FileInput {...attrs} bind:files={$file} />
		</Form.Control>
		<Form.Description>Let us see your pretty little face.</Form.Description>
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
	{#if errorMessage != undefined}
		<div class="text-red-900">{errorMessage}</div>
	{/if}
	<Form.Button type="submit" style="background-color:#F7DD72" class="w-full">Sign up</Form.Button>
</form>
<div>Already have an account? <a href="/login" style="color: #5AB1BB;"> Login here </a></div>
