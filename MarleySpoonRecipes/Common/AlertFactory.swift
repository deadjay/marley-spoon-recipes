//
//  AlertFactory.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 04.08.2021.
//

import Foundation
import UIKit

class AlertFactory {
	private static let errorTitle = "Error occured"

	static func displayErrorAlert(with message: String,
								  presentingController: UIViewController,
								  retryAction: @escaping () -> ()) {
		let alertController = UIAlertController(title: errorTitle,
												message: message,
												preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel) { action in
			alertController.dismiss(animated: true, completion: nil)
		}
		let retryAction = UIAlertAction(title: "Retry", style: .default) { action in
			retryAction()
			alertController.dismiss(animated: true, completion: nil)
		}

		alertController.addAction(okAction)
		alertController.addAction(retryAction)
		presentingController.present(alertController, animated: true, completion: nil)
	}
}
