//
//  DetailViewState.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/23/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

/// Detail view state
struct DetailViewState: TempoViewState, TempoSectionedViewState {
    
    var detailItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return detailItems
    }
    
}

/// Detail view state
struct DetailItemViewState: TempoViewStateItem, Equatable {
    
    let productImage: UIImage?
    let price: String
    let description: String
    let addToCartCopy = "add to cart"
    let addToListCopy = "add to list"
    
}

func ==(lhs: DetailItemViewState, rhs: DetailItemViewState) -> Bool {
    return lhs.productImage == rhs.productImage
        && lhs.price == rhs.price
        && lhs.description == rhs.description
}
