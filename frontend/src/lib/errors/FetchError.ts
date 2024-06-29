export class FetchError extends Error {
	constructor(
		private readonly _response: Response,
		message?: string,
		options?: ErrorOptions
	) {
		super(message, options);
	}

	public get response(): Response {
		return this._response;
	}
}
