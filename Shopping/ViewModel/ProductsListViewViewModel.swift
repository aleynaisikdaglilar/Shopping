//
//  ProductsListViewViewModel.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 14.08.2024.
//

import UIKit

protocol CategorySelectionDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

final class ProductsListViewViewModel: NSObject, CategorySelectionDelegate {
    
    private var products: [Product] = []
    
    var reloadCollectionView: (() -> Void)?
    
    deinit {
            print("ProductsListViewViewModel is being deallocated")
        }
    
    func didSelectCategory(_ category: String) {
        print("Selected Category: \(category)")
        fetchProducts(forCategory: category)
    }
    
    func fetchProducts(forCategory category: String) {
        Service.shared.fetchProducts(byCategory: category) { [weak self] result in
            switch result {
            case .success(let response):
                print(response.products)
                self?.products = response.products
                self?.reloadCollectionView?()
            case .failure(let error):
                print("Failed to fetch products: \(error)")
            }
        }
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func product(at index: Int) -> Product {
        return products[index]
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

extension ProductsListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfProducts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsListViewCollectionViewCell.cellIdentifier, for: indexPath) as! ProductsListViewCollectionViewCell
        let product = product(at: indexPath.row)
        cell.configure(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 20
        let minimumInteritemSpacing: CGFloat = 10
        let availableWidth = UIScreen.main.bounds.width - (padding * 2) - minimumInteritemSpacing
        let width = availableWidth / 2
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
}
