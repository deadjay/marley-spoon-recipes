//
//  Asset.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

struct Asset: Decodable {
	var id: String
	var url: String

	enum CodingKeyes: String, CodingKey {
		case sys
		case fields
	}

	enum NestedCodingKeyes: String, CodingKey {
		case file
	}

	enum DoubleNestedCodingKeyes: String, CodingKey {
		case url
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeyes.self)
		let nestedContainer = try container.nestedContainer(keyedBy: NestedCodingKeyes.self, forKey: .fields)
		let doubleNestedContainer = try nestedContainer.nestedContainer(keyedBy: DoubleNestedCodingKeyes.self, forKey: .file)

		url = try doubleNestedContainer.decode(String.self, forKey: .url)
		id = try container.decode(IDContainer.self, forKey: .sys).id
	}
}
