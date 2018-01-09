//
//  Category.swift
//  TOdoEy
//
//  Created by Bartek Lanczyk on 05.01.2018.
//  Copyright © 2018 miltenkot. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = ""
    let items = List<Item>()
}
