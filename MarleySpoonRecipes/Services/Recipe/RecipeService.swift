//
//  RecipeService.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

protocol RecipeServiceDelegate: AnyObject {
	func didReceive(_ recipes: [PresentedRecipe])
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

		let itemServiceModelsDictionary = convertToItemServiceModels(assets: result.assets, items: result.items)
		let presentedRecipes = convertToPresentedRecipes(assets: result.assets, itemServiceModelsDictionary: itemServiceModelsDictionary)

		delegate?.didReceive(presentedRecipes)
	}

	private func convertToItemServiceModels(assets: [Asset], items: [Item]) -> [String: ItemServiceModel] {
		var itemServiceModelsDictionary = [String: ItemServiceModel]()

		for item in items {
			if let itemServiceModel = ItemServiceModel(contentTypeID: item.contentType.sys.id,
												 id: item.id,
												 title: item.fields.title ?? "",
												 name: item.fields.name ?? "",
												 description: item.fields.description ?? "",
												 photoID: item.fields.photo?.sys.id ?? "",
												 chefID: item.fields.chef?.sys.id ?? "",
												 tagsIDs: item.fields.tags?.compactMap { $0.sys.id } ?? []) {
				itemServiceModelsDictionary[itemServiceModel.id] = itemServiceModel
			}
		}

		return itemServiceModelsDictionary
	}

	private func convertToPresentedRecipes(assets: [Asset],
										   itemServiceModelsDictionary: [String: ItemServiceModel]) -> [PresentedRecipe] {
		var presentedRecipes = [PresentedRecipe]()
		let photosURLDictionary = Dictionary(uniqueKeysWithValues: assets.map { ($0.id, $0.url) })

		for value in itemServiceModelsDictionary.values {
			if value.contentType == .recipe {
				let tags = value.tagsIDs.map { itemServiceModelsDictionary[$0]?.name ?? "" }
				let presentedRecipe = PresentedRecipe(title: value.title,
													  description: value.description,
													  imageURL: photosURLDictionary[value.photoID] ?? "",
													  chefName: itemServiceModelsDictionary[value.chefID]?.name ?? "",
													  tags: tags)
				presentedRecipes.append(presentedRecipe)
			}
		}

		return presentedRecipes
	}
}
