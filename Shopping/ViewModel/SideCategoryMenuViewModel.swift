//
//  SideCategoryMenuViewModel.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 4.08.2024.
//

import Foundation

class SideCategoryMenuViewModel {
    private var categories: [String] = []
    
    var reloadTableView: (() -> Void)?
    
    func fetchCategories() {
        Service.shared.fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.reloadTableView?()
            case .failure(let error):
                print("Failed to fetch categories: \(error)")
            }
        }
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func category(at index: Int) -> String {
        return categories[index]
    }
}
