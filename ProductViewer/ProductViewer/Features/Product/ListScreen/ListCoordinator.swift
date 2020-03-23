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
    private weak var navigationPresenter: UINavigationController?
    private lazy var detailCoordinator = DetailCoordinator()
    
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
    
    func start(navigationPresenter: UINavigationController) {
        self.navigationPresenter = navigationPresenter
        self.navigationPresenter?.setViewControllers([self.viewController], animated: true)
    }
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] e in
            guard let nav = self?.navigationPresenter else { return }
            self?.detailCoordinator.start(navigationPresenter: nav, state: DetailItemViewState(productImage: e.image, price: e.listItem.price, description: e.listItem.description))
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
                        return ListItemViewState(title: index.title ?? "--",
                                                 price: index.price ?? "--",
                                                 imageUrl: nil,
                                                 key: index._id ?? "",
                                                 aisleCopy: index.aisle ?? "",
                                                 description: index.description ?? "--")
                    }

                    return ListItemViewState(title: index.title ?? "--",
                                             price: index.price ?? "--",
                                             imageUrl: URL(string: imageUrlString),
                                             key: index._id ?? "",
                                             aisleCopy: index.aisle ?? "",
                                             description: index.description ?? "--")
                }
            case .failure(let error):
                // TODO: Product List Error Handling
                print(error)
            }
        }
    }
}
