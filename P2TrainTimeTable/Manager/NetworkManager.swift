//
//  NetworkManager.swift
//  P2TrainTimeTable
//
//  Created by cmStudent on 2021/07/15.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // MARK: - Properties
    /// NetworkManagerのshared
    static let shared = NetworkManager()
    private let url = ""
    
    
    // MARK: - Initializer
    private init() {}
    
    
    // MARK: - Methods
    /// 駅の情報を読み込む
    func loadStations(_ url: URL?, completion: @escaping ([Station]) -> Void) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            do {
                let station = try JSONDecoder().decode([Station].self, from: data)
                completion(station)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
