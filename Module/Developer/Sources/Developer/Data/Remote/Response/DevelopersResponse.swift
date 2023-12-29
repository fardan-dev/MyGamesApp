//
//  DevelopersResponse.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

public struct DevelopersResponse: Decodable {
  var results: [DeveloperResponse]
}

public struct DeveloperResponse: Decodable {
  let id: Int
  let name: String?
  let gamesCount: Int?
  let imageBackground: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case gamesCount = "games_count"
    case imageBackground = "image_background"
  }
}
