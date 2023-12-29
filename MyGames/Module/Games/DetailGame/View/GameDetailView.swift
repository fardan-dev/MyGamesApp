//
//  DetailGameView.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 15/07/23.
//

import SwiftUI
import CachedAsyncImage
import AttributedText
import Core
import Game

struct GameDetailView: View {
  @ObservedObject var presenter: GetDetailPresenter<Any, GameDomainModel, Interactor<Any, GameDomainModel, GetGameRepository<GetGameLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>>
  let id: String
  
  var body: some View {
    NavigationStack {
      ZStack {
        if presenter.isLoading {
          ProgressView()
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            VStack {
              bannerImage
              
              VStack(alignment: .leading, spacing: 16) {
                HStack {
                  ratingView
                  Spacer()
                  HStack {
                    Text("released")
                      .font(.system(size: 12))
                    Text("\(presenter.item?.released ?? "")")
                      .font(.system(size: 12))
                  }
                }
                customText(
                  title: "about_title",
                  subtitle: presenter.item?.description ?? ""
                )
                
                HStack(alignment: .top) {
                  HStack {
                    customText(
                      title: "platforms_title",
                      subtitle: presenter.item?.platforms ?? ""
                    )
                    Spacer()
                  }
                  .frame(maxWidth: .infinity)
                  HStack {
                    customText(
                      title: "genre_title",
                      subtitle: presenter.item?.genres ?? ""
                    )
                    Spacer()
                  }
                  .frame(maxWidth: .infinity)
                }
                
                HStack(alignment: .top) {
                  HStack {
                    customText(
                      title: "publisher_title",
                      subtitle: presenter.item?.publishers ?? ""
                    )
                    Spacer()
                  }
                  .frame(maxWidth: .infinity)
                  HStack {
                    customText(
                      title: "developer_title",
                      subtitle: presenter.item?.developers ?? ""
                    )
                    Spacer()
                  }
                  .frame(maxWidth: .infinity)
                }
                
                customText(
                  title: "tag_title",
                  subtitle: presenter.item?.tags ?? ""
                )
                customText(
                  title: "website_title",
                  subtitle: presenter.item?.website ?? ""
                )
              }
              .padding(16)
            }
          }
        }
      }
      .alert(presenter.errorMessage, isPresented: $presenter.isError) {
        Button("OK", role: .cancel) { }
      }
      .navigationTitle(presenter.item?.name ?? "")
      .toolbar {
        ToolbarItem {
          Button {
            self.presenter.getDetail(request: RequestModel.isFavorited(id: id))
          } label: {
            Image(systemName: "heart.fill")
              .tint(
                self.presenter.item?.isFavorited == true ? .primaryRed : .gray
              )
          }
        }
      }
    }
    .onAppear {
      presenter.getDetail(request: RequestModel.gameDetail(id: id))
    }
  }
}

extension GameDetailView {
  var bannerImage: some View {
    CachedAsyncImage(url: URL(string: presenter.item?.backgroundImage ?? "")) { image in
      image.resizable()
    } placeholder: {
      ProgressView()
    }
    .scaledToFit()
  }
  
  var ratingView: some View {
    HStack {
      Image(systemName: "star.fill")
        .renderingMode(.template)
        .foregroundColor(.yellow)
      Text(presenter.item?.rating ?? "0")
        .font(.system(size: 12))
    }
  }
  
  func customText(title: String, subtitle: String) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title.localized(identifier: "com.dicoding.academy.MyGames"))
        .font(.system(size: 14, weight: .medium))
      AttributedText(subtitle)
        .font(.system(size: 14))
    }
  }
}
