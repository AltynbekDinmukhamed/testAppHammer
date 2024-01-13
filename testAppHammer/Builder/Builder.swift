//
//  Builder.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 12.01.2024.
//

import Foundation
import UIKit

class MainViewBuilder {
    
    static func createMainModule() -> UIViewController {
        let mainView = MainViewController()
        let networkService = NetworkService()
        let presenter = MainViewPresenter(view: mainView, networkService: networkService)
        mainView.presenter = presenter
        
        // Return the main view controller fully constructed with its dependencies
        return mainView
    }
    
//    // This method would construct the detail module, similar to the main module
//    static func createDetailModule(withFoodItem foodItem: FoodItem) -> UIViewController {
//        let detailView = DetailViewController()
//        // Assume DetailPresenter and its required protocol exists
//        let presenter = DetailPresenter(view: detailView, foodItem: foodItem)
//        
//        // Set the presenter property of the detail view
//        detailView.presenter = presenter
//        
//        // Return the detail view controller fully constructed with its dependencies
//        return detailView
//    }
}
