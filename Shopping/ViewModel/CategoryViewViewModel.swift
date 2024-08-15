//
//  CategoryViewViewModel.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 10.08.2024.
//

import UIKit

final class CategoryViewViewModel: NSObject {
    
    private var categories: [String] = []
    private var products: [Product] = []
    
    var reloadCollectionView: (() -> Void)?
    
    func fetchProducts(forCategory category: String) {
            Service.shared.fetchProducts(byCategory: category) { [weak self] result in
                switch result {
                case .success(let products):
                    self?.products = products.products
//                    self?.reloadProductListView?()
                case .failure(let error):
                    print("Failed to fetch products: \(error)")
                }
            }
        }
    
    func fetchCategories() {
        Service.shared.fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                if let processedCategories = self?.processCategories(categories) {
                    self?.categories = processedCategories
                    self?.reloadCollectionView?()
                }
                
            case .failure(let error):
                print("Failed to fetch categories: \(error)")
            }
        }
    }
    
    private func processCategories(_ categories: [String]) -> [String] {
        return categories.map { category in
            category
                .replacingOccurrences(of: "-", with: " ")
                .capitalized
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = category(at: indexPath.row)
        let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        let textAttributes = [NSAttributedString.Key.font: font]
        let textSize = (category as NSString).size(withAttributes: textAttributes)
        
        let padding: CGFloat = 20.0
        let cellWidth = textSize.width + padding
        let minWidth: CGFloat = 50.0
        
        return CGSize(width: max(cellWidth, minWidth), height: 40) 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        print(category)
    }
}
