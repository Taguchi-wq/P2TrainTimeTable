//
//  TimetableObject.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/17.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

struct TimetableObject: Decodable {
    let departureTime: String
    
    enum CodingKeys: String, CodingKey {
        case departureTime = "odpt:departureTime"
    }
}
