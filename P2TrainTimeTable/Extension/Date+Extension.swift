//
//  Date+Extension.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/24.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

extension Date {
    
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .japan
        calendar.locale   = .japan
        return calendar
    }
    
    /// 休日判定
    var isHoliday: Bool {
        let index = calendar.component(.weekday, from: self)
        let weekday = Weekday(rawValue: index) ?? .monday
        switch weekday {
        case .sunday, .saturday:
            return true
        default:
            return false
        }
    }
    
}








