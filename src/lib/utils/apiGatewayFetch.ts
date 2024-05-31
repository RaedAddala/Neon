import { fetchWrapper, type FetchWrapperOptions } from './fetchWrapper';

export default async function apiGatewayFetch<T>(
	url: string,
	options: FetchWrapperOptions = {}
): Promise<T> {
	return fetchWrapper(import.meta.env.VITE_BACKEND_URL + url, options);
}
