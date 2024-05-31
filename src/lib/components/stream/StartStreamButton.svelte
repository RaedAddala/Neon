<script lang="ts">
	import { mediaStream } from '$lib/stores';

	const displayMediaOptions: DisplayMediaStreamOptions = {
		video: true,
		audio: true
	};

	async function startCapture(displayMediaOptions: DisplayMediaStreamOptions) {
		try {
			return await navigator.mediaDevices.getDisplayMedia(displayMediaOptions);
		} catch (err) {
			console.error(`Error: ${err}`);
			return null;
		}
	}

	async function handleClick() {
		$mediaStream = await startCapture(displayMediaOptions);
	}
</script>

<button on:click={handleClick}>Start Stream</button>
