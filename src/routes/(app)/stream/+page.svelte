<script lang="ts">
	import StartStreamButton from '$lib/components/stream/StartStreamButton.svelte';
	import StopStreamButton from '$lib/components/stream/StopStreamButton.svelte';
	import VideoPlayer from '$lib/components/stream/VideoPlayer.svelte';
</script>

<div class="flex gap-2">
	<StartStreamButton />
	<StopStreamButton />
</div>
<VideoPlayer />
