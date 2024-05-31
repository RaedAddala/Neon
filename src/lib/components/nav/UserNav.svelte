<script lang="ts">
	import * as DropdownMenu from '../ui/dropdown-menu';
	import * as Avatar from '../ui/avatar';
	import Button from '../ui/button/button.svelte';
	import type { User } from '$lib/types';
	import { writableAuth, writableUser } from '../../stores';
	import { goto } from '$app/navigation';
	import { browser } from '$app/environment';

	export let user: User;

	function logout() {
		if (!browser) {
			return;
		}

		writableAuth.set(null);
		writableUser.set(null);

		goto('/');
	}
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger asChild let:builder>
		<Button variant="ghost" builders={[builder]} class="relative h-8 w-8 rounded-full">
			<Avatar.Root class="h-8 w-8">
				<Avatar.Image
					src={import.meta.env.VITE_BACKEND_URL + '/auth/' + user.profilePicture}
					alt={user.username}
				/>
				<Avatar.Fallback>{user.username.charAt(0).toUpperCase()}</Avatar.Fallback>
			</Avatar.Root>
		</Button>
	</DropdownMenu.Trigger>
	<DropdownMenu.Content class="w-56" align="end">
		<DropdownMenu.Label class="font-normal">
			<div class="flex flex-col space-y-1">
				<p class="text-sm font-medium leading-none">{user.username}</p>
				<p class="text-xs leading-none text-muted-foreground">{user.email}</p>
			</div>
		</DropdownMenu.Label>
		<DropdownMenu.Separator />
		<DropdownMenu.Group>
			<DropdownMenu.Item>Profile</DropdownMenu.Item>
		</DropdownMenu.Group>
		<DropdownMenu.Separator />
		<DropdownMenu.Item on:click={logout}>Log out</DropdownMenu.Item>
	</DropdownMenu.Content>
</DropdownMenu.Root>
