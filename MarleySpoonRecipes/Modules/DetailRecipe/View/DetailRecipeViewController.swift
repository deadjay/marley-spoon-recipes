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
	private let detailRecipeView: DetailRecipe
	private let contentView: UIView
	private let dismissButton: UIButton
	private let titleLabel: UILabel

	init(presentedRecipe: PresentedRecipe) {
		self.scrollView = UIScrollView()
		self.presentedRecipe = presentedRecipe
		self.detailRecipeView = DetailRecipe.loadFromNib()
		self.contentView = UIView()
		self.dismissButton = UIButton(type: .close)
		titleLabel = UILabel()

		super.init(nibName: nil, bundle: nil)

		titleLabel.text = "Recipe Details"
		titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
		titleLabel.contentMode = .center

		view.addSubview(titleLabel)

		view.backgroundColor = .themeGray
		dismissButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
		dismissButton.tintColor = .themeBlack
		dismissButton.backgroundColor = .themeGray

		view.addSubview(scrollView)
		view.addSubview(dismissButton)
		scrollView.addSubview(contentView)
		contentView.addSubview(detailRecipeView)

		setupLayout()
		detailRecipeView.configure(for: presentedRecipe)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - ViewController Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .themeWhite
	}

	// MARK: Private Functions

	private func setupLayout() {
		dismissButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
		dismissButton.autoPinEdge(toSuperviewEdge: .right, withInset: 10)

		titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
		titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)

		scrollView.autoPinEdge(.top, to: .bottom, of: dismissButton, withOffset: 10)
		scrollView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
		contentView.autoMatch(.width, to: .width, of: scrollView)
		contentView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
		contentView.autoPinEdge(.bottom, to: .bottom, of: detailRecipeView)

		detailRecipeView.autoMatch(.height, to: .height, of: scrollView)
		detailRecipeView.autoPinEdgesToSuperviewEdges()
		detailRecipeView.backgroundColor = .red
	}

	@objc private func dismissViewController() {
		dismiss(animated: true, completion: nil)
	}
}
