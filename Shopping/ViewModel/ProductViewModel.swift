//
//  ProductViewModel.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 17.08.2024.
//

import UIKit

final class ProductViewModel {
    let imageUrl: URL?
    let labelText: String
    let rating: Double
    let reviewsCount: Int
    let price: Double
    let discountPercentage: Double
    let availabilityStatus: String
    
    var buttonWidth: CGFloat {
        let availabilityText = availabilityStatus == "In Stock" ? "In Stock" : "Out of Stock"
        let buttonTitleSize = availabilityText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)])
        let padding: CGFloat = 20
        return buttonTitleSize.width + padding
    }
    
    init(imageUrl: URL?, labelText: String, rating: Double, reviews: [Review], price: Double, discountPercentage: Double, availabilityStatus: String) {
        self.imageUrl = imageUrl
        self.labelText = labelText
        
        let truncatedRating = Double(Int(rating * 10)) / 10.0
        self.rating = truncatedRating
        
        self.reviewsCount = reviews.count
        self.price = price
        self.discountPercentage = discountPercentage
        self.availabilityStatus = availabilityStatus
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(Error.invalidUrl))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
