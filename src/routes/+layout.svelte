<script lang="ts">
	import '../app.css';

	import Navbar from '$lib/components/nav/Navbar.svelte';
</script>

<svelte:head>
	<title>Neon</title>
</svelte:head>

<div class="m-4 grid gap-2">
	<Navbar />
	<main>
		<slot />
	</main>
</div>
