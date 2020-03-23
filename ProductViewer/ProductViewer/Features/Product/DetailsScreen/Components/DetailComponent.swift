//
//  DetailComponent.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/23/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

struct DetailComponent: Component {

    var dispatcher: Dispatcher?
    
    private var sizingView = ProductDetailView.fromNib
    
    func prepareView(_ view: ProductDetailView, item: DetailItemViewState) { }
    
    func selectView(_ view: ProductDetailView, item: DetailItemViewState) { }
    
    func configureView(_ view: ProductDetailView, item: DetailItemViewState) {
        view.productImageView.image = item.productImage
        view.priceLabel.text = item.price
        view.detailLabel.text = item.description
        view.primaryButton.setTitle(item.addToCartCopy, for: .normal)
        view.secondaryButton.setTitle(item.addToListCopy, for: .normal)
    }
    
}

extension DetailComponent: HarmonyLayoutComponent {
    
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        guard let state = item as? DetailItemViewState else { return 100.0 }
        
        self.configureView(sizingView, item: state)
        
        self.sizingView.bounds = CGRect(x: 0.0, y: 0.0, width: width, height: sizingView.bounds.height)
        self.sizingView.layoutIfNeeded()
        
        return sizingView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    
}
