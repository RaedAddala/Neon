<script lang="ts">
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';
	import { user, writableUser } from '@/stores';
	import { Separator } from '$lib/components/ui/separator/index.js';
	import ProfileCard from '../../../lib/components/user/ProfileCard.svelte';
	import UserAvatar from '../../../lib/components/user/UserAvatar.svelte';
	import UpdateProfileForm from './updateProfileForm.svelte';
	import type { PageData } from './$types';
	import { browser } from '$app/environment';
	import { page } from '$app/stores';
	import type { User } from '../../../lib/types';

	$: {
		if (browser && $page.form?.user) {
			const { user }: { user: User } = $page.form;

			writableUser.set(user);
		}
	}
	onMount(() => {
		if (!$user) {
			goto('/login');
		}
	});

	export let data: PageData;
</script>

{#if $user}
	<div class="flex h-full w-full flex-col items-center">
		<div style="width: 80%;">
			<ProfileCard />

			<Separator class="my-4" />
			<div class="flex h-full w-full flex-row justify-between">
				<div class="m-0 mb-4 font-serif text-2xl text-gray-200">Profile Settings:</div>
				<UpdateProfileForm data={data.form} />
				<div class="float-end mr-40">
					<UserAvatar user={$user} className="h-48 w-48" />
				</div>
			</div>
		</div>
	</div>
{/if}
