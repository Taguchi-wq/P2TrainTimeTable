//
//  Array+Extension.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/23.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

extension Array {
    
    /// 添字
    /// インデックスが配列の範囲内の場合は配列の要素を返す
    /// 範囲外の場合はnilを返す
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
