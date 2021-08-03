//
//  DetailRecipeView.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class DetailRecipeView: UIView, NibLoadableView {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var chefNamePrefixLabel: UILabel!
	@IBOutlet weak var chefNameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var tagsStackView: UIStackView!

	func configure(for presentedRecipe: PresentedRecipe) {
		imageView.image = presentedRecipe.image
		titleLabel.text = presentedRecipe.title
		chefNamePrefixLabel.text = "by: "
		descriptionLabel.text = presentedRecipe.description

		for tag in presentedRecipe.tags {
			let label = UILabel()
			label.textColor = .themeBlack
			label.text = tag
			tagsStackView.addArrangedSubview(label)
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupLayout() {

	}
}
