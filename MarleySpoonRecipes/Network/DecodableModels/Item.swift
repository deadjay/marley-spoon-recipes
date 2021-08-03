//
//  Item.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

struct Item: Decodable {
	var id: String
	var contentType: SysContainer
	var fields: Fields

	enum CodingKeyes: String, CodingKey {
		case sys
		case fields
	}

	enum NestedCodingKeyes: String, CodingKey {
		case contentType
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeyes.self)
		fields = try container.decode(Fields.self, forKey: .fields)

		let contentTypeContainer = try container.nestedContainer(keyedBy: NestedCodingKeyes.self, forKey: .sys)
		contentType = try contentTypeContainer.decode(SysContainer.self, forKey: .contentType)

		id = try container.decode(IDContainer.self, forKey: .sys).id
	}
}
