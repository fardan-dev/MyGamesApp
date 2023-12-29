//
//  DevelopersView.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 07/07/23.
//

import SwiftUI
import Core
import Developer

struct DevelopersView: View {
  @ObservedObject var presenter: GetListPresenter<Any, DeveloperDomainModel, Interactor<Any, [DeveloperDomainModel], GetDevelopersRepository<GetDevelopersLocaleDataSource, GetDevelopersRemoteDataSource, DevelopersTransformer>>>
  
  var body: some View {
    NavigationStack {
      ZStack {
        if presenter.isLoading {
          ProgressView()
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(presenter.list, id: \.id) { developer in
              ZStack {
                DeveloperRow(
                  imageURL: developer.imageBackground,
                  title: developer.title,
                  subtitle: developer.subtitle
                )
              }
            }
          }
        }
      }
      .alert(presenter.errorMessage, isPresented: $presenter.isError) {
        Button("OK", role: .cancel) { }
      }
      .navigationTitle("Developers")
    }
    .onAppear {
      if presenter.list.isEmpty {
        presenter.getList(request: nil)
      }
    }
  }
}
