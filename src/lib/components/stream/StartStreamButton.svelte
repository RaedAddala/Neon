<script lang="ts">
	import { mediaStream } from '$lib/stores';

	const displayMediaOptions: DisplayMediaStreamOptions = {
		video: true,
		audio: true
	};

	async function startCapture(displayMediaOptions: DisplayMediaStreamOptions) {
		let captureStream = null;

		try {
			captureStream = await navigator.mediaDevices.getDisplayMedia(displayMediaOptions);
		} catch (err) {
			console.error(`Error: ${err}`);
		}
		return captureStream;
	}

	async function handleClick(_event: Event) {
		$mediaStream = await startCapture(displayMediaOptions);
	}
</script>

<button on:click={handleClick}>Start Stream</button>
