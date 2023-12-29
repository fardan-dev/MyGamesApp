//
//  GamesTransformer.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Core

public struct GamesTransformer: Mapper {
  public typealias Response = [GameResponse]
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [GameDomainModel]
  
  public init() {}
  
  public func transformResponseToEntity(response: [GameResponse]) -> [GameModuleEntity] {
    return response.map { result in
      var platformList: String? {
        var listString = [String]()
        for item in result.platforms ?? [] {
          listString.append(item.platform?.name ?? "")
        }
        return listString.joined(separator: ", ")
      }
      
      let newGame = GameModuleEntity()
      newGame.id = "\(result.id ?? 0)"
      newGame.name = result.name ?? ""
      newGame.released = result.released ?? ""
      newGame.backgroundImage = result.backgroundImage ?? ""
      newGame.rating = "\(result.rating ?? 0)"
      return newGame
    }
  }
  
  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameDomainModel] {
    return entity.map { result in
      return GameDomainModel(
        id: result.id,
        backgroundImage: result.backgroundImage,
        name: result.name,
        released: result.released,
        description: result.description,
        rating: result.rating,
        platforms: result.platforms ?? "",
        genres: result.genres ?? "",
        publishers: result.publishers ?? "",
        developers: result.developers ?? "",
        tags: result.tags ?? "",
        website: result.website ?? "",
        isFavorited: result.isFavorited
      )
    }
  }
}
