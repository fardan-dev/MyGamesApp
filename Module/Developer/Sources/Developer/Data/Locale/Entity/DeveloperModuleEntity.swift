//
//  DeveloperModuleEntity.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Foundation
import RealmSwift

public class DeveloperModuleEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var gamesCount: String = ""
  @objc dynamic var imageBackground: String = ""
  
  public override class func primaryKey() -> String? {
    return "id"
  }
}
