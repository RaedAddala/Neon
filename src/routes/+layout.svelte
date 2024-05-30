<script lang="ts">
	import '../app.css';

	import { ModeWatcher } from 'mode-watcher';

	import Navbar from '$lib/components/nav/Navbar.svelte';
</script>

<svelte:head>
	<title>Neon</title>
</svelte:head>

<ModeWatcher />
<div class="flex h-full max-h-full flex-col justify-start">
	<Navbar />
	<main class="h-full">
		<slot />
	</main>
</div>
