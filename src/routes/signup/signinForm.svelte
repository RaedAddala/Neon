<script lang="ts">
	import * as Form from '$lib/components/ui/form';
	import { Input } from '$lib/components/ui/input';
	import { type SuperValidated, type Infer, superForm } from 'sveltekit-superforms';
	import { zodClient } from 'sveltekit-superforms/adapters';
	import { signinFormSchema, type SigninFormSchema } from './schema.zod';

	export let data: SuperValidated<Infer<SigninFormSchema>>;

	const form = superForm(data, {
		validators: zodClient(signinFormSchema)
	});

	const { form: formData, enhance } = form;
</script>

<form method="POST" use:enhance>
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
			<Input type="file" {...attrs} bind:value={$formData.profile_picture} />
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

	<Form.Button type="submit">Sign up</Form.Button>
</form>
<div>Already have a friend? <a href="/login" style="color: #5AB1BB;"> Login here </a></div>
