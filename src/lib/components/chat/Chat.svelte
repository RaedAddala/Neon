<script lang="ts">
	import { page } from '$app/stores';
	import type { Message as MessageType } from '$lib/types';
	import { Channel, Socket } from 'phoenix';
	import { onMount } from 'svelte';
	import Message from './Message.svelte';
	import { user } from '$lib/stores';

	const { username } = $page.params;

	let channel: Channel | null = null;

	const messages: MessageType[] = [];
	let currentMessage = '';

	function handleClick(_event: Event) {
		const messageContents = currentMessage.trim();
		if (messageContents === '') {
			return;
		}

		if (channel === null) {
			return;
		}

		const message: MessageType = {
			user: {
				username: $user!.username,
				profilePicture: $user!.profilePicture
			},
			date: new Date(),
			message: messageContents,
			messageId: crypto.randomUUID()
		};

		channel.push('shout', message);

		currentMessage = '';
	}

	onMount(() => {
		const socket = new Socket('ws://localhost:4000/socket');

		socket.connect();

		const channel_ = socket.channel(`chat:${username}`);

		channel_
			.join()
			.receive('ok', (_resp) => {
				channel = channel_;
			})
			.receive('error', (resp) => {
				console.log('Unable to join', resp);
			});
	});
</script>

<div>
	<h2>Chat</h2>

	<div>
		{#each messages as message}
			<Message {message}></Message>
		{/each}
	</div>

	<div>
		<input bind:value={currentMessage} />
		<button type="button" on:click={handleClick}>Send</button>
	</div>
</div>
