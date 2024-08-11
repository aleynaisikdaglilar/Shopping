//
//  CategoryView.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 8.08.2024.
//

import UIKit

final class CategoryView: UIView {
    
    private enum Constant {
        static let contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private let viewModel = CategoryViewViewModel()
    
    private lazy var scrollView: UIView = {
        let scrollView = UIView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .yellow
        return scrollView
    }()
    
    //    private lazy var collectionView: UIView = {
    //        let scrollView = UIView()
    //        scrollView.translatesAutoresizingMaskIntoConstraints = false
    //        scrollView.backgroundColor = .red
    //        return scrollView
    //    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = Constant.contentInset
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        addSubview(collectionView)
//        setupBindings()
        viewModel.configureCollectionView(collectionView)
        viewModel.fetchCategories()
        addConstraints()
        
    }
    
    private func setupBindings() {
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        
        let safeguide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeguide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeguide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeguide.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: safeguide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeguide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
    }
    
    
}
