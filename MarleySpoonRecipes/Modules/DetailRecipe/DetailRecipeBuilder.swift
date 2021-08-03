//
//  DetailRecipeBuilder.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class DetailRecipeBuilder {
	private let presentedRecipe: PresentedRecipe

	init(presentedRecipe: PresentedRecipe) {
		self.presentedRecipe = presentedRecipe
	}

	func build() -> UIViewController {
		return DetailRecipeViewController(presentedRecipe: presentedRecipe)
	}
}
