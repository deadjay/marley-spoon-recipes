//
//  DetailRecipeView.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class DetailRecipe: UIView, NibLoadableView {

	// MARK: - IBOutlets

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var chefNamePrefixLabel: UILabel!
	@IBOutlet weak var chefNameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var tagsStackView: UIStackView!
	@IBOutlet weak var descriptionBackgrundView: UIView!

	// MARK: - UIResponder Overrides

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		shrink(down: true)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		shrink(down: false)
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		shrink(down: false)
	}

	// MARK: - Functions

	func configure(for presentedRecipe: PresentedRecipe) {
		imageView.image = presentedRecipe.image
		titleLabel.text = presentedRecipe.title
		chefNamePrefixLabel.text = "by: "
		chefNameLabel.text = presentedRecipe.chefName
		descriptionLabel.text = presentedRecipe.description

		if presentedRecipe.chefName.isEmpty {
			chefNamePrefixLabel.isHidden = true
			chefNameLabel.isHidden = true
		}

		configure(presentedRecipe.tags)
		customizeUI()
	}

	private func configure(_ recipeTags: [String]) {
		for tag in recipeTags {
			let label = UILabel()
			label.font = UIFont.systemFont(ofSize: 14)
			label.clipsToBounds = true
			label.textColor = .themeBlack
			label.layer.cornerRadius = 4
			label.text = tag
			label.backgroundColor = .themeGreen
			tagsStackView.addArrangedSubview(label)
		}
	}

	private func customizeUI() {
		backgroundColor = .themeYellow
		layer.cornerRadius = 3

		descriptionBackgrundView.backgroundColor = .themeBlack
		descriptionBackgrundView.layer.cornerRadius = 2

		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 9

		titleLabel.numberOfLines = 0
		titleLabel.lineBreakMode = .byWordWrapping

		descriptionLabel.textColor = .themeWhite
		descriptionLabel.numberOfLines = 0
		descriptionLabel.lineBreakMode = .byWordWrapping

		tagsStackView.backgroundColor = .themeYellow
		tagsStackView.spacing = 10
	}
}
