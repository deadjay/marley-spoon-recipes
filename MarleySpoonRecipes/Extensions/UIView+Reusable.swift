//
//  UIView+Reusable.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

public protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
	public static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}
