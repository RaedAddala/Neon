import { fetchWrapper, type FetchWrapperOptions } from './fetchWrapper';

export default async function apiGatewayFetch(
	url: string,
	options: FetchWrapperOptions = {}
): Promise<Response> {
	return fetchWrapper(import.meta.env.VITE_BACKEND_URL + url, options);
}
