//
//  ProductsListViewCollectionViewCell.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 14.08.2024.
//

import UIKit

final class ProductsListViewCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ProductsListViewCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setUpLayer()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .lightGray
        contentView.layer.masksToBounds = true
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func applyTopCornersRadius() {
        let path = UIBezierPath(
            roundedRect: imageView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 10, height: 10)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        imageView.layer.mask = mask
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layoutIfNeeded()
        applyTopCornersRadius()
    }
    
    func configure(with product: Product) {
        print(product.brand)
        print(product.price)
    }
}
