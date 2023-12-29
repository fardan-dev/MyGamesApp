//
//  DevelopersTransformer.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Core

public struct DevelopersTransformer: Mapper {
  public typealias Response = [DeveloperResponse]
  public typealias Entity = [DeveloperModuleEntity]
  public typealias Domain = [DeveloperDomainModel]
  
  public init() {}
  
  public func transformResponseToEntity(response: [DeveloperResponse]) -> [DeveloperModuleEntity] {
    return response.map { result in
      let newDeveloper = DeveloperModuleEntity()
      newDeveloper.id = "\(result.id)"
      newDeveloper.name = result.name ?? ""
      newDeveloper.gamesCount = "\(result.gamesCount ?? 0)"
      newDeveloper.imageBackground = result.imageBackground ?? ""
      return newDeveloper
    }
  }
  
  public func transformEntityToDomain(entity: [DeveloperModuleEntity]) -> [DeveloperDomainModel] {
    return entity.map { result in
      return DeveloperDomainModel(
        id: result.id,
        imageBackground: result.imageBackground,
        title: result.name,
        subtitle: "Total Games: \(result.gamesCount)")
    }
  }
}
