<script lang="ts">
	import { user } from '@/stores';
	import UserNav from './UserNav.svelte';
	import { Button } from '../ui/button';
</script>

{#if $user}
	<UserNav user={$user} />
{:else}
	<Button variant="outline" href="/login">Sign in</Button>
	<Button variant="outline" href="/signup">Sign up</Button>
{/if}
