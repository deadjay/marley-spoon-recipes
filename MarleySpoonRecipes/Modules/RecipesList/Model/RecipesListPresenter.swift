//
//  RecipesListPresenter.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

protocol RecipesListPresenterProtocol {
	func loadAllRecipes()
}

class RecipesListPresenter: RecipesListPresenterProtocol {

	weak var view: RecipesListViewProtocol?

	private let recipeService: RecipeService

	init(recipeService: RecipeService) {
		self.recipeService = recipeService
		recipeService.delegate = self
	}

	func loadAllRecipes() {
		recipeService.getAllRecipes()
	}
}

extension RecipesListPresenter: RecipeServiceDelegate {
	func didReceive(recipes: [Fields], tags: [Item], chefs: [Item], assets: [Asset]) {
		
	}

	func didReceive(recipes: [Fields], assets: [Asset]) {
		var dictionaryAssets = [String: String]()

	}

	func didReceiveError(errorText: String) {
		view?.showErrorState(with: errorText)
	}
}
