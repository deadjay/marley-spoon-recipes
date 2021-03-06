//
//  RecipesListBuilder.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class RecipesListBuilder {
	func build() -> UIViewController {
		let recipesService = RecipeService(apiManager: APIManager.sharedInstance)
		let presenter = RecipesListPresenter(recipeService: recipesService)
		let viewController = RecipesListViewController(presenter: presenter)
		presenter.view = viewController

		return viewController
	}
}
