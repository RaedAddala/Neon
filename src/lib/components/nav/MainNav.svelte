<script lang="ts">
	import { cn } from '$lib/utils.js';
	import type { MainNavItemContent } from '$lib/types';
	import MainNavItem from './MainNavItem.svelte';

	let className: string | undefined | null = undefined;
	export { className as class };

	const mainNavItems: MainNavItemContent[] = [
		{
			href: '/',
			text: 'Home'
		},
		{
			href: '/stream',
			text: 'Stream'
		}
	];
</script>

<nav class={cn('flex items-center space-x-4 lg:space-x-6', className)}>
	{#each mainNavItems as mainNavItem}
		<MainNavItem content={mainNavItem} />
	{/each}
</nav>
