<script lang="ts">
	import type { PageData } from './$types';
	import LoginForm from './loginForm.svelte';
	export let data: PageData;
</script>

<div class="flex w-screen flex-row justify-between">
	<div>AAAAAAAAAAA</div>
	<div
		class="relative mx-auto flex h-fit max-w-sm flex-col items-start border border-black/[0.2] p-4 dark:border-white/[0.2]"
	>
		<LoginForm data={data.form} />
	</div>
</div>
