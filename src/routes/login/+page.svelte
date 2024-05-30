<script lang="ts">
	import type { PageData } from './$types';
	import LoginForm from './loginForm.svelte';
	export let data: PageData;
</script>

<div
	style="background-image: url('/signup-bg.jpg');
			background-repeat: no-repeat;
			background-position: center;
			background-size: cover;"
	class="h-full w-full"
>
	<div class="flex h-full items-center w-full">
		<div
			style="height: 60%; width:50%"
			class="relative mx-auto flex  flex-row justify-around items-center rounded-lg border border-black/[0.2] bg-black bg-opacity-50 p-4 dark:border-white/[0.2]"
		>
			<div class="relative z-10 mb-5 text-center text-lg font-bold md:text-2xl">Welcome Back !</div>
			<LoginForm data={data.form} />
		</div>
	</div>
</div>
