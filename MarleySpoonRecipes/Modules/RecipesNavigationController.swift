//
//  RecipesNavigationController.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class RecipesNavigationController: UINavigationController {

	// MARK: - Properties

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}

	// MARK: - Construction

	init() {
		super.init(nibName: nil, bundle: nil)

		navigationBar.topItem?.title = "Marley Spoon Recipes"
		navigationBar.isTranslucent = false
		navigationBar.backgroundColor = .themeWhite
		navigationBar.tintColor = .themeBlack
		navigationBar.shadowImage = UIImage()
		navigationBar.barTintColor = .themeWhite
		navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeBlack,
											 NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
	}

	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
