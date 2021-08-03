//
//  APIManager.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 01.08.2021.
//

import Foundation

enum APIError: Error {
	case parse
	case server(String)
}

typealias APIResult = (Result<Data, APIError>) -> ()

protocol APIManagerProtocol {
	func getRecipes(completion: @escaping APIResult)
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

	func getRecipes(completion: @escaping APIResult) {
		guard var urlComponents = URLComponents(string: entriesURLString) else {
			return
		}

		urlComponents.query = "access_token=" + Credentials.accessToken

		guard let url = urlComponents.url else {
			return
		}

		let dataTask = urlSession.dataTask(with: url,
									   completionHandler: { [weak self] data, response, error in
										guard error == nil else {
											self?.handle(.failure(.server(error?.localizedDescription ?? "")), completion)
											return
										}

										guard let aResponse = response as? HTTPURLResponse,
											  aResponse.statusCode == self?.okStatusCode,
											  let aData = data else {
											self?.handle(.failure(.parse), completion)
											return
										}

										self?.handle(.success(aData), completion)
									   })
		dataTask.resume()
	}

	private func handle(_ result: Result<Data, APIError>, _ completion: @escaping APIResult) {
		DispatchQueue.main.async {
			completion(result)
		}
	}
}
