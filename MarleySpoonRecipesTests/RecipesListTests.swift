//
//  RecipesListTests.swift
//  MarleySpoonRecipesTests
//
//  Created by Artem Alekseev on 04.08.2021.
//

import XCTest
@testable import MarleySpoonRecipes

class RecipesListTests: XCTestCase {
	func testRecipesListLogic() {
		let recipe1 = PresentedRecipe(id: "999",
									  title: "test1",
									  description: "",
									  imageURL: "",
									  chefName: "",
									  tags: [],
									  image: nil)
		let recipe2 = PresentedRecipe(id: "222",
									  title: "test2",
									  description: "",
									  imageURL: "",
									  chefName: "",
									  tags: [],
									  image: nil)
		let recipe3 = PresentedRecipe(id: "111",
									  title: "test3",
									  description: "",
									  imageURL: "",
									  chefName: "",
									  tags: [],
									  image: UIImage())
		var recipesList = PresentedRecipesList(recipes: [recipe1, recipe2, recipe3])

		// Check for IDs sorting
		XCTAssert(recipesList.recipe(at: 0)?.id == recipe3.id)
		XCTAssert(recipesList.recipe(at: 2)?.id == recipe1.id)

		// Check for Image setting
		let image = UIImage()
		recipesList.set(image: image, for: "222")
		XCTAssert(recipesList.recipe(at: 1)?.image == image)
	}
}

