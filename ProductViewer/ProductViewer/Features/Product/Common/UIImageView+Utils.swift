//
//  UIImageView+Utils.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/21/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

let cache = NSCache<NSString, UIImage>()
let networkManager = NetworkManager()

extension UIImageView {
    
    func load(url: URL, key: String) {
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let data = try? Data(contentsOf: url),
//                let image = UIImage(data: data) else {
//
//                return
//            }
//
//            DispatchQueue.main.async {
//                self?.image = image
//            }
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
            if let cachedImage = cache.object(forKey: key as NSString) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = cachedImage
                }
            }
            networkManager.request(ProductEndpoint.getProductImage(components: components)) { (result: ServiceResult<Data>) in

                
                
                DispatchQueue.main.async {
                                    let image: UIImage?
                    switch result {
                    case .success(let data?):
                        image = UIImage(data: data) ?? UIImage(named: "1")
                    default:
                        image = UIImage(named: "1")
                    }
                    
                    guard let imageValue = image else { return }
                    
                    cache.setObject(imageValue, forKey: key as NSString)
                    self.image = imageValue
                }
            }
//        }
    }
    
}
