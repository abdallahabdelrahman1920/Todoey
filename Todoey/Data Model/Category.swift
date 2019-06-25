//
//  Category.swift
//  Todoey
//
//  Created by Abdallah Ismail on 6/8/19.
//  Copyright © 2019 Abdallah Abdelrahman. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let items = List<Item>()
}
