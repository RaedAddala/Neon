<script lang="ts">
	import type { NavbarItemContent } from '$lib/types/nav';
	import NavbarItem from './NavbarItem.svelte';

	const NavbarItems: NavbarItemContent[] = [
		{
			href: '/',
			text: 'Home'
		}
	];
</script>

<div class="flex gap-2">
	{#each NavbarItems as navbarItem}
		<NavbarItem content={navbarItem} />
	{/each}
</div>
