//
//  Timetable.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/17.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

struct Timetable: Decodable {
    let timetableObject: [TimetableObject]
    
    enum CodingKeys: String, CodingKey {
        case timetableObject = "odpt:stationTimetable"
    }
}
