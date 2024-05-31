<script lang="ts">
	import type { PartialUser } from '@/types';
	import { Root, Image, Fallback } from '../ui/avatar';

	export let user: PartialUser;
</script>

<Root class="my-auto h-8 w-8">
	<Image
		src={import.meta.env.VITE_BACKEND_URL + '/auth/' + user.profilePicture}
		alt={user.username}
	/>
	<Fallback>{user.username.charAt(0).toUpperCase()}</Fallback>
</Root>
