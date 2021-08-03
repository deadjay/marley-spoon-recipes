//
//  RecipeService.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

protocol RecipeServiceDelegate: AnyObject {
	func didReceive(recipes: [Recipe], assets: [Asset])
	func didReceiveError(errorText: String)
}

class RecipeService {

	weak var delegate: RecipeServiceDelegate?

	private let apiManager: APIManagerProtocol

	init(apiManager: APIManagerProtocol) {
		self.apiManager = apiManager
	}

	func getAllRecipes() {
		apiManager.getRecipes { [weak self] result in
			switch result {
			case .success(let data):
				self?.parse(data)
			case .failure(let apiError):
				self?.obtain(apiError)
			}
		}
	}

	private func obtain(_ apiError: APIError) {
		switch apiError {
		case .parseError:
			delegate?.didReceiveError(errorText: "Network error")
		}
	}

	private func parse(_ data: Data) {
		let decoder = JSONDecoder()
		guard let result = try? decoder.decode(PlainResult.self, from: data) else {
			delegate?.didReceiveError(errorText: "Data error")
			return
		}

		let filteredItems = result.items.filter { $0.contentType.sys.id == "recipe" }
		let recipes = filteredItems.map { $0.fields }

		let recipeAssetIDsSet = Set(recipes.map { $0.photo?.sys.id ?? "" })
		let linkedRecipeAssets = result.assets.filter { recipeAssetIDsSet.contains($0.id) }

		delegate?.didReceive(recipes: recipes, assets: linkedRecipeAssets)
	}
}
