//
//  GetDevelopersRepository.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Core
import Combine

public struct GetDevelopersRepository<
  GameLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where GameLocaleDataSource.Response == DeveloperModuleEntity, RemoteDataSource.Response == [DeveloperResponse], Transformer.Response == [DeveloperResponse], Transformer.Entity == [DeveloperModuleEntity], Transformer.Domain == [DeveloperDomainModel] {
  public typealias Request = Any
  public typealias Response = [DeveloperDomainModel]
  
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
  
  public func execute(request: Request?) -> AnyPublisher<[DeveloperDomainModel], Error> {
    return _localeDataSource.list(request: request as? GameLocaleDataSource.Request)
      .flatMap { result -> AnyPublisher<[DeveloperDomainModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: request as? RemoteDataSource.Request)
            .map { _mapper.transformResponseToEntity(response: $0) }
            .catch { _ in _localeDataSource.list(request: request as? GameLocaleDataSource.Request) }
            .flatMap { _localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.list(request: request as? GameLocaleDataSource.Request)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _localeDataSource.list(request: request as? GameLocaleDataSource.Request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
}
