<script lang="ts">
	import '../app.css';

	import { ModeWatcher } from 'mode-watcher';

	import Navbar from '$lib/components/nav/Navbar.svelte';
</script>

<svelte:head>
	<title>Neon</title>
</svelte:head>

<ModeWatcher />

<div class="grid gap-2">
	<Navbar />
	<main>
		<slot />
	</main>
</div>
