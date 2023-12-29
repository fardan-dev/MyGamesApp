//
//  GameRow.swift
//  MyGames
//
//  Created by telkom on 08/07/23.
//

import SwiftUI
import CachedAsyncImage
import Core

struct GameRow: View {
  let imageURL: String
  let title: String
  let rating: String
  let releasedDate: String
  
  var body: some View {
    VStack(alignment: .leading) {
      CachedAsyncImage(url: URL.init(string: imageURL)) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .scaledToFit()
      Text(title)
        .font(.system(size: 14, weight: .bold))
        .foregroundColor(.white)
        .padding([.leading, .trailing, .top], 8)
      HStack {
        Image(systemName: "star.fill")
          .renderingMode(.template)
          .foregroundColor(.yellow)
        Text(rating)
          .font(.system(size: 14, weight: .medium))
          .foregroundColor(.white)
        Spacer()
        HStack {
          Text("released")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
          Text("\(releasedDate)")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
        }
      }
      .padding(8)
    }
    .background(Color.primaryBlack)
    .frame(width: UIScreen.main.bounds.width - 32)
    .cornerRadius(8.0)
  }
}

struct GameRow_Previews: PreviewProvider {
  static var previews: some View {
    GameRow(imageURL: "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80", title: "Ini Title", rating: "2.0", releasedDate: "01-01-1988")
  }
}
