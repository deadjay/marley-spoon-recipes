//
//  DetailRecipeView.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class DetailRecipe: UIView, NibLoadableView {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var chefNamePrefixLabel: UILabel!
	@IBOutlet weak var chefNameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var tagsStackView: UIStackView!

	func configure(for presentedRecipe: PresentedRecipe) {
		backgroundColor = .themeYellow

		imageView.image = presentedRecipe.image
		titleLabel.text = presentedRecipe.title
		chefNamePrefixLabel.text = "by: "
		chefNameLabel.text = presentedRecipe.chefName
		descriptionLabel.text = presentedRecipe.description

		imageView.contentMode = .scaleAspectFit

		titleLabel.numberOfLines = 0
		titleLabel.lineBreakMode = .byWordWrapping

		descriptionLabel.numberOfLines = 0
		descriptionLabel.lineBreakMode = .byWordWrapping

		tagsStackView.backgroundColor = .themeGray

		for tag in presentedRecipe.tags {
			let label = UILabel()
			label.textColor = .themeGreen
			label.text = tag
			tagsStackView.addArrangedSubview(label)
		}
	}
//
//	override func awakeFromNib() {
//		super.awakeFromNib()
//
//	}
//
//	required init?(coder: NSCoder) {
//		super.init(coder: coder)
//	}

	private func setupLayout() {

	}
}
