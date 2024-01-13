//
//  MainViewPresenter.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 12.01.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var categories: [String] { get }
    var foodItems: [FoodItem]? { get }
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getFoodItems()
    func getFoodItems(forCategory category: String)
    func didSelectCategory(_ category: String)
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    var categories: [String] = ["Pizza", "Sushi", "Drinks", "Desserts", "Salads"]
    var foodItems: [FoodItem]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getFoodItems()
    }
    
    func getCategories() {
        // In a real app, categories could be fetched from a network or local database
        // For this example, we're using static data defined in the `categories` array
    }
    
    func getFoodItems() {
        networkService.fetchFoods(query: "Pizza") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let foodItems):
                    self?.foodItems = foodItems
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    
    func getFoodItems(forCategory category: String) {
        // Implement fetching logic for specific categories
    }
    
    func didSelectCategory(_ category: String) {
        networkService.fetchFoods(query: category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let foodItems):
                    self?.foodItems = foodItems
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}

