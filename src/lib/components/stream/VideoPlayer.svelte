<script lang="ts">
	import { mediaStream } from '$lib/stores';

	let videoElem: HTMLVideoElement | null = null;

	$: if (videoElem !== null) {
		videoElem.srcObject = $mediaStream;
	}
</script>

<video bind:this={videoElem} autoplay controls class="max-w-[50rem]">
	<track kind="captions" />
</video>
