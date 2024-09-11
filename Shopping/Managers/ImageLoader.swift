//
//  ImageLoader.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 17.08.2024.
//

import Foundation

final class ImageLoader {
    static let shared = ImageLoader()
    private var imageDataCache = NSCache<NSString, NSData>()

    private init() {}

    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(Error.badServerResponse))
                return
            }
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}





//final class ImageLoader {
//    static let shared = ImageLoader()
//
//    private var imageDataCache = NSCache<NSString, NSData>()
//
//    private init() {}
//
//    public func downloadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
//        let key = url.absoluteString as NSString
//        if let data = imageDataCache.object(forKey: key) {
//            if let image = UIImage(data: data as Data)?.cropBlackBorders() {
//                completion(.success(image))
//            }
//            return
//        }
//
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
//            guard let data = data, error == nil else {
//                completion(.failure(Error.badServerResponse))
//                return
//            }
//
//            if let image = UIImage(data: data)?.cropBlackBorders() {
//                let value = data as NSData
//                self?.imageDataCache.setObject(value, forKey: key)
//                completion(.success(image))
//            } else {
//                completion(.failure(Error.errorDecoding))
//            }
//        }
//        task.resume()
//    }
//}
//
