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
    
    
    // MARK: - Private Methods
    /// Realmにobjectを保存する
    private func write<T: Object>(_ object: T) {
        do {
            try realm.write { realm.add(object) }
        } catch {
            print(error)
        }
    }
    
    /// Realmのobjectを削除する
    private func delete<T: Object>(_ object: T) {
        do {
            try realm.write { realm.delete(object) }
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Methods
    /// Realmに保存されているobjectを読み込む
    func load<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    /// プライマリーキーからお気に入りされた駅を読み込む
    func loadFavoriteStationByPrimaryKey(_ primaryKey: String) -> FavoriteStation? {
        return realm.object(ofType: FavoriteStation.self, forPrimaryKey: primaryKey)
    }
    
    /// お気に入りの駅を保存する
    func writeFavoriteStation(_ station: FavoriteStation) {
        write(station)
    }
    
    /// お気に入りの駅を削除する
    func deleteFavoriteStation(_ station: FavoriteStation) {
        delete(station)
    }
    
}
