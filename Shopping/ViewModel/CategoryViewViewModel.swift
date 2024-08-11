//
//  CategoryViewViewModel.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 10.08.2024.
//

import UIKit

final class CategoryViewViewModel: NSObject {
    
    private var categories: [String] = []
    
    var reloadCollectionView: (() -> Void)?
    
    func fetchCategories() {
        Service.shared.fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
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
    
    func configureCollectionView(_ collectionView: UICollectionView) {
            collectionView.dataSource = self
            collectionView.delegate = self
            reloadCollectionView = { [weak collectionView] in
                DispatchQueue.main.async {
                    collectionView?.reloadData()
                }
            }
        }
}

extension CategoryViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        let category = category(at: indexPath.row)
        cell.configure(with: category)
        return cell
    }
}
