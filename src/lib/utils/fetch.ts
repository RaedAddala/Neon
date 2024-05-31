export interface FetchWrapperOptions extends RequestInit {
	headers?: HeadersInit;
}

/**
 * Wrapper function around SvelteKit's fetch
 * @param {function} fetch - SvelteKit fetch function
 * @param {string} url - The URL to fetch.
 * @param {FetchWrapperOptions} options - Fetch options such as method, headers, body, etc.
 * @returns {Promise<T>} - The fetch response.
 */
export async function fetchWrapper<T>(
	fetch: (input: RequestInfo | URL, init?: RequestInit | undefined) => Promise<Response>,
	url: string,
	{ body, headers, ...options }: FetchWrapperOptions = {}
): Promise<T> {
	const defaultHeaders: HeadersInit = {};

	if (!(body instanceof FormData)) {
		defaultHeaders['Content-Type'] = 'application/json';
	}

	const config: FetchWrapperOptions = {
		body,
		headers: {
			...defaultHeaders,
			...headers
		},
		...options
	};

	try {
		const response = await fetch(url, config);

		// Check if the response status indicates an error
		if (!response.ok) {
			const errorText = await response.text();
			throw new Error(`Error ${response.status}: ${response.statusText} - ${errorText}`);
		}

		// Optionally, you could add logging here
		// console.log(`Request to ${url} with options`, config);

		return response.json();
	} catch (error) {
		// Handle or log the error as needed
		console.error(`Fetch error: ${(error as Error).message}`);
		throw error;
	}
}

export function getFetchWrapper(
	fetch: (input: RequestInfo | URL, init?: RequestInit | undefined) => Promise<Response>
) {
	const baseURL = import.meta.env.VITE_BACKEND_URL;

	return <T>(url: string, options: FetchWrapperOptions = {}): Promise<T> =>
		fetchWrapper(fetch, baseURL + url, options);
}
