//
//  RecipesListCollectionViewCell.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class RecipesListCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {

	// MARK: - IBOutlets

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var bottomContainerView: UIView!

	// MARK: - View Lifecycle

	override func awakeFromNib() {
		super.awakeFromNib()

		bottomContainerView.backgroundColor = .themeYellow
		titleLabel.font = UIFont.systemFont(ofSize: 12)
		titleLabel.textColor = .themeBlack
		titleLabel.numberOfLines = 0
		titleLabel.lineBreakMode = .byWordWrapping
		titleLabel.textAlignment = .center

		layer.cornerRadius = 8
		clipsToBounds = true

		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .themeBlack
	}

	// MARK: - Functions

	func configure(with recipe: PresentedRecipe) {
		titleLabel.text = recipe.title
		imageView.image = recipe.image
	}

}
