//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?
    
    private var sizingView = ProductListView.fromNib

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLabel.text = item.title
        view.priceLabel.text = item.price
        view.aisleLabel.text = item.aisleCopy
        guard let imageUrl = item.imageUrl else {
            view.productImage.image = UIImage(named: "1")
            return
        }
        
        view.productImage.load(url: imageUrl, key: item.key)
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed())
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        guard let state = item as? ListItemViewState else { return 100.0 }
        
        self.configureView(sizingView, item: state)
        
        return sizingView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
