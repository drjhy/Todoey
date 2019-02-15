//
//  Item.swift
//  Todoey
//
//  Created by John Young on 2/13/19.
//  Copyright © 2019 John Young. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
   
}
