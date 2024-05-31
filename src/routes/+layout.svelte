<script lang="ts">
	import '../app.css';

	import { ModeWatcher } from 'mode-watcher';
</script>

<svelte:head>
	<title>Neon</title>
</svelte:head>

<ModeWatcher />
<slot />
