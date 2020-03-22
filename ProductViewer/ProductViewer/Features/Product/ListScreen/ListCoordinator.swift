//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    private let networkManager = NetworkManager()
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        updateState()
        registerListeners()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] e in
            let alert = UIAlertController(title: "Item selected!", message: "🐶", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
            self?.viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateState() {
        self.networkManager.request(ProductEndpoint.getProducts) {
            (result: ServiceResult<ResponseMeta<ProductDetail>>) in
            
            switch result {
            case .success(let productResponse):
                guard let products = productResponse?.data else {
                    // TODO: Product get no data
                    return
                }

                self.viewState.listItems = products.map { index in
                    guard let imageUrlString = index.image else {
                        return ListItemViewState(title: index.title ?? "--", price: index.price ?? "--", imageUrl: nil, key: index._id ?? "")
                    }

                    return ListItemViewState(title: index.title ?? "--", price: index.price ?? "--", imageUrl: URL(string: imageUrlString), key: index._id ?? "")
                }
            case .failure(let error):
                // TODO: Product List Error Handling
                print(error)
            }
        }
    }
}
