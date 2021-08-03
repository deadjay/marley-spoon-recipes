//
//  RecipesAPIManager.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 01.08.2021.
//

import Foundation

private struct Endpoints {
	static let baseURL = "https://cdn.contentful.com/"
}

private struct Credentials {
	static let space = "kk2bw5ojx476"
	static let environment = "master"
	static let accessToken = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
}

class RecipesAPIManager {

	enum APIError: Error {
		case parseError
	}

	// MARK: - Properties

	static let sharedInstance = RecipesAPIManager()

	// MARK: - Private Properties

	private let urlSession = URLSession(configuration: .default)

	// MARK: - Constants

	private let okStatusCode = 200
	private let assetsURLString = Endpoints.baseURL + "spaces/" + Credentials.space +
		"/environments/" + Credentials.environment + "/entries"

	// MARK: - Functions

	func getRecipes(completion: @escaping (Result<Data, APIError>) -> ()) {
		guard var urlComponents = URLComponents(string: assetsURLString) else {
			return
		}

		urlComponents.query = "access_token=" + Credentials.accessToken

		guard let url = urlComponents.url else {
			return
		}

		let dataTask = urlSession.dataTask(with: url,
									   completionHandler: { [weak self] data, response, error in
										guard let aResponse = response as? HTTPURLResponse,
											  aResponse.statusCode == self?.okStatusCode,
											  let aData = data else {
											completion(.failure(.parseError))
											return
										}

										completion(.success(aData))
									   })
		dataTask.resume()
	}
}
