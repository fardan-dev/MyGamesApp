//
//  AboutView.swift
//  MyGames
//
//  Created by Muhamad Fardan Wardhana on 07/07/23.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading) {
          HStack {
            Image("fardan-img")
              .resizable()
              .frame(width: 80, height: 80)
              .cornerRadius(40)
            Spacer()
            VStack(alignment: .center) {
              Text("Muhamad Fardan Wardhana")
                .font(.system(size: 17, weight: .bold))
                .padding(.bottom, 4)
              Text("iOS Developer")
                .font(.system(size: 17, weight: .medium))
            }
            Spacer()
          }
          .padding(.bottom, 8)
          
          Text("Social Media")
            .font(.system(size: 17, weight: .bold))
          
          Divider()
            .background(Color.black)
          
          VStack(alignment: .leading) {
            HStack(alignment: .top) {
              HStack {
                Text("LinkedIn")
                  .font(.system(size: 14))
                Spacer()
                Text(":")
                  .font(.system(size: 14))
              }
              .frame(width: 80)
              
              Text("https://www.linkedin.com/in/muhamad-fardan-wardhana/")
                .font(.system(size: 14))
            }
            .padding(.bottom, 4)
            
            HStack {
              HStack {
                Text("Facebook")
                  .font(.system(size: 14))
                Spacer()
                Text(":")
                  .font(.system(size: 14))
              }
              .frame(width: 80)
              
              Text("https://web.facebook.com/FARdan88")
                .font(.system(size: 14))
            }
          }
        }
        .padding(16)
      }
      .navigationTitle("About")
    }
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
