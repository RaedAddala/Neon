<script lang="ts">
	import type { NavbarItemContent } from '$lib/types';

	export let content: NavbarItemContent;
</script>

<a href={content.href} class="text-sm font-medium transition-colors hover:text-primary">
	{content.text}
</a>
