<script lang="ts">
	import Chat from '$lib/components/chat/Chat.svelte';
	import VideoPlayer from '@/components/stream/VideoPlayer.svelte';
</script>

<div class="grid grid-cols-[3fr_1fr] gap-2 px-2 pt-2">
	<VideoPlayer />
	<Chat />
</div>
