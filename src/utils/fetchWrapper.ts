// src/lib/fetchWrapper.ts

export interface FetchWrapperOptions extends RequestInit {
	headers?: HeadersInit;
}

/**
 * Wrapper function around SvelteKit's fetch
 * @param {string} url - The URL to fetch.
 * @param {FetchWrapperOptions} options - Fetch options such as method, headers, body, etc.
 * @returns {Promise<Response>} - The fetch response.
 */
export async function fetchWrapper(
	url: string,
	options: FetchWrapperOptions = {}
): Promise<Response> {
	const defaultHeaders: HeadersInit = {
		'Content-Type': 'application/json'
		// Add any other default headers here
	};

	const config: FetchWrapperOptions = {
		...options,
		headers: {
			...defaultHeaders,
			...options.headers
		}
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
		console.error(`Fetch error: ${error.message}`);
		throw error;
	}
}
