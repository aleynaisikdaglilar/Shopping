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
    
    private var products: [ProductViewModel] = []
    
    var reloadCollectionView: (() -> Void)?
    
    deinit {
        print("ProductsListViewViewModel is being deallocated")
    }
    
    
    
    // Kategori seçimi gerçekleştiğinde tetiklenir
    func didSelectCategory(_ category: String) {
        if category == "All" {
            // Eğer "All" seçildiyse, tüm ürünleri çek
            fetchAllProducts()
        } else {
            // Diğer kategoriler için kategoriye göre ürünleri çek
            let formattedCategory = category.replacingOccurrences(of: " ", with: "-").lowercased()
            fetchProducts(forCategory: formattedCategory)
        }
    }
    
    // Tüm ürünleri çekme
    func fetchAllProducts() {
        Service.shared.fetchAllProducts { [weak self] result in
            switch result {
            case .success(let response):
                self?.products = response.products.map { product in
                    return ProductViewModel(
                        imageUrl: URL(string: product.thumbnail),
                        labelText: product.title,
                        rating: product.rating,
                        reviews: product.reviews,
                        price: product.price,
                        discountPercentage: product.discountPercentage,
                        availabilityStatus: product.availabilityStatus
                    )
                }
                self?.reloadCollectionView?()
            case .failure(let error):
                print("Failed to fetch all products: \(error)")
            }
        }
    }
    
    func fetchProducts(forCategory category: String) {
        Service.shared.fetchProducts(byCategory: category) { [weak self] result in
            switch result {
            case .success(let response):
                //                print(response.products)
                //                self?.products = response.products
                //                self?.products = response.products.map {
                //                    ProductViewModel(imageUrl: URL(string: $0.thumbnail), labelText: $0.title, rating: $0.rating, reviews: [Review])
                //                }
                
                self?.products = response.products.map { product in
                    // Map the Product model to ProductViewModel
                    return ProductViewModel(
                        imageUrl: URL(string: product.thumbnail),
                        labelText: product.title,
                        rating: product.rating,
                        reviews: product.reviews,
                        price: product.price,
                        discountPercentage: product.discountPercentage,
                        availabilityStatus: product.availabilityStatus
                    )
                }
                self?.reloadCollectionView?()
            case .failure(let error):
                print("Failed to fetch products: \(error)")
            }
        }
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func product(at index: Int) -> ProductViewModel {
        return products[index]
    }
    
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        reloadCollectionView = { [weak self, weak collectionView] in
            DispatchQueue.main.async {
                collectionView?.reloadData()
                
                // reloadData çağrısından sonra küçük bir gecikme ile seçim işlemini yapıyoruz
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let products = self?.products, !products.isEmpty {
                        let firstIndexPath = IndexPath(item: 0, section: 0)
                        collectionView?.selectItem(at: firstIndexPath, animated: false, scrollPosition: .top)
                        print("İlk hücre seçildi: \(firstIndexPath)")
                    }
                }
            }
        }
        
        // İlk olarak tüm ürünleri yükle
        fetchAllProducts()
    }
}

extension ProductsListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfProducts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsListViewCollectionViewCell.cellIdentifier, for: indexPath) as! ProductsListViewCollectionViewCell
        //        let product = product(at: indexPath.row)
        //        cell.configure(with: product)
        
        let productViewModel = product(at: indexPath.row)
        cell.configure(with: productViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 20
        let minimumInteritemSpacing: CGFloat = 10
        let availableWidth = UIScreen.main.bounds.width - (padding * 2) - minimumInteritemSpacing
        let width = availableWidth / 2
        let height = width * 1.7
        
        return CGSize(width: width, height: height)
    }
}
