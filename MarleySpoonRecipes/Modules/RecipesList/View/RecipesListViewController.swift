//
//  RecipesListViewController.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 01.08.2021.
//

import UIKit

protocol RecipesListViewProtocol: AnyObject {
	func showLoadingState()
	func showErrorState(with error: String)
	func display(recipes: [PresentedRecipe])
}

class RecipesListViewController: UIViewController {

	private let presenter: RecipesListPresenterProtocol

	init(presenter: RecipesListPresenterProtocol) {
		self.presenter = presenter

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		presenter.loadAllRecipes()
	}
}

extension RecipesListViewController: RecipesListViewProtocol {
	func showLoadingState() {

	}
	func showErrorState(with error: String) {

	}
	func display(recipes: [PresentedRecipe]) {

	}
}
