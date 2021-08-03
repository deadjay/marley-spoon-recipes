//
//  UIView+Reusable.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {
	static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
}
