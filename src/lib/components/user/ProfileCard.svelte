<script>
	import { user } from '@/stores';
	import UserAvatar from './UserAvatar.svelte';
</script>

<div class="m-3 ml-8 flex flex-row items-center text-2xl font-thin">
	{#if $user}
		<UserAvatar user={$user} className="h-16 w-16" />
		<div class="ml-5">
			<div>
				<span> {$user.username}</span>
				<span class="ml-2 text-sm text-gray-500"> ({$user.email}) </span>
			</div>
			<div class="text-sm text-gray-600">
				Joined: {new Date($user.insertedAt).toISOString().split('T')[0]}
			</div>
		</div>
	{/if}
</div>
