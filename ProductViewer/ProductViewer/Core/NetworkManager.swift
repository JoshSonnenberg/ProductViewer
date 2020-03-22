//
//  NetworkManager.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/22/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Foundation

class NetworkManager {
    
    var task: URLSessionDataTask?
    let decoder = JSONDecoder()
    
    func request<SuccessType: Decodable>(_ endpoint: ServiceEndpoint, completion: @escaping (ServiceResult<SuccessType>) -> Void) {
        let session = URLSession.shared
        let req = prepareRequest(for: endpoint)

        guard let request = req else {
            // TODO error handling
            completion(.failure(NSError(domain: endpoint.url?.absoluteString ?? "", code: 0, userInfo: nil)))
            return
        }
        
        self.task = session.dataTask(with: request) {
            [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: endpoint.url?.absoluteString ?? "", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data,
                Set (200..<300).contains(response.statusCode) else {
                // TODO: no data error
                completion(.failure(NSError(domain: endpoint.url?.absoluteString ?? "", code: response.statusCode, userInfo: nil)))
                return
            }
            
            do {
                let responseData = try self?.decoder.decode(SuccessType.self, from: data)
                completion(.success(responseData))
                return
            } catch {
                if let typedData = data as? SuccessType {
                    completion(.success(typedData))
                    
                    return
                }
                
                completion(.failure(NSError(domain: endpoint.url?.absoluteString ?? "", code: 0, userInfo: nil)))
            }
        }
        
        self.task?.resume()
    }
    
    private func prepareRequest(for endpoint: ServiceEndpoint) -> URLRequest? {
        guard let url = endpoint.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(endpoint.serviceMethod)"
        
        return request
    }
    
}

enum ServiceResult<Value> {
    
    case success(Value?)
    case failure(Error)
    
}

enum ServiceMethod: String {
    
    case get = "GET"
    
}

protocol ServiceEndpoint {
    
    var url: URL? { get }
    var urlScheme: String { get }
    var baseUrlPath: String { get }
    var relativeUrlPath: String { get }
    var serviceMethod: ServiceMethod { get }
    
}

extension ServiceEndpoint {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = self.urlScheme
        components.host = self.baseUrlPath
        components.path = relativeUrlPath
        
        return components.url
    }
    
    var urlScheme: String {
        return "http"
    }
    
}
