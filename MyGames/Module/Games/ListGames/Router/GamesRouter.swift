//
//  GamesRouter.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 15/07/23.
//

import SwiftUI
import Core
import Game

class GamesRouter {
  func makeGameDetailView(id: String) -> some View {
    let gameDetailPresenter = GetDetailPresenter<Any, GameDomainModel, Interactor<Any, GameDomainModel, GetGameRepository<GetGameLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>>(useCase: detailGameUseCase)
    return GameDetailView(presenter: gameDetailPresenter, id: id)
  }
}
