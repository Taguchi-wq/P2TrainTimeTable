//
//  NetworkManager.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/15.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // MARK: - Static Properties
    /// NetworkManagerのshared
    static let shared = NetworkManager()
    
    
    // MARK: - Private Properties
    private let baseURL = "https://api-tokyochallenge.odpt.org/api/v4/"
    private let type    = "odpt:Station?"
    private let title   = "dc:title="
    private let apiKey  = "&acl:consumerKey=75LyUzspYl2pkwGesTzDTWWiOj-9xz9NnE_KU9yR7pU"
    
    
    // MARK: - Initializer
    private init() {}
    
    
    // MARK: - Methods
    /// 駅の情報を読み込む
    func loadStations(_ station: String, completion: @escaping ([Station]?, Error?) -> Void) {
        let encodeStation = station.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let urlString = baseURL + type + title + encodeStation + apiKey
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let station = try JSONDecoder().decode([Station].self, from: data)
                completion(station, nil)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
