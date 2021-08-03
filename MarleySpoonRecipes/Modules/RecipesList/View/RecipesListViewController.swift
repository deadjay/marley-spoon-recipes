//
//  RecipesListViewController.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 01.08.2021.
//

import UIKit
import PureLayout

protocol RecipesListViewProtocol: AnyObject {
	func showLoadingState()
	func showErrorState(with error: String)
	func display(recipes: [PresentedRecipe])
}

class RecipesListViewController: UIViewController {

	// MARK: - Private Properties

	private let presenter: RecipesListPresenterProtocol
	private var recipes = [PresentedRecipe]()

	private let collectionViewLayout: UICollectionViewFlowLayout
	private let collectionView: UICollectionView

	// MARK: - Construction

	init(presenter: RecipesListPresenterProtocol) {
		self.presenter = presenter
		self.collectionViewLayout = UICollectionViewFlowLayout()
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

		super.init(nibName: nil, bundle: nil)

		view.addSubview(collectionView)

		setupLayout()
		setupCollectionView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - ViewController Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		presenter.loadAllRecipes()
	}

	// MARK: - Private Functions

	private func setupLayout() {
		collectionView.autoPinEdgesToSuperviewEdges()
	}

	private func setupCollectionView() {
		collectionView.backgroundColor = .themeGray
		collectionView.dataSource = self
		collectionView.delegate = self
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

extension RecipesListViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return recipes.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
}

extension RecipesListViewController: UICollectionViewDelegate {

}
