//
//  MockAPIManager.swift
//  MarleySpoonRecipesTests
//
//  Created by Artem Alekseev on 04.08.2021.
//

import Foundation
import XCTest
@testable import MarleySpoonRecipes

class MockAPIManager: APIManagerProtocol {

	func getRecipes(callback: @escaping APICallback) {
		let testBundle = Bundle(for: type(of: self))

		guard let fileURL = testBundle.url(forResource: "mockResponse", withExtension: "json") else {
			XCTFail("Cannot find json file in test bundle.")
			return
		}
		guard let data = try? Data(contentsOf: fileURL) else {
			XCTFail("Cannot retrieve data from fileURL")
			return
		}

		callback(.success(data))
	}

	func loadData(for urlString: String, callback: @escaping APICallback) { }
}
