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

	enum CodingKeyes: String, CodingKey {
		case items
		case includes
	}

	enum NestedCodingKeyes: String, CodingKey {
		case asset = "Asset"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeyes.self)
		items = try container.decode([Item].self, forKey: .items)

		let assetsContainer = try container.nestedContainer(keyedBy: NestedCodingKeyes.self, forKey: .includes)
		assets = try assetsContainer.decode([Asset].self, forKey: .asset)
	}
}
