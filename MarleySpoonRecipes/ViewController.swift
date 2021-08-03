//
//  ViewController.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 01.08.2021.
//

import UIKit

class ViewController: UIViewController {

	let presenter = RecipesListPresenter()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		presenter.loadAllRecipes()
	}


}

