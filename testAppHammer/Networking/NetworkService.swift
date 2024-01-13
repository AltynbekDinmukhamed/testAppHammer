//
//  NetworkService.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 12.01.2024.
//

import Foundation


enum NetworkError: Error {
    case invalidUrl
    case noData
}

class NetworkService: NetworkServiceProtocol {
    private let baseUrl = "https://api.edamam.com/api/food-database/v2/parser"
    private let appKey = "cef8799fe7dd6f3f4199ea1cc8ddacc7" // Your actual app key
    private let appId = "b8b102c5"
    
    func fetchFoods(query: String, completion: @escaping (Result<[FoodItem], Error>) -> Void) {
        guard let url = constructURL(with: query) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(FoodsResponse.self, from: data)
                print(response)
                completion(.success(response.hints.map { $0.food }))
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func constructURL(with query: String) -> URL? {
        var components = URLComponents(string: baseUrl)
        components?.queryItems = [
            URLQueryItem.init(name: "ingr", value: query),
            URLQueryItem.init(name: "app_id", value: appId),
            URLQueryItem.init(name: "app_key", value: appKey)
        ]
        return components?.url
    }
}
