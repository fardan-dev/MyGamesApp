//
//  DeveloperDomainModel.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

public struct DeveloperDomainModel {
  public var id: String
  public var imageBackground: String
  public var title: String
  public var subtitle: String
  
  public init(id: String, imageBackground: String, title: String, subtitle: String) {
    self.id = id
    self.imageBackground = imageBackground
    self.title = title
    self.subtitle = subtitle
  }
}
