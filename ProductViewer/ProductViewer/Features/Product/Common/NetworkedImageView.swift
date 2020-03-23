//
//  NetworkedImageView.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/21/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

class NetworkedImageView: UIImageView {
    
    private static let cache = NSCache<NSString, UIImage>()
    private static let networkManager = NetworkManager()
    
    func load(url: URL, key: String) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        if let cachedImage = NetworkedImageView.cache.object(forKey: key as NSString) {
            DispatchQueue.main.async { [weak self] in
                self?.image = cachedImage
            }
            
            return 
        }
        
        NetworkedImageView.networkManager.request(ProductEndpoint.getProductImage(components: components)) { (result: ServiceResult<Data>) in
            
            DispatchQueue.main.async {
                let image: UIImage?
                
                switch result {
                case .success(let data?):
                    image = UIImage(data: data) ?? UIImage(named: "3")
                default:
                    image = UIImage(named: "1")
                }
                
                guard let imageValue = image else { return }
                
                NetworkedImageView.cache.setObject(imageValue, forKey: key as NSString)
                self.image = imageValue
            }
        }
    }
    
}
