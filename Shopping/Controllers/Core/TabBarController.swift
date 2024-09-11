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
        let categoryVC = CategoryViewController()
        
        
        categoryVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: categoryVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        
        for nav in [nav1] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1], animated: true)
    }
}
