<script lang="ts">
	import Logo from './Logo.svelte';
	import MainNav from './MainNav.svelte';
	import Search from './Search.svelte';
	import ProfileNav from './ProfileNav.svelte';
</script>

<div class="border-b">
	<div class="flex h-16 items-center px-4">
		<Logo />
		<MainNav class="mx-6" />
		<div class="ml-auto flex items-center space-x-4">
			<Search />
			<ProfileNav />
		</div>
	</div>
</div>
