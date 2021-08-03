//
//  UIView+NibLoadable.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

public protocol NibLoadableView: class {
	static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
	static var nibName: String {
		return String(describing: self)
	}

	static func loadNib() -> UINib {
		return UINib(nibName: self.nibName, bundle: nil)
	}

	static func loadFromNib<T>() -> T where T: UIView {
		let cell = UINib(nibName: self.nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T

		return cell ?? T()
	}
}
