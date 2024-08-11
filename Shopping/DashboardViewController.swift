//
//  DashboardViewController.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 3.08.2024.
//

import UIKit

final class DashboardViewController: UIViewController {
    
    private enum Constant {
        static let backgroundColor = UIColor(red: 254, green: 254, blue: 254, alpha: 1)
    }
    
    private var menuVC: MenuViewController!
    private var isMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.backgroundColor
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(menuButtonTapped))
        
        self.navigationItem.leftBarButtonItem = menuButton
        setupMenuViewController()
    }
    
    private func setupMenuViewController() {
        menuVC = MenuViewController()
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.view.frame = CGRect(x: -view.frame.width, y: 0, width: view.frame.width - 130, height: view.frame.height)
        menuVC.didMove(toParent: self)
    }
    
    @objc private func menuButtonTapped() {
        isMenuOpen.toggle()
        let targetPosition = isMenuOpen ? 0 : -view.frame.width
        
        UIView.animate(withDuration: 0.3) {
            self.menuVC.view.frame.origin.x = targetPosition
        }
    }
}

