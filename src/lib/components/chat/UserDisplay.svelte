<script lang="ts">
	import type { PartialUser } from '@/types';
	import { Root, Trigger, Content } from '../ui/dropdown-menu';
	import UserAvatar from '../user/UserAvatar.svelte';
	import Button from '../ui/button/button.svelte';

	export let user: PartialUser;
</script>

<Root>
	<Trigger><span>{`@${user.username}`}</span>:</Trigger>
	<Content>
		<div class="flex items-center px-2 py-1">
			<UserAvatar {user} />
			<Button data-sveltekit-reload variant="link" class="p-2" href={`/watch/${user.username}`}>
				{`${user.username}`}
			</Button>
		</div>
	</Content>
</Root>
