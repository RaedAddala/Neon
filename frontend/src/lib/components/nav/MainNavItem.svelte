<script lang="ts">
	import type { MainNavItemContent } from '$lib/types';

	export let content: MainNavItemContent;
</script>

<a href={content.href} class="text-sm font-medium transition-colors hover:text-primary">
	{content.text}
</a>
