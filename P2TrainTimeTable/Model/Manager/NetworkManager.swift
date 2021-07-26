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
    
    
    // MARK: - Initializer
    private init() {}
    
    
    // MARK: - Methods
    /// APIから情報を読み込む
    func load<T: Decodable>(_ url: URL, type: T.Type, completion: @escaping ([T]?, Error?) -> Void) {
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
                let typeObjects = try JSONDecoder().decode([T].self, from: data)
                DispatchQueue.main.async { completion(typeObjects, nil) }
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
