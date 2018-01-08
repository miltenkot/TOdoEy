//
//  Category.swift
//  TOdoEy
//
//  Created by Bartek Lanczyk on 05.01.2018.
//  Copyright © 2018 miltenkot. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
