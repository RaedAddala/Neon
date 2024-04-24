<script lang="ts">
	import type { Message } from '$lib/types';

	export let message: Message;

	const {
		message: contents,
		user: { username },
		date
	} = message;
</script>

<div class="flex gap-4">
	<div>{new Date(date).toLocaleDateString()}</div>
	<div>
		<span>{username}:</span>
		{contents}
	</div>
</div>
