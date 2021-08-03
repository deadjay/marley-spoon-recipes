//
//  RecipesListPresenter.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

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
	func didReceive(_ recipes: [PresentedRecipe]) {
		print(recipes)

		for recipe in recipes {
			recipeService.getImage(for: recipe.imageURL, recipeID: recipe.id)
		}
	}

	func didReceive(_ image: UIImage, for recipeID: String) {
	}

	func didReceiveError(errorText: String) {
		view?.showErrorState(with: errorText)
	}
}
