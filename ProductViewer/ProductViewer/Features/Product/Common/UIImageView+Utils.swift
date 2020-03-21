//
//  UIImageView+Utils.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/21/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else {
                    
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
}
