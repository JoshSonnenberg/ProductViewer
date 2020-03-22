//
//  UIImageView+Utils.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/21/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

class NetworkedImageView: UIImageView {
    
    private static let cache = NSCache<NSString, UIImage>()
    private static let networkManager = NetworkManager()
    private var imageCacheKey: String?
    
    func load(url: URL, key: String) {
        self.image = nil
        self.imageCacheKey = key
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        if  self.imageCacheKey == key,
            let cachedImage = NetworkedImageView.cache.object(forKey: key as NSString) {
            DispatchQueue.main.async { [weak self] in
                self?.image = cachedImage
            }
        }
        
        NetworkedImageView.networkManager.request(ProductEndpoint.getProductImage(components: components)) { (result: ServiceResult<Data>) in

            DispatchQueue.main.async {
                let image: UIImage?
                
                switch result {
                case .success(let data?):
                    image = UIImage(data: data) ?? UIImage(named: "1")
                default:
                    image = UIImage(named: "1")
                }
                
                guard let imageValue = image else { return }
                
                if self.imageCacheKey == key {
                    self.image = imageValue
                }
                
                NetworkedImageView.cache.setObject(imageValue, forKey: key as NSString)
            }
        }
    }
    
}
