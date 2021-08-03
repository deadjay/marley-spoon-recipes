//
//  UIView+Shrinkable.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

extension UIView {
	func shrink(down: Bool) {
		UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction]) {
			self.transform = down ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
		}
	}
}
