//
//  RecipesListPresenter.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

class RecipesListPresenter {

	let service = RecipeService(apiManager: APIManager.sharedInstance)

	func loadAllRecipes() {

		service.getAllRecipes()
	}
}
