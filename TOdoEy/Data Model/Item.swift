//
//  Item.swift
//  TOdoEy
//
//  Created by Bartek Lanczyk on 05.01.2018.
//  Copyright © 2018 miltenkot. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
