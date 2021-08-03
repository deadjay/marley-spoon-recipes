//
//  APIManager.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 01.08.2021.
//

import Foundation

enum APIError: Error {
	case wrongRequest
	case parse
	case server(String)
}

typealias APICallback = (Result<Data, APIError>) -> ()

protocol APIManagerProtocol {
	func getRecipes(callback: @escaping APICallback)
	func loadData(for urlString: String, callback: @escaping APICallback)
}

private struct Endpoints {
	static let baseURL = "https://cdn.contentful.com/"
}

private struct Credentials {
	static let space = "kk2bw5ojx476"
	static let environment = "master"
	static let accessToken = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
}

class APIManager: APIManagerProtocol {

	// MARK: - Properties

	static let sharedInstance = APIManager()

	// MARK: - Private Properties

	private let urlSession = URLSession(configuration: .default)

	// MARK: - Constants

	private let okStatusCode = 200
	private let entriesURLString = Endpoints.baseURL + "spaces/" + Credentials.space +
		"/environments/" + Credentials.environment + "/entries"

	// MARK: - Functions

	func getRecipes(callback: @escaping APICallback) {
		guard var urlComponents = URLComponents(string: entriesURLString) else {
			callback(.failure(.wrongRequest))
			return
		}

		urlComponents.query = "access_token=" + Credentials.accessToken

		guard let url = urlComponents.url else {
			callback(.failure(.wrongRequest))
			return
		}

		let dataTask = urlSession.dataTask(with: url,
										   completionHandler: { [weak self] data, response, error in
											self?.completionHandler(data, response, error, callback)
										   })
		dataTask.resume()
	}

	func loadData(for urlString: String, callback: @escaping APICallback) {
		guard let url = URLComponents(string: urlString)?.url else {
			callback(.failure(.wrongRequest))
			return
		}

		let dataTask = urlSession.dataTask(with: url,
										   completionHandler: { [weak self] data, response, error in
											self?.completionHandler(data, response, error, callback)
										   })
		dataTask.resume()
	}

	// MARK: - Private Functions

	private func completionHandler(_ data: Data?,
								   _ response: URLResponse?,
								   _ error: Error?,
								   _ callback: @escaping APICallback) {
		guard error == nil else {
			let error = error?.localizedDescription ?? ""
			handle(.failure(.server(error)), callback)
			return
		}

		guard let aResponse = response as? HTTPURLResponse,
			  aResponse.statusCode == okStatusCode,
			  let aData = data else {
			handle(.failure(.parse), callback)
			return
		}

		handle(.success(aData), callback)
	}

	private func handle(_ result: Result<Data, APIError>, _ callback: @escaping APICallback) {
		DispatchQueue.main.async {
			callback(result)
		}
	}
}
