//
//  PresentedRecipesList.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

struct PresentedRecipesList {
	var recipes: [PresentedRecipe] {
		return Array(recipesDictionary.values)
	}

	private var recipesDictionary: [String: PresentedRecipe]
	private let ids: [String]

	init(recipes: [PresentedRecipe]) {
		self.recipesDictionary = Dictionary(uniqueKeysWithValues: recipes.map { ($0.id, $0) })
		self.ids = recipesDictionary.keys.sorted()
	}

	func recipe(at index: Int) -> PresentedRecipe? {
		return recipesDictionary[ids[safe: index] ?? ""]
	}

	mutating func set(image: UIImage, for recipeID: String) {
		recipesDictionary[recipeID]?.image = image
	}
}
