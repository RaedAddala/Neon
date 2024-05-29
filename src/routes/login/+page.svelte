<script lang="ts">
	import type { PageData } from './$types';
	import LoginForm from './loginForm.svelte';
	export let data: PageData;
</script>

<LoginForm data={data.form} />
