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
	func display(_ recipes: [String: PresentedRecipe])
	func display(_ image: UIImage, for recipeID: String)
}

class RecipesListViewController: UIViewController {

	// MARK: - Private Properties

	private let presenter: RecipesListPresenterProtocol
	private var recipes = [String: PresentedRecipe]()

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
	func display(_ recipes: [String: PresentedRecipe]) {
		self.recipes = recipes
		collectionView.reloadData()
	}

	func display(_ image: UIImage, for recipeID: String) {
		recipes[recipeID]?.image = image
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
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath)

		cell.backgroundColor = .themeYellow
		return cell
	}
}

extension RecipesListViewController: UICollectionViewDelegate {

}
