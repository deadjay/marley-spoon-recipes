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
	private let detailRecipeView: DetailRecipeView

	init(presentedRecipe: PresentedRecipe) {
		self.scrollView = UIScrollView()
		self.presentedRecipe = presentedRecipe
		self.detailRecipeView = DetailRecipeView.loadFromNib()

		super.init(nibName: nil, bundle: nil)

		view.addSubview(scrollView)
		scrollView.addSubview(detailRecipeView)
		detailRecipeView.configure(for: presentedRecipe)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - ViewController Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Recipe Details"
		view.backgroundColor = .themeGray
	}

	// MARK: Functions

	private func setupLayout() {

	}


}
