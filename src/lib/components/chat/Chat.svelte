<script lang="ts">
	import { page } from '$app/stores';
	import { Socket } from 'phoenix';
	import { onMount } from 'svelte';

	const { username } = $page.params;

	onMount(() => {
		const socket = new Socket('ws://localhost:4000/socket');

		socket.connect();

		const channel = socket.channel(`chat:${username}`);

		channel
			.join()
			.receive('ok', (_resp) => {
				channel.push('shout', {});

				channel.on('shout', () => {
					console.info('A user just shouted the lobby!');
				});
			})
			.receive('error', (resp) => {
				console.log('Unable to join', resp);
			});
	});
</script>

<p>Chat</p>
