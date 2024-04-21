<script lang="ts">
	import type { Message } from '$lib/types';

	export let message: Message;
</script>

<div class="flex gap-4">
	<div>{message.user.username}</div>
	<div>{message.message}</div>
</div>
