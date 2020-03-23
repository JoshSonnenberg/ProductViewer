//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

final class ProductListView: UIView, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: NetworkedImageView!
    @IBOutlet weak var aisleLabel: UILabel!
    @IBOutlet weak var aisleContainer: CircleContainer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorner(corners: .allCorners, radius: 15, borderWidth: 1.0, borderColor: UIColor(hex: 0xE0E0E0))
    }
}

extension ProductListView: ReusableNib {
    @nonobjc static let nibName = "ProductListView"
    @nonobjc static let reuseID = "ProductListViewIdentifier"

    @nonobjc func prepareForReuse() {
        productImage.image = nil
    }
}

class CircleContainer: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorner(corners: .allCorners, radius: self.bounds.size.width/2, borderWidth: 2, borderColor: UIColor(hex: 0xE0E0E0))
    }
    
}
