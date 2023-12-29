//
//  GameModuleEntity.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Foundation
import RealmSwift

public class GameModuleEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var released: String = ""
  @objc dynamic var backgroundImage: String = ""
  @objc dynamic var rating: String = ""
  @objc dynamic var gameDescription: String?
  @objc dynamic var platforms: String?
  @objc dynamic var genres: String?
  @objc dynamic var publishers: String?
  @objc dynamic var developers: String?
  @objc dynamic var tags: String?
  @objc dynamic var website: String?
  @objc dynamic var detailUpdated: Bool = false
  @objc dynamic var isFavorited: Bool = false
  
  public override class func primaryKey() -> String? {
    return "id"
  }
}
