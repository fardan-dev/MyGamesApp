//
//  GameDomainModel.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

public struct GameDomainModel: Equatable, Identifiable {
  public var id: String
  public var backgroundImage: String
  public var name: String
  public var released: String
  public var description: String
  public var rating: String
  public var platforms: String
  public var genres: String
  public var publishers: String
  public var developers: String
  public var tags: String
  public var website: String
  public var isFavorited: Bool
  
  public init(
    id: String,
    backgroundImage: String,
    name: String,
    released: String,
    description: String,
    rating: String,
    platforms: String,
    genres: String,
    publishers: String,
    developers: String,
    tags: String,
    website: String,
    isFavorited: Bool
  ) {
    self.id = id
    self.backgroundImage = backgroundImage
    self.name = name
    self.released = released
    self.description = description
    self.rating = rating
    self.platforms = platforms
    self.genres = genres
    self.publishers = publishers
    self.developers = developers
    self.tags = tags
    self.website = website
    self.isFavorited = isFavorited
  }
}
