//
//  RecipeService.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

protocol RecipeServiceDelegate: AnyObject {
	func didReceive(recipes: [Fields], tags: [Item], chefs: [Item], assets: [Asset])
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
		case .parse:
			delegate?.didReceiveError(errorText: "Parse error")
		case .server(let errorText):
		delegate?.didReceiveError(errorText: errorText)
		}
	}

	private func parse(_ data: Data) {
		let decoder = JSONDecoder()
		guard let result = try? decoder.decode(PlainResult.self, from: data) else {
			delegate?.didReceiveError(errorText: "Data error")
			return
		}

		let photosURLDictionary = Dictionary(uniqueKeysWithValues: result.assets.map{ ($0.id, $0.url) })
		var allItemsDictionary = [String: PresentedItem]()
		for item in result.items {
			if let presentedItem = PresentedItem(contentTypeID: item.contentType.sys.id,
												 id: item.id,
												 title: item.fields.title ?? "",
												 name: item.fields.name ?? "",
												 description: item.fields.description ?? "",
												 photoID: item.fields.photo?.sys.id ?? "",
												 chefID: item.fields.chef?.sys.id ?? "",
												 tagsIDs: item.fields.tags?.compactMap { $0.sys.id } ?? []) {
				allItemsDictionary[presentedItem.id] = presentedItem
			}
		}

		for value in allItemsDictionary.values {
			if value.contentType == .recipe {
				let presentedRecipe = PresentedRecipe(title: value.title,
													  description: value.description,
													  imageURL: photosURLDictionary[value.photoID] ?? "",
													  chefName: allItemsDictionary[value.chefID]?.name ?? "",
													  tags: value.tagsIDs.map { allItemsDictionary[$0]?.name ?? "" })
			}
		}

//		delegate?.didReceive(recipes: [], tags: tagItems, chefs: chefItems, assets: [])
	}
}
