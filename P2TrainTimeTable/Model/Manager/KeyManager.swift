//
//  KeyManager.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/19.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

class KeyManager {
    
    // MARK: - Properties
    /// URL.plistファイルを1回だけ読み込む
    private static let urlProperties = loadingURLPropertiesFile()
    
    
    // MARK: - Initializer
    private init() {}
    
    
    // MARK: - Methods
    /// URL.plistファイルを読み込む
    /// - Returns: keyがString、valueがAnyの辞書型
    private static func loadingURLPropertiesFile() -> [String : Any] {
        guard let path = Bundle.main.path(forResource: "URL", ofType: "plist") else { return [:] }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String : Any] else { return [:] }
        return dictionary
    }
    
    /// URL.plistファイルのValueをStringで得る
    /// - Parameter key: key名
    /// - Returns: keyに対応するvalue、keyに対応する値がない場合、Stringではない場合はnil
    static func getValue(_ key: String) -> String {
        return urlProperties[key] as? String ?? ""
    }
    
}
