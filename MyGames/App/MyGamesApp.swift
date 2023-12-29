//
//  MyGamesApp.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 07/07/23.
//

import SwiftUI
import Core
import Game
import Developer

let gamesUseCase: Interactor<
  Any,
  [GameDomainModel],
  GetGamesRepository<GetGamesLocaleDataSource,
                     GetGamesRemoteDataSource,
                     GamesTransformer>
> = Injection().provideGames()

let favouritesUseCase: Interactor<
  Any,
  [GameDomainModel],
  GetGamesRepository<GetGamesLocaleDataSource,
                     GetGamesRemoteDataSource,
                     GamesTransformer>
> = Injection().provideGames()

let detailGameUseCase: Interactor<Any ,GameDomainModel,GetGameRepository<GetGameLocaleDataSource,GetGameRemoteDataSource,GameTransformer>
> = Injection().provideDetailGame()

let developersUseCase: Interactor<
  Any,
  [DeveloperDomainModel],
  GetDevelopersRepository<GetDevelopersLocaleDataSource,
                          GetDevelopersRemoteDataSource,
                          DevelopersTransformer>
> = Injection().provideDevelopers()

@main
struct MyGamesApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
