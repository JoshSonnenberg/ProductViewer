//
//  ResponseMeta.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/21/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Foundation

struct ResponseMeta<T: Decodable>: Decodable {
    
    let _id: String?
    let data: [T]?
    
}
