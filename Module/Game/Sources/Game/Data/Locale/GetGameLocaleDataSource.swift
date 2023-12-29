//
//  GetGameLocaleDataSource.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetGameLocaleDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm?
  
  public init(realm: Realm?) {
    _realm = realm
  }
  
  public func list(request: Request?) -> AnyPublisher<[GameModuleEntity], Error> {
    fatalError()
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
    return Future<GameModuleEntity, Error> { completion in
      if let realm = _realm {
        if let game = realm.object(ofType: GameModuleEntity.self, forPrimaryKey: id) {
          completion(.success(game))
        } else {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func update(id: String, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = _realm,
         let game = realm.objects(GameModuleEntity.self).filter({ $0.id == entity.id }).first {
        do {
          try realm.write({
            game.gameDescription = entity.gameDescription
            game.platforms = entity.platforms
            game.genres = entity.genres
            game.publishers = entity.publishers
            game.developers = entity.developers
            game.tags = entity.tags
            game.website = entity.website
            game.detailUpdated = true
            game.isFavorited = entity.isFavorited
            completion(.success(true))
          })
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
}
