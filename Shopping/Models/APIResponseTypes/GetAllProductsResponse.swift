//
//  GetAllProductsResponse.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 4.08.2024.
//

import Foundation

struct GetAllProductsResponse: Codable {
    let products: [Product]
    let total, skip, limit: Int
}
