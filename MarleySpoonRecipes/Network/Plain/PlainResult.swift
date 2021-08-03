//
//  PlainResult.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 02.08.2021.
//

import Foundation

struct PlainResult: Decodable {
	enum CodingKeyes: String, CodingKey {
		case items
		case includes
	}

	enum NestedCodingKeyes: String, CodingKey {
		case asset = "Asset"
	}

	var items: [Item]
	var assets: [Asset]

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeyes.self)
		items = try container.decode([Item].self, forKey: .items)

		let assetsContainer = try container.nestedContainer(keyedBy: NestedCodingKeyes.self, forKey: .includes)
		assets = try assetsContainer.decode([Asset].self, forKey: .asset)
	}
}

struct Item: Decodable {
	var contentType: SysContainer?
	var fields: PlainRecipe
}

struct Asset: Decodable {
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


	var id: String
	var url: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeyes.self)
		let nestedContainer = try container.nestedContainer(keyedBy: NestedCodingKeyes.self, forKey: .fields)
		let doubleNestedContainer = try nestedContainer.nestedContainer(keyedBy: DoubleNestedCodingKeyes.self, forKey: .file)

		url = try doubleNestedContainer.decode(String.self, forKey: .url)
		id = try container.decode(IDContainer.self, forKey: .sys).id
	}
}

struct SysContainer: Decodable {
	enum CodingKeyes: String, CodingKey {
		case sys
	}

	enum NestedCodingKeyes: String, CodingKey {
		case id
	}

	var id: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeyes.self)

		let sysContainer = try container.nestedContainer(keyedBy: NestedCodingKeyes.self, forKey: .sys)
		id = try sysContainer.decode(String.self, forKey: .id)
	}
}

struct IDContainer: Decodable {
	var id: String
}

//struct SysContainer: Decodable {
//	var sys: IDContainer
//
//	struct IDContainer: Decodable {
//		var id: String
//	}
//}

