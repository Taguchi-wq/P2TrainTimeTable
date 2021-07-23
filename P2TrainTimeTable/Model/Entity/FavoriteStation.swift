//
//  FavoriteStation.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/23.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteStation: Object {
    @objc dynamic var id: String!
    @objc dynamic var title: String!
    @objc dynamic var line: String!
    
    convenience init(id: String, title: String, line: String) {
        self.init()
        
        self.id    = id
        self.title = title
        self.line  = line
    }
}
