//
//  NetworkServiceProtocol.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 12.01.2024.
//

import Foundation
protocol NetworkServiceProtocol {
    func fetchFoods(query: String, completion: @escaping(Result<[FoodItem], Error>) -> Void)
}
