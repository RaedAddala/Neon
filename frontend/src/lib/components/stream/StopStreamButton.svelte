<script lang="ts">
	import { mediaStream } from '$lib/stores';

	function handleClick() {
		const tracks = $mediaStream?.getTracks();

		tracks?.forEach((track) => track.stop());
		$mediaStream = null;
	}
</script>

<button on:click={handleClick}>Stop Stream</button>
