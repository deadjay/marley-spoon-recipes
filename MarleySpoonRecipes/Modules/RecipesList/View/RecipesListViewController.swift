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

	weak var coordinator: MainCoordinator? {
		didSet {
			collectionViewHandler.coordinator = coordinator
		}
	}

	// MARK: - Private Properties

	private let presenter: RecipesListPresenterProtocol
	private var recipesList: PresentedRecipesList?

	private let collectionViewLayout: UICollectionViewFlowLayout
	private let collectionView: UICollectionView
	private let activityIndicator: UIActivityIndicatorView
	private let refreshControl: UIRefreshControl
	private let collectionViewHandler: RecipesListCollectionViewHandler

	// MARK: - Construction

	init(presenter: RecipesListPresenterProtocol) {
		self.presenter = presenter
		self.collectionViewLayout = UICollectionViewFlowLayout()
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		self.activityIndicator = UIActivityIndicatorView(style: .large)
		self.refreshControl = UIRefreshControl()
		self.collectionViewHandler = RecipesListCollectionViewHandler()

		super.init(nibName: nil, bundle: nil)

		title = "Marley Spoon Recipes"
		view.addSubview(collectionView)
		setupCollectionView()
		configureActivityIndicator()

		setupLayout()
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
		collectionView.dataSource = collectionViewHandler
		collectionView.delegate = collectionViewHandler

		collectionView.alwaysBounceVertical = true
		collectionView.showsVerticalScrollIndicator = true

		collectionViewLayout.estimatedItemSize = .zero
		collectionViewLayout.minimumInteritemSpacing = 10

		let cellNib = RecipesListCollectionViewCell.loadNib()
		collectionView.register(cellNib, forCellWithReuseIdentifier: RecipesListCollectionViewCell.reuseIdentifier)
	}

	private func configureActivityIndicator() {
		activityIndicator.hidesWhenStopped = true
		activityIndicator.color = .themeBlack

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
		collectionViewHandler.recipesList = recipesList

		collectionView.reloadData()
		activityIndicator.stopAnimating()
		refreshControl.endRefreshing()
	}

	func display(_ image: UIImage, for recipeID: String) {
		collectionViewHandler.recipesList?.set(image: image, for: recipeID)
		collectionView.reloadData()
	}
}
