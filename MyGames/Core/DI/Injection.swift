//
//  Injection.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 10/07/23.
//

import Foundation
import RealmSwift
import Core
import Game
import Developer
import UIKit

final class Injection: NSObject {
  private let realm = try? Realm()
  
  func provideGames<U: UseCase>() -> U where U.Request == Any, U.Response == [GameDomainModel] {
    let locale = GetGamesLocaleDataSource(realm: realm)
    let remote = GetGamesRemoteDataSource(
      endpoint: Endpoints.Gets.games.url,
      parameters: Parameter.defaultParameters())
    let mapper = GamesTransformer()
    let repository = GetGamesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
  }
  
  func provideDetailGame<U: UseCase>() -> U where U.Request == Any, U.Response == GameDomainModel {
    let locale = GetGameLocaleDataSource(realm: realm)
    let remote = GetGameRemoteDataSource(
      endpoint: Endpoints.Gets.games.url,
      parameters: Parameter.defaultParameters())
    let mapper = GameTransformer()
    let repository = GetGameRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
  }
  
  func provideDevelopers<U: UseCase>() -> U where U.Request == Any, U.Response == [DeveloperDomainModel] {
    let locale = GetDevelopersLocaleDataSource(realm: realm)
    let remote = GetDevelopersRemoteDataSource(
      endpoint: Endpoints.Gets.developers.url,
      parameters: Parameter.defaultParameters())
    let mapper = DevelopersTransformer()
    let repository = GetDevelopersRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
  }
}
