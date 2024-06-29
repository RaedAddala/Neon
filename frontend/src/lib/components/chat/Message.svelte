<script lang="ts">
	import type { Message } from '$lib/types';
	import UserDisplay from './UserDisplay.svelte';

	export let message: Message;

	const { message: contents, user, date } = message;

	function formatDate(date: Date | string) {
		const dateISOString = new Date(date).toISOString();

		return dateISOString.replace(/.*T/, '').replace(/:\d{2}\..*/, '');
	}
</script>

<div>
	<span class="text-muted-foreground">{formatDate(date)}</span>
	<UserDisplay {user} />
	<span class="break-all">
		{contents}
	</span>
</div>
