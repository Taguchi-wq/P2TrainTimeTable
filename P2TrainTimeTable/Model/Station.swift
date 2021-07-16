//
//  Station.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/17.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

struct Station: Decodable {
    let title: String
    let railway: String
    let stationTimetable: [String]
    
    enum CodingKeys: String, CodingKey {
        case title            = "dc:title"
        case railway          = "odpt:railway"
        case stationTimetable = "odpt:stationTimetable"
    }
}
