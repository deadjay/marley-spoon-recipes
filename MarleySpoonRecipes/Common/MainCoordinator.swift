//
//  MainCoordinator.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class MainCoordinator {

	// MARK: - Properties

	var navigationController: UINavigationController

	// MARK: - Construction

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Functions

	func start() {
		if let viewController = RecipesListBuilder().build() as? RecipesListViewController {
			viewController.coordinator = self
			navigationController.pushViewController(viewController, animated: false)
		}
	}

	func openDetailRecipe(for presentedRecipe: PresentedRecipe) {
		let builder = DetailRecipeBuilder(presentedRecipe: presentedRecipe)
		let detailRecipeViewController = builder.build()

		navigationController.present(detailRecipeViewController, animated: true, completion: nil)
	}

	func displayErrorAlert(with message: String, retryAction: @escaping ()->()) {
		AlertFactory.displayErrorAlert(with: message,
									   presentingController: navigationController,
									   retryAction: retryAction)
	}
}
