//
//  File.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

public enum RequestModel {
  case list
  case listFavourited
  case isFavorited(id: String)
  case gameDetail(id: String)
}
