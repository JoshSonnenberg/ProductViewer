//
//  ProductEndpoint.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/21/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Foundation

enum ProductEndpoint {
    
    case getProducts
    case getProductImage(components: URLComponents)
    
    // Potential future cases
    // case addToCart(product: Product)
    // case addToList(product: Product)
}

// MARK: Service Endpoint

extension ProductEndpoint: ServiceEndpoint {
    
    // switching over self gives us compiler checking of future case handling
    var serviceMethod: ServiceMethod {
        switch self {
        case .getProducts, .getProductImage:
            return .get
        }
    }
    
    var baseUrlPath: String {
        switch self {
        case .getProducts:
            return "target-deals.herokuapp.com"
        case .getProductImage(let components):
            return components.host ?? ""
        }
    }
    
    var relativeUrlPath: String {
        switch self {
        case .getProducts:
            return "/api/deals"
        case .getProductImage(let components):
            return components.path
        }
    }
    
}
