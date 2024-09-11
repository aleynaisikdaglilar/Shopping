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
    private let productsListView = ProductsListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.backgroundColor
        title = "Categories"
        prepareUI()
        
        categoryView.viewModel.delegate = productsListView.viewModel
    }
    
    private func prepareUI() {
        view.addSubview(categoryView)
        view.addSubview(productsListView)
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: view.topAnchor),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: 280),
            
            productsListView.topAnchor.constraint(equalTo: categoryView.bottomAnchor),
            productsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
