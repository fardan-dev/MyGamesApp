//
//  GetDevelopersLocaleDataSource.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetDevelopersLocaleDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = DeveloperModuleEntity
  
  private let _realm: Realm?
  
  public init(realm: Realm?) {
    _realm = realm
  }
  
  public func list(request: Request?) -> AnyPublisher<[DeveloperModuleEntity], Error> {
    return Future<[DeveloperModuleEntity], Error> { completion in
      if let realm = _realm {
        let developer: Results<DeveloperModuleEntity> = {
          realm.objects(DeveloperModuleEntity.self).sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(developer.toArray(ofType: DeveloperModuleEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [DeveloperModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = _realm {
        do {
          try realm.write({
            for developer in entities {
              realm.add(developer, update: .all)
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
  
  public func get(id: String) -> AnyPublisher<DeveloperModuleEntity, Error> {
    fatalError()
  }
  
  public func update(id: String, entity: DeveloperModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
