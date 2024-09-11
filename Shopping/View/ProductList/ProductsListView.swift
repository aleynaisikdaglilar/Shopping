//
//  ProductsListView.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 14.08.2024.
//

import UIKit

final class ProductsListView: UIView {
    
    private enum Constant {
        static let contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
     let viewModel = ProductsListViewViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = Constant.contentInset
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(red: 254, green: 254, blue: 254, alpha: 1)
        collectionView.register(ProductsListViewCollectionViewCell.self, forCellWithReuseIdentifier: ProductsListViewCollectionViewCell.cellIdentifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        viewModel.configureCollectionView(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
