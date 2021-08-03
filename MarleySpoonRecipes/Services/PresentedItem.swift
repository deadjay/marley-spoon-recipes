//
//  PresentedItem.swift
//  MarleySpoonRecipes
//
//  Created by Artem Alekseev on 03.08.2021.
//

import Foundation

enum ContentType: String {
	case recipe
	case chef
	case tag
}

struct PresentedItem {
	let contentType: ContentType
	let id: String

	var title: String
	var name: String
	var description: String
	var photoID: String
	var chefID: String
	var tagsIDs: [String]

	init?(contentTypeID: String,
		  id: String,
		  title: String,
		  name: String,
		  description: String,
		  photoID: String,
		  chefID: String,
		  tagsIDs: [String]) {
		guard let aContentType = ContentType(rawValue: contentTypeID) else {
			return nil
		}

		self.contentType = aContentType
		self.id = id
		self.title = title
		self.name = name
		self.description = description
		self.photoID = photoID
		self.chefID = chefID
		self.tagsIDs = tagsIDs
	}
}
