//
//  GetGamesLocaleDataSource.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetGamesLocaleDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm?
  
  public init(realm: Realm?) {
    _realm = realm
  }
  
  public func list(request: Request?) -> AnyPublisher<[GameModuleEntity], Error> {
    switch request as? RequestModel {
    case .list:
      return Future<[GameModuleEntity], Error> { completion in
        if let realm = _realm {
          let games: Results<GameModuleEntity> = {
            realm.objects(GameModuleEntity.self).sorted(byKeyPath: "name", ascending: true)
          }()
          completion(.success(games.toArray(ofType: GameModuleEntity.self)))
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      }.eraseToAnyPublisher()
    case .listFavourited:
      return Future<[GameModuleEntity], Error> { completion in
        if let realm = _realm {
          let games: [GameModuleEntity] = {
            realm.objects(GameModuleEntity.self).filter({ $0.isFavorited == true })
          }()
          completion(.success(games))
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      }.eraseToAnyPublisher()
    default:
      fatalError()
    }
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = _realm {
        do {
          try realm.write({
            for game in entities {
              realm.add(game, update: .all)
            }
            completion(.success(true))
          })
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
    fatalError()
  }
  
  public func update(id: String, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
