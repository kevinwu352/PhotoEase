//
//  Photo.swift
//  PhotoEase
//
//  Created by Kevin Wu on 3/5/25.
//

import UIKit


//  {
//    "albumId": 1,
//    "id": 3,
//    "title": "officia porro iure quia iusto qui ipsa ut modi",
//    "url": "https://via.placeholder.com/600/24f355",
//    "thumbnailUrl": "https://via.placeholder.com/150/24f355"
//  }
struct Photo: Codable {
  var albumId: Int?
  var id: Int?
  var title: String?
  var url: String?
  var thumbnailUrl: String?

  var favorite = false

  enum CodingKeys: CodingKey {
    case albumId
    case id
    case title
    case url
    case thumbnailUrl
  }
}
