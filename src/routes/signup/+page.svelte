<script lang="ts">
	import EvervaultCard from '../../lib/components/ui/EvervaultCard/EvervaultCard.svelte';
	import type { PageData } from './$types';
	import SigninForm from './signupForm.svelte';
	export let data: PageData;
</script>

<div class="flex w-screen flex-row justify-between">
	<div
		class="relative mx-auto flex max-w-sm flex-col items-start border border-black/[0.2] p-4 dark:border-white/[0.2]"
	>
		<SigninForm data={data.form} />
	</div>
</div>
