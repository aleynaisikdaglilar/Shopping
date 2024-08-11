//
//  TabBarController.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 7.08.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        
    }
    
    private func setUpTabs() {
        let dashboardVC = DashboardViewController()
        let categoryVC = CategoryViewController()
        
        
        dashboardVC.navigationItem.largeTitleDisplayMode = .automatic
        categoryVC.navigationItem.largeTitleDisplayMode = .automatic
        
        
        let nav1 = UINavigationController(rootViewController: dashboardVC)
        let nav2 = UINavigationController(rootViewController: categoryVC)
       
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "square.grid.2x2"), tag: 2)
        
        
        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
