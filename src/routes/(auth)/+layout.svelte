<script lang="ts">
	import { browser } from '$app/environment';
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';
	import AuthNav from '@/components/auth/AuthNav.svelte';
	import { auth, writableAuth, writableUser } from '@/stores';
	import type { Auth, User } from '@/types';
	import { onMount } from 'svelte';

	$: {
		if (browser && $page.form?.auth) {
			const { auth, user }: { auth: Auth; user: User } = $page.form;

			writableAuth.set(auth);
			writableUser.set(user);

			goto('/');
		}
	}

	onMount(() => {
		if ($auth) {
			goto('/');
		}
	});
</script>

<div class="flex h-full max-h-full flex-col justify-start">
	<AuthNav />
	<main class="h-full">
		<slot />
	</main>
</div>
