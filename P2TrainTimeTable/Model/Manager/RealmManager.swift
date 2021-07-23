//
//  RealmManager.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/23.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    // MARK: - Static Properties
    /// RealmManagerのshared
    static let shared = RealmManager()
    
    
    // MARK: - Private Properties
    /// Realmをインスタンス化
    private let realm = try! Realm()
    
    
    // MARK: - Initializer
    private init() {}
    
}
