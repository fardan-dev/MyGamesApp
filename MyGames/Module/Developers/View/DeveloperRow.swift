//
//  DeveloperRow.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 14/07/23.
//

import SwiftUI
import CachedAsyncImage

@available(iOS 15.0, *)
struct DeveloperRow: View {
  var imageURL: String
  var title: String
  var subtitle: String
  
  var body: some View {
    VStack {
      HStack {
        CachedAsyncImage(url: URL(string: imageURL)) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .scaledToFill()
        .frame(width: 60, height: 60)
        .cornerRadius(30)
        
        VStack(alignment: .leading) {
          Text(title)
            .font(.system(size: 14, weight: .medium))
            .padding([.top, .bottom], 4)
            .lineLimit(2)
          Text(subtitle)
            .font(.system(size: 14, weight: .medium))
            .lineLimit(1)
        }
        .padding(.leading, 8)
        
        Spacer(minLength: 8)
      }
      
      Divider()
    }
    .padding([.leading, .top, .trailing], 16)
  }
}

@available(iOS 15.0, *)
struct DeveloperRow_Previews: PreviewProvider {
  static var previews: some View {
    DeveloperRow(imageURL: "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
                 title: "title",
                 subtitle: "subtitle")
  }
}
