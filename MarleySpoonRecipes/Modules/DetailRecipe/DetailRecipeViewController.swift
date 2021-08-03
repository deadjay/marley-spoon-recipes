//
//  DetailRecipeViewController.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

class DetailRecipeViewController: UIViewController {
	private let scrollView: UIScrollView
	private let presentedRecipe: PresentedRecipe

	init(presentedRecipe: PresentedRecipe) {
		self.scrollView = UIScrollView()
		self.presentedRecipe = presentedRecipe

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - ViewController Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		
	}

	// MARK: Functions


}
