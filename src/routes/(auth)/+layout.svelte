<script>
	import AuthNav from '@/components/auth/AuthNav.svelte';
</script>

<div class="flex h-full max-h-full flex-col justify-start">
	<AuthNav />
	<main class="h-full">
		<slot />
	</main>
</div>
