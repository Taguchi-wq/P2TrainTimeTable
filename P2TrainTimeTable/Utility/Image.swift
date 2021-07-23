//
//  Image.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/23.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

public enum Image {
    case star
    case starFill
    
    /// 画像の名前
    var name: String {
        switch self {
        case .star:
            return "star"
        case .starFill:
            return "star_fill"
        }
    }
}
