//
//  Service.swift
//  Shopping
//
//  Created by Aleyna Işıkdağlılar on 4.08.2024.
//

import Foundation

struct Service {
    
    static let shared = Service()
    private init() {}
    
    func fetchCategories(completion: @escaping(Result<[String], Error>) -> Void) {
        request(route: .getProductCategoryList, method: .get, completion: completion)
    }
    
    func fetchProducts(byCategory category: String, completion: @escaping(Result<GetAllProductsResponse, Error>) -> Void) {
            request(route: .getProductsByCategory(category), method: .get, completion: completion)
        }
    
    private func request<T: Decodable>(route: Route, method: Method, parameters: [String: Any]? = nil, completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(Error.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "No response data"
//                        print("Response String: \(responseString)")
                //                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
            } else if let error = error {
                result = .failure(error as! Error)
                print("The error is : \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
        
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let result = result else {
            completion(.failure(Error.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error)") 
                completion(.failure(Error.errorDecoding))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func createRequest(route: Route, method: Method, parameters: [String: Any]? = nil) -> URLRequest? {
        
        let urlString = Route.baseUrl + route.description
        
        guard let url = urlString.asURL else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
                //            case .post:
                //                let bodyData = try? JSONSerialization.data(withJSONObject: params)
                //                urlRequest.httpBody = bodyData
                
                
            case .add: break
                
            case .delete: break
                
            case .update: break
                
            }
        }
        return urlRequest
    }
}
