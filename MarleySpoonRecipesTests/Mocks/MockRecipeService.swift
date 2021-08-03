//
//  MockRecipeService.swift
//  MarleySpoonRecipesTests
//
//  Created by Artem Alekseev on 04.08.2021.
//

import XCTest
@testable import MarleySpoonRecipes

class MockRecipeService: RecipeServiceProtocol {
	var delegate: RecipeServiceDelegate?

	private let expectedRecipes: [PresentedRecipe]

	init(expectedRecipes: [PresentedRecipe]) {
		self.expectedRecipes = expectedRecipes
	}
	
	func getAllRecipes() {
		delegate?.didReceive(expectedRecipes)
	}

	func getImage(for urlString: String, recipeID: String) {
		delegate?.didReceive(UIImage(), for: recipeID)
	}
}
