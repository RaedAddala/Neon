<script lang="ts">
	import { FileInput } from '@/components/ui/file-input';
	import * as Form from '$lib/components/ui/form';
	import { Input } from '$lib/components/ui/input';
	import { type SuperValidated, type Infer, superForm, fileProxy } from 'sveltekit-superforms';
	import { zodClient } from 'sveltekit-superforms/adapters';
	import { editProfileFormSchema, type EditProfileFormSchema } from './schema.zod';
	import { auth, user } from '@/stores';

	export let data: SuperValidated<Infer<EditProfileFormSchema>>;

	const form = superForm(data, {
		validators: zodClient(editProfileFormSchema)
	});

	const { form: formData, enhance } = form;
	const file = fileProxy(formData, 'profile_picture');
	if ($auth) {
		$formData.token = $auth?.token;
	}
</script>

{#if $user}
	<form method="POST" enctype="multipart/form-data" use:enhance>
		<Form.Field {form} name="username">
			<Form.Control let:attrs>
				<Form.Label>Username</Form.Label>
				<Input {...attrs} bind:value={$formData.username} placeholder={$user.username} />
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
				<Form.Label>Password:</Form.Label>
				<Input {...attrs} bind:value={$formData.password} type="password" />
			</Form.Control>
			<Form.Description>This is your new password.</Form.Description>
			<Form.FieldErrors />
		</Form.Field>
		<!-- {#if errorMessage != undefined}
        <div class="text-red-900">{errorMessage}</div>
        {/if} -->

		<Form.Field {form} name="confirmPassword">
			<Form.Control let:attrs>
				<Form.Label>Old Password:</Form.Label>
				<Input {...attrs} bind:value={$formData.confirmPassword} type="password" />
			</Form.Control>
			<Form.Description>Confirm your identity by inserting your old password.</Form.Description>
			<Form.FieldErrors />
		</Form.Field>

		<Form.Field {form} name="token" class="invisible">
			<Form.Control let:attrs>
				<Input {...attrs} bind:value={$formData.token} />
			</Form.Control>
			<Form.FieldErrors />
		</Form.Field>

		<Form.Button type="submit" style="background-color:#F7DD72" class="w-full"
			>Upadate Profile</Form.Button
		>
	</form>
{/if}
