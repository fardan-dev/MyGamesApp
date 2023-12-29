//
//  GameTransformer.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Core

public struct GameTransformer: Mapper {
  public typealias Response = GameResponse
  public typealias Entity = GameModuleEntity
  public typealias Domain = GameDomainModel
  
  public init() {}
  
  public func transformResponseToEntity(response: GameResponse) -> GameModuleEntity {
    var platformString: String? {
      var listString = [String]()
      for item in response.platforms ?? [] {
        listString.append(item.platform?.name ?? "")
      }
      return listString.joined(separator: ", ")
    }
    
    let newGame = GameModuleEntity()
    newGame.id = "\(response.id ?? 0)"
    newGame.name = response.name ?? ""
    newGame.released = response.released ?? ""
    newGame.gameDescription = response.description ?? ""
    newGame.backgroundImage = response.backgroundImage ?? ""
    newGame.rating = "\(response.rating ?? 0)"
    newGame.platforms = platformString
    newGame.genres = _mapGenericModelToString(items: response.genres)
    newGame.publishers = _mapGenericModelToString(items: response.publishers)
    newGame.developers = _mapGenericModelToString(items: response.developers)
    newGame.tags = _mapGenericModelToString(items: response.tags)
    newGame.website = response.website ?? ""
    return newGame
  }
  
  public func transformEntityToDomain(entity: GameModuleEntity) -> GameDomainModel {
    return GameDomainModel(
      id: entity.id,
      backgroundImage: entity.backgroundImage,
      name: entity.name,
      released: entity.released,
      description: entity.gameDescription ?? "",
      rating: entity.rating,
      platforms: entity.platforms ?? "",
      genres: entity.genres ?? "",
      publishers: entity.publishers ?? "",
      developers: entity.developers ?? "",
      tags: entity.tags ?? "",
      website: entity.website ?? "",
      isFavorited: entity.isFavorited
    )
  }
  
  public func updateFavoriteEntity(entity: GameModuleEntity) -> GameModuleEntity {
    let newGame = entity
    newGame.isFavorited = !entity.isFavorited
    return newGame
  }
  
  private func _mapGenericModelToString(items: [GenericModel]?) -> String {
    var listString = [String]()
    for item in items ?? [] {
      listString.append(item.name ?? "")
    }
    return listString.joined(separator: ", ")
  }
}
