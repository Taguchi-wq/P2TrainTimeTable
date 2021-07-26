//
//  URL+Extension.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/20.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

extension URL {
    
    /// 駅を検索するURL
    static func stationURL(_ stationTitle: String) -> URL? {
        var components = URLComponents()
        components.scheme = KeyManager.getValue("Scheme")
        components.host   = KeyManager.getValue("Host")
        components.path   = KeyManager.getValue("PathStation")
        components.queryItems = [
            URLQueryItem(name: "dc:title",        value: stationTitle),
            URLQueryItem(name: "acl:consumerKey", value: KeyManager.getValue("Key"))
        ]
        
        return components.url
    }
    
    /// 駅のタイムテーブルを検索するURL
    static func stationTimetableURL(_ stationTimetable: String) -> URL? {
        var components = URLComponents()
        components.scheme = KeyManager.getValue("Scheme")
        components.host   = KeyManager.getValue("Host")
        components.path   = KeyManager.getValue("PathStationTable")
        components.queryItems = [
            URLQueryItem(name: "owl:sameAs",      value: stationTimetable),
            URLQueryItem(name: "acl:consumerKey", value: KeyManager.getValue("Key"))
        ]
        
        return components.url
    }
    
    /// idから駅を検索するURL
    static func stationIDURL(_ id: String) -> URL? {
        var components = URLComponents()
        components.scheme = KeyManager.getValue("Scheme")
        components.host   = KeyManager.getValue("Host")
        components.path   = KeyManager.getValue("PathID") + id
        components.queryItems = [
            URLQueryItem(name: "acl:consumerKey", value: KeyManager.getValue("Key"))
        ]
        
        return components.url
    }
    
}
