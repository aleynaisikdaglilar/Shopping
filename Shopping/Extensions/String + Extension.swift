//
//  String + Extension.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 4.08.2024.
//

import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}
