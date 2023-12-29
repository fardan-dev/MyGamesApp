//
//  FavouritesView.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 07/07/23.
//

import SwiftUI
import Core
import Game

struct FavouritesView: View {
  typealias Presenter = GetListPresenter<
    Any, GameDomainModel,
    Interactor<Any,
               [GameDomainModel],
               GetGamesRepository<GetGamesLocaleDataSource,
                                  GetGamesRemoteDataSource,
                                  GamesTransformer>
    >
  >
  
  @ObservedObject var presenter: Presenter
  
  var body: some View {
    NavigationStack {
      ZStack {
        if presenter.list.isEmpty {
          Text("Halaman Favorit Kamu Masih Kosong...")
            .font(.system(size: 14))
            .foregroundColor(.gray)
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(presenter.list, id: \.id) { game in
              ZStack {
                NavigationLink {
                  GamesRouter()
                    .makeGameDetailView(id: "\(game.id)")
                } label: {
                  GameRow(
                    imageURL: game.backgroundImage,
                    title: game.name,
                    rating: game.rating,
                    releasedDate: game.released
                  )
                }
              }
              .padding(8)
            }
          }
          .refreshable {
            presenter.getList(request: RequestModel.listFavourited)
          }
        }
      }
      .alert(presenter.errorMessage, isPresented: $presenter.isError) {
        Button("OK", role: .cancel) { }
      }
      .navigationTitle("Favourites")
    }
    .onAppear {
      presenter.getList(request: RequestModel.listFavourited)
    }
  }
}
