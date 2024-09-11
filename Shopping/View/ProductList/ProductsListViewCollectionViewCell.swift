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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let starRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var reviewsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var dollarLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var discountPercentageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var availabilityButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .systemRed
//        UIColor(red: 94/255, green: 167/255, blue: 123/255, alpha: 1)
        return imageView
    }()
    
    private func configureStarRating(with rating: Double) {
        
        starRatingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for i in 0..<5 {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageView.tintColor = .systemYellow
            
            if Double(i) < rating {
                if Double(i) + 1 <= rating {
                    starImageView.image = UIImage(systemName: "star.fill")
                } else if Double(i) + 0.5 <= rating {
                    starImageView.image = UIImage(systemName: "star.leadinghalf.filled")
                } else {
                    starImageView.image = UIImage(systemName: "star")
                }
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
            
            starRatingStackView.addArrangedSubview(starImageView)
            
            NSLayoutConstraint.activate([
                starImageView.widthAnchor.constraint(equalToConstant: 15),
                starImageView.heightAnchor.constraint(equalToConstant: 15)
            ])
        }
    }
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUpLayer()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(starRatingStackView)
        contentView.addSubview(reviewsCountLabel)
        contentView.addSubview(dollarLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountPercentageLabel)
        contentView.addSubview(availabilityButton)
        contentView.addSubview(favoriteIcon)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 170),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            ratingLabel.trailingAnchor.constraint(equalTo: starRatingStackView.leadingAnchor, constant: -8),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20),
            
            starRatingStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            starRatingStackView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 8),
            starRatingStackView.widthAnchor.constraint(equalToConstant: 80),
            starRatingStackView.heightAnchor.constraint(equalToConstant: 20),
            
            reviewsCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            reviewsCountLabel.leadingAnchor.constraint(equalTo: starRatingStackView.trailingAnchor, constant: 5),
            reviewsCountLabel.widthAnchor.constraint(equalToConstant: 20),
            reviewsCountLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dollarLabel.topAnchor.constraint(equalTo: starRatingStackView.bottomAnchor, constant: 2),
            dollarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: starRatingStackView.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: dollarLabel.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            discountPercentageLabel.topAnchor.constraint(equalTo: starRatingStackView.bottomAnchor, constant: 4),
            discountPercentageLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            discountPercentageLabel.heightAnchor.constraint(equalToConstant: 20),
            
            availabilityButton.topAnchor.constraint(equalTo: discountPercentageLabel.bottomAnchor, constant: 8),
            availabilityButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            availabilityButton.heightAnchor.constraint(equalToConstant: 30),
            
            favoriteIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            favoriteIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 30),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 30)
            
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
        starRatingStackView.layoutIfNeeded()
    }
    
    func configure(with viewModel: ProductViewModel) {
        titleLabel.text = viewModel.labelText
        configureStarRating(with: viewModel.rating)
        ratingLabel.text = String(viewModel.rating)
        reviewsCountLabel.text = "(" + String(viewModel.reviewsCount) + ")"
        dollarLabel.text = "$"
        priceLabel.text = String(viewModel.price)
        //        priceLabel.text = String(viewModel.discountPercentage)
        discountPercentageLabel.text = "% " + String(viewModel.discountPercentage)
        
        let availabilityText = viewModel.availabilityStatus == "In Stock" ? "In Stock" : "Out of Stock"
        availabilityButton.setTitle(availabilityText, for: .normal)
        
        if viewModel.availabilityStatus == "In Stock" {
            availabilityButton.backgroundColor = UIColor(red: 220/255, green: 247/255, blue: 233/255, alpha: 1)
            availabilityButton.layer.borderColor = UIColor(red: 94/255, green: 167/255, blue: 123/255, alpha: 1).cgColor
            availabilityButton.setTitleColor(UIColor(red: 94/255, green: 167/255, blue: 123/255, alpha: 1), for: .normal)
        } else {
            availabilityButton.backgroundColor = UIColor(red: 249/255, green: 230/255, blue: 229/255, alpha: 1)
            availabilityButton.layer.borderColor = UIColor(red: 177/255, green: 54/255, blue: 52/255, alpha: 1).cgColor
            availabilityButton.setTitleColor(UIColor(red: 177/255, green: 54/255, blue: 52/255, alpha: 1), for: .normal)
        }
        
        if let widthConstraint = availabilityButton.constraints.first(where: { $0.firstAttribute == .width }) {
            widthConstraint.constant = viewModel.buttonWidth
        } else {
            availabilityButton.widthAnchor.constraint(equalToConstant: viewModel.buttonWidth).isActive = true
        }
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
