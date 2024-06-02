<script lang="ts">
	import { page } from '$app/stores';
	import type { Message as MessageType } from '$lib/types';
	import { Channel } from 'phoenix';
	import { onMount, tick } from 'svelte';
	import Message from './Message.svelte';
	import { auth } from '$lib/stores';
	import { ScrollArea } from '../ui/scroll-area';
	import { Textarea } from '../ui/textarea';
	import { Button } from '../ui/button';
	import { Separator } from '../ui/separator';
	import { getSocket, getChannel, getChatTopic } from '@/utils/socket';

	const { username } = $page.params;

	let channel: Channel | null = null;

	let messages: MessageType[] = [];
	let currentMessage = '';

	let scrollArea: HTMLDivElement | null = null;
	let messagesContainer: HTMLDivElement | null = null;

	let isAtChatEnd = true;

	function sendMessage() {
		const messageContents = currentMessage.trim();
		if (messageContents === '') {
			return;
		}

		if (channel === null) {
			return;
		}

		const message = {
			id: crypto.randomUUID(),
			message: messageContents
		} as MessageType;

		channel.push('shout', message);

		currentMessage = '';
	}

	async function receiveMessage(message: MessageType) {
		messages[messages.length] = message;

		if (!messagesContainer || !isAtChatEnd) {
			return;
		}

		await tick();

		messagesContainer.scrollIntoView(false);
	}

	function handleClick() {
		sendMessage();
	}

	function handleKeyDown(event: KeyboardEvent) {
		if (event.key !== 'Enter' || event.shiftKey) {
			return;
		}

		event.preventDefault();
		sendMessage();
	}

	function handleScrollend() {
		if (!scrollArea || !messagesContainer) {
			return;
		}

		const { bottom: scrollAreaBottom } = scrollArea.getBoundingClientRect();
		const { bottom: messagesContainerBottom } = messagesContainer.getBoundingClientRect();

		isAtChatEnd = messagesContainerBottom <= scrollAreaBottom;
	}

	onMount(async () => {
		const socket = getSocket('live-chat');
		channel = await getChannel(socket, getChatTopic(username));

		channel.on('shout', receiveMessage);
	});
</script>

<div class="flex flex-col">
	<div class="px-2 py-1">Chat</div>
	<Separator />
	<div bind:this={scrollArea} on:scrollend|capture={handleScrollend} class="flex-1">
		<ScrollArea class="h-0 min-h-full px-2 pb-1">
			<div bind:this={messagesContainer}>
				{#each messages as message (message.id)}
					<Message {message}></Message>
				{/each}
			</div>
		</ScrollArea>
	</div>

	<div class="flex gap-2">
		<Textarea
			class="h-10 min-h-0 resize-none py-2"
			disabled={$auth == null}
			bind:value={currentMessage}
			on:keydown={handleKeyDown}
		/>
		<Button disabled={$auth == null} on:click={handleClick}>Send</Button>
	</div>
</div>
