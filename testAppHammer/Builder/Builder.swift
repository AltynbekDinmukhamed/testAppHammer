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
        let menuViewController = MainViewController()
        let contactsViewController = ContactsViewController()
        let profileViewController = ProfileViewController()
        let cartViewController = CartViewController()
        let networkService = NetworkService()
        let presenter = MainViewPresenter(view: menuViewController, networkService: networkService)
        menuViewController.presenter = presenter
        
        menuViewController.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(named: "menuIcon"), selectedImage: UIImage(named: "menuIconFilled"))
        contactsViewController.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(named: "contactsIcon"), selectedImage: UIImage(named: "contactsIconFilled"))
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profileIcon"), selectedImage: UIImage(named: "profileIconFilled"))
        cartViewController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "cartIcon"), selectedImage: UIImage(named: "cartIconFilled"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            menuViewController,
            contactsViewController,
            profileViewController,
            cartViewController
        ].map { UINavigationController(rootViewController: $0) }

        // Customize the appearance for normal state
        tabBarController.tabBar.backgroundColor = .white
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "SFUIDisplay-Regular", size: 13)!,
            .foregroundColor: UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1)
        ]
        
        // Customize the appearance for selected state
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "SFUIDisplay-Regular", size: 13)!,
            .foregroundColor: UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        ]
                
        // Set the appearance for normal state
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        
        // Set the appearance for selected state
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        
        // Set the icon color for selected state
        tabBarController.tabBar.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        
        // Set the icon color for unselected state
        tabBarController.tabBar.unselectedItemTintColor = UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1)
        
        // Return the tab bar controller
        return tabBarController
    }
}
