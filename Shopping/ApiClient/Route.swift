//
//  Route.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 4.08.2024.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://dummyjson.com"
    
    case getProductCategoryList
    
    var description: String {
        
        switch self {
        case .getProductCategoryList:
            return "/products/category-list"
        }
    }
}
