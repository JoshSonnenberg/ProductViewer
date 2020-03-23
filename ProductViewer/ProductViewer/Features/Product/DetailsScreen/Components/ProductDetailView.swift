//
//  ProductDetailView.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/23/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit
import Tempo

final class ProductDetailView: UIView, NibLoadable {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.primaryButton.roundCorner(corners: .allCorners, radius: 5)
        self.secondaryButton.roundCorner(corners: .allCorners, radius: 5)
    }
    
}

extension ProductDetailView: ReusableNib {
    @nonobjc static let nibName = "ProductDetailView"
    @nonobjc static let reuseID = "DetailViewIdentifier"
    
    @nonobjc func prepareForReuse() {
        productImageView.image = nil
    }
}
