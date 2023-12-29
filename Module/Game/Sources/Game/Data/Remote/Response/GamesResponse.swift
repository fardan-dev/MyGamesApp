//
//  GamesResponse.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

public struct GamesResponse: Decodable {
  var results: [GameResponse]
}

public struct GameResponse: Decodable {
  let id: Int32?
  let name, released: String?
  let backgroundImage: String?
  let rating: Double?
  let ratingTop: Int?
  let description: String?
  let publishers: [GenericModel]?
  let platforms: [PlatformModel]?
  let genres: [GenericModel]?
  let developers: [GenericModel]?
  let tags: [GenericModel]?
  let website: String?

  enum CodingKeys: String, CodingKey {
    case id, name, released
    case backgroundImage = "background_image"
    case rating
    case ratingTop = "rating_top"
    case description, platforms, genres
    case publishers, developers, tags, website
  }
}

public struct PlatformModel: Decodable {
  let platform: GenericModel?
  let releasedAt: String?

  enum CodingKeys: String, CodingKey {
    case platform
    case releasedAt = "released_at"
  }
}

public struct GenericModel: Decodable {
  let id: Int?
  let name: String?
}
