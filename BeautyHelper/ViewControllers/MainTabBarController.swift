//
//  MainTabBarController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 21.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .SpecialTabBar
        tabBar.barTintColor = .SpecialTabBar
        tabBar.tintColor = .specialGreen
        tabBar.unselectedItemTintColor = .specialGrey
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialBrown.cgColor
    }
    
    private func setupItems() {
        let scannerVC = UINavigationController(rootViewController: ScannerViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let historyVC = UINavigationController(rootViewController: HistoryViewController())
        
        setViewControllers([scannerVC, searchVC, historyVC], animated: true)
        
        guard let items = tabBar.items else { return }
        items[0].title = "Сканер"
        items[1].title = "Поиск"
        items[2].title = "История"
        
        items[0].image = UIImage(systemName: "viewfinder.circle")
        items[1].image = UIImage(systemName: "magnifyingglass.circle")
        items[2].image = UIImage(systemName: "star.circle")
        
    }
}


