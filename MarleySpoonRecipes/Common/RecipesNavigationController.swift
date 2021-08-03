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

	// MARK: - ViewController Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationBar.isTranslucent = false
		navigationBar.backgroundColor = .themeWhite
		navigationBar.tintColor = .themeBlack
		navigationBar.shadowImage = UIImage()
		navigationBar.barTintColor = .themeWhite
		navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeBlack,
											 NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
	}
}
