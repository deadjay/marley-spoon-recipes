//
//  Recipe.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 02.08.2021.
//

import Foundation

struct Recipe: Decodable {
	var title: String?
	var photo: SysContainer?
	var chef: SysContainer?
	var description: String?
	var tags: [SysContainer]?
}
