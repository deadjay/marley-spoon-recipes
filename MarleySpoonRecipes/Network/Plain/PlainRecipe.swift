//
//  PlainRecipe.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 02.08.2021.
//

import Foundation

struct PlainRecipe: Decodable {
	var title: String?
	var photo: SysContainer?
	var description: String?
	var tags: [SysContainer]?
}
