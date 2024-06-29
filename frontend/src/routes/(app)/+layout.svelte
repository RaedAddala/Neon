<script lang="ts">
	import Navbar from '$lib/components/nav/Navbar.svelte';
</script>

<svelte:head>
	<title>Neon</title>
</svelte:head>

<div class="grid gap-2">
	<Navbar />
	<main>
		<slot />
	</main>
</div>
