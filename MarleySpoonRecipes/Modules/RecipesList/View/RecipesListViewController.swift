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
	func display(_ recipesList: PresentedRecipesList)
	func display(_ image: UIImage, for recipeID: String)
}

class RecipesListViewController: UIViewController {

	weak var coordinator: MainCoordinator?

	// MARK: - Private Properties

	private let presenter: RecipesListPresenterProtocol
	private var recipesList: PresentedRecipesList?

	private let collectionViewLayout: UICollectionViewFlowLayout
	private let collectionView: UICollectionView
	private let activityIndicator = UIActivityIndicatorView(style: .large)
	private let refreshControl = UIRefreshControl()

	// MARK: - Construction

	init(presenter: RecipesListPresenterProtocol) {
		self.presenter = presenter
		self.collectionViewLayout = UICollectionViewFlowLayout()
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

		super.init(nibName: nil, bundle: nil)

		view.addSubview(collectionView)

		setupLayout()
		setupCollectionView()
		configureActivityIndicator()

		title = "Marley Spoon Recipes"
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - ViewController Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		refreshControl.addTarget(self, action: #selector(refreshDataTriggered(_:)), for: .valueChanged)
		collectionView.refreshControl = refreshControl
		presenter.loadAllRecipes()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let width = collectionView.bounds.width / 2 - 20
		collectionViewLayout.itemSize = CGSize(width: width, height: width)
	}

	// MARK: - Private Functions

	private func setupLayout() {
		collectionView.autoPinEdgesToSuperviewEdges()
	}

	private func setupCollectionView() {
		collectionView.backgroundColor = .themeGray
		collectionView.delaysContentTouches = false
		collectionView.dataSource = self
		collectionView.delegate = self

		collectionView.alwaysBounceVertical = true
		collectionView.showsVerticalScrollIndicator = true

		collectionViewLayout.estimatedItemSize = .zero
		collectionViewLayout.minimumInteritemSpacing = 10

		let cellNib = RecipesListCollectionViewCell.loadNib()
		collectionView.register(cellNib, forCellWithReuseIdentifier: RecipesListCollectionViewCell.reuseIdentifier)
	}

	private func configureActivityIndicator() {
		activityIndicator.hidesWhenStopped = true
		activityIndicator.color = .themeYellow
		activityIndicator.backgroundColor = .themeBlack

		view.addSubview(activityIndicator)
		activityIndicator.autoCenterInSuperview()
	}

	// MARK: - Actions

	@objc private func refreshDataTriggered(_ sender: Any) {
		presenter.loadAllRecipes()
	}
}

extension RecipesListViewController: RecipesListViewProtocol {
	func showLoadingState() {
		activityIndicator.startAnimating()
	}

	func showErrorState(with error: String) {
		activityIndicator.stopAnimating()
		refreshControl.endRefreshing()

		coordinator?.displayErrorAlert(with: error, retryAction: {
			self.presenter.loadAllRecipes()
		})
	}

	func display(_ recipesList: PresentedRecipesList) {
		self.recipesList = recipesList

		collectionView.reloadData()
		activityIndicator.stopAnimating()
		refreshControl.endRefreshing()
	}

	func display(_ image: UIImage, for recipeID: String) {
		recipesList?.set(image: image, for: recipeID)

		collectionView.reloadData()
	}
}

extension RecipesListViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return recipesList?.recipes.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		var cell: RecipesListCollectionViewCell?

		if let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipesListCollectionViewCell.reuseIdentifier,
																for: indexPath) as? RecipesListCollectionViewCell {
			cell = dequedCell
		} else {
			cell = RecipesListCollectionViewCell.loadFromNib() as? RecipesListCollectionViewCell
		}

		if let recipe = recipesList?.recipe(at: indexPath.row) {
			cell?.configure(with: recipe)
		}

		return cell ?? UICollectionViewCell()
	}
}

extension RecipesListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let recipe = recipesList?.recipe(at: indexPath.row) {
			coordinator?.openDetailRecipe(for: recipe)
		}
	}
}

extension RecipesListViewController: UICollectionViewDelegateFlowLayout {

	override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		return CGSize(width: collectionView.bounds.width - 15, height: 200)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}
}
