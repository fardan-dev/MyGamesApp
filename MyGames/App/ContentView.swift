//
//  ContentView.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 07/07/23.
//

import SwiftUI
import Core
import Game
import Developer

@available(iOS 16.0, *)
struct ContentView: View {
  var gamesPresenter = GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer>>>(useCase: gamesUseCase)
  var favouritesPresenter = GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer>>>(useCase: favouritesUseCase)
  var developersPresenter = GetListPresenter<Any, DeveloperDomainModel, Interactor<Any, [DeveloperDomainModel], GetDevelopersRepository<GetDevelopersLocaleDataSource, GetDevelopersRemoteDataSource, DevelopersTransformer>>>(useCase: developersUseCase)
  
  var body: some View {
    TabView {
      GamesView(presenter: gamesPresenter)
        .tabItem {
          Label("games_tab_title", systemImage: "gamecontroller.fill")
        }
      
      FavouritesView(presenter: favouritesPresenter)
        .tabItem {
          Label("favorites_tab_title", systemImage: "heart.fill")
        }
      
      DevelopersView(presenter: developersPresenter)
        .tabItem {
          Label("developers_tab_title", systemImage: "person.2.fill")
        }
      
      AboutView()
        .tabItem {
          Label("about_tab_title", systemImage: "person.fill")
        }
    }
  }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
