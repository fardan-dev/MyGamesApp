//
//  GetGameRepository.swift
//  
//
//  Created by telkom on 03/08/23.
//

import Core
import Combine

public struct GetGameRepository<
  GameLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where GameLocaleDataSource.Response == GameModuleEntity, RemoteDataSource.Response == GameResponse, Transformer.Response == GameResponse, Transformer.Entity == GameModuleEntity, Transformer.Domain == GameDomainModel {
  public typealias Request = Any
  public typealias Response = GameDomainModel
  
  private let _localeDataSource: GameLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: GameLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: Request?) -> AnyPublisher<GameDomainModel, Error> {
    switch request as? RequestModel {
    case .gameDetail(let id):
      return _getDetail(id: id)
    case .isFavorited(let id):
      return _updateFavorite(id: id)
    default:
      fatalError()
    }
  }
  
  private func _updateFavorite(id: String) -> AnyPublisher<GameDomainModel, Error> {
    return _localeDataSource.get(id: id)
      .map { entity in
        let newEntity = GameModuleEntity()
        newEntity.id = entity.id
        newEntity.name = entity.name
        newEntity.released = entity.released
        newEntity.backgroundImage = entity.backgroundImage
        newEntity.rating = entity.rating
        newEntity.gameDescription = entity.gameDescription
        newEntity.platforms = entity.platforms
        newEntity.genres = entity.genres
        newEntity.publishers = entity.publishers
        newEntity.developers = entity.developers
        newEntity.tags = entity.tags
        newEntity.website = entity.website
        newEntity.detailUpdated = true
        newEntity.isFavorited = !entity.isFavorited
        return newEntity
      }
      .flatMap { _localeDataSource.update(id: id, entity: $0) }
      .filter { $0 }
      .flatMap { _ in
        _localeDataSource
          .get(id: id)
          .map { _mapper.transformEntityToDomain(entity: $0) }
      }
      .eraseToAnyPublisher()
  }
  
  private func _getDetail(id: String) -> AnyPublisher<GameDomainModel, Error> {
    return _localeDataSource.get(id: id)
      .flatMap { result -> AnyPublisher<GameDomainModel, Error> in
        if result.detailUpdated == false {
          return _remoteDataSource.execute(request: id as? RemoteDataSource.Request)
            .map { _mapper.transformResponseToEntity(response: $0) }
            .flatMap { _localeDataSource.update(id: id, entity: $0) }
            .filter { $0 }
            .flatMap { _ in
              _localeDataSource
                .get(id: id)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self._localeDataSource
            .get(id: id)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
}
