<script lang="ts">
	import { mediaStream } from '$lib/stores';

	function handleClick(_event: Event) {
		const tracks = $mediaStream?.getTracks();

		tracks?.forEach((track) => track.stop());
		$mediaStream = null;
	}
</script>

<button on:click={handleClick}>Stop Stream</button>
