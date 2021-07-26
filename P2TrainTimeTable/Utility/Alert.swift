//
//  Alert.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/24.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import UIKit

class Alert {
    
    /// ベーシックなアラートを作成する
    private static func createBasicAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: String(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    /// Realmに保存された時に表示するアラート
    static func presentSavedStation(on viewController: UIViewController) {
        let alert = createBasicAlert(title: "お気に入り登録をしたよ")
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }
    
    /// Realmから削除した時に表示するアラート
    static func presentDeletedStation(on viewController: UIViewController) {
        let alert = createBasicAlert(title: "お気に入り登録から消したよ")
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }
    
}
