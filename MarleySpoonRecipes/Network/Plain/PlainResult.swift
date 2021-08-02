//
//  PlainResult.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 02.08.2021.
//

import Foundation

struct PlainResult: Decodable {
	var items: [Item]
	var assets: [Asset]
}

struct Asset: Decodable {
	var url: String

	enum NestedKeyes: String, CodingKey {
		case fields
		case file
	}
}

struct Item: Decodable {
	var id: String
	var fields: PlainRecipe
}

struct Fields: Decodable {
	var title: String
	var photo: SysContainer

}

struct SysContainer: Decodable {
	enum NestedKeyes: String, CodingKey {
		case containerKey = "sys"
	}

	var id: String
}
