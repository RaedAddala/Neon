<script lang="ts">
	import type { NavbarItemContent } from '$lib/types';

	export let content: NavbarItemContent;
</script>

<a href={content.href}>{content.text}</a>
