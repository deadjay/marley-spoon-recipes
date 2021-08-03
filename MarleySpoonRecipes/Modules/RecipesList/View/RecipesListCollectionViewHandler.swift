//
//  RecipesListCollectionViewHandler.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 04.08.2021.
//

import Foundation
import UIKit


class RecipesListCollectionViewHandler: NSObject, UICollectionViewDataSource {

	// MARK: - Properties

	var recipesList: PresentedRecipesList?
	weak var coordinator: MainCoordinator?

	// MARK: - Functions

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return recipesList?.recipes.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		var cell: RecipesListCollectionViewCell?

		if let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipesListCollectionViewCell.reuseIdentifier,
																for: indexPath) as? RecipesListCollectionViewCell {
			cell = dequedCell
		} else {
			cell = RecipesListCollectionViewCell.loadFromNib() as? RecipesListCollectionViewCell
		}

		if let recipe = recipesList?.recipe(at: indexPath.row) {
			cell?.configure(with: recipe)
		}

		return cell ?? UICollectionViewCell()
	}
}

extension RecipesListCollectionViewHandler: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let recipe = recipesList?.recipe(at: indexPath.row) {
			coordinator?.openDetailRecipe(for: recipe)
		}
	}
}

extension RecipesListCollectionViewHandler: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}
}
