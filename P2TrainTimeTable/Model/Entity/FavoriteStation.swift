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
    @objc dynamic var id   = String()
    @objc dynamic var name = String()
    @objc dynamic var line = String()
}
