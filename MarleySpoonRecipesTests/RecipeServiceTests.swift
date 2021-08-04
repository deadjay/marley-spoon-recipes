//
//  RecipeServiceTests.swift
//  MarleySpoonRecipesTests
//
//  Created by Artem Alekseev on 04.08.2021.
//

import XCTest
@testable import MarleySpoonRecipes

class RecipeServiceTests: XCTestCase {

	var parsedRecipes = [PresentedRecipe]()

	override func tearDown() {
		parsedRecipes = []
	}

	func testPresentedRecipeParsing() {
		let mockAPIManager = MockAPIManager()
		let service = RecipeService(apiManager: mockAPIManager)
		service.delegate = self
		service.getAllRecipes()


		let parsedTags = parsedRecipes.first(where: { $0.id == "437eO3ORCME46i02SeCW46" })?.tags
		let parsedRecipe2 = parsedRecipes.first(where: { $0.id == "4dT8tcb6ukGSIg2YyuGEOm" })

		XCTAssert(parsedRecipes.count == 4)
		XCTAssert(parsedTags == ["gluten free", "healthy"])
		XCTAssert(parsedRecipe2?.title == "White Cheddar Grilled Cheese with Cherry Preserves & Basil")
		XCTAssert(parsedRecipe2?.imageURL == "https://images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg")
	}
}

extension RecipeServiceTests: RecipeServiceDelegate {
	func didReceive(_ image: UIImage, for recipeID: String) {}
	func didReceiveError(errorText: String) {}

	func didReceive(_ recipes: [PresentedRecipe]) {
		parsedRecipes = recipes
	}
}
