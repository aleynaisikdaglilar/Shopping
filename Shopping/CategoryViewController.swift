//
//  CategoryViewController.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 7.08.2024.
//

import UIKit

final class CategoryViewController: UIViewController {

    private enum Constant {
        static let backgroundColor = UIColor(red: 254, green: 254, blue: 254, alpha: 1)
    }
    
    private let categoryView = CategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.backgroundColor
        title = "Categories"
        prepareUI()
    }
    
    private func prepareUI() {
        view.addSubview(categoryView)
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: view.topAnchor),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
   

}
