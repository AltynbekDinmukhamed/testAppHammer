//
//  FoodItem.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 12.01.2024.
//

import Foundation
import Foundation

// Root response object
struct FoodsResponse: Decodable {
    let text: String
    let parsed: [ParsedFood]
    let hints: [FoodHint]
}

// Parsed object from the response
struct ParsedFood: Decodable {
    let food: FoodItem
}

// Hint object in the response
struct FoodHint: Decodable {
    let food: FoodItem
}

// Food item details
struct FoodItem: Decodable {
    let foodId: String
    let label: String
    let nutrients: Nutrients
    let category: String
    let categoryLabel: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case foodId = "foodId"
        case label = "label"
        case nutrients = "nutrients"
        case category = "category"
        case categoryLabel = "categoryLabel"
        case image = "image"
    }
}

// Nutrients object for food items
struct Nutrients: Decodable {
    let ENERC_KCAL: Double? // Energy in calories
    let PROCNT: Double?     // Protein content
    let FAT: Double?        // Fat content
    let CHOCDF: Double?     // Carbohydrates content
}
