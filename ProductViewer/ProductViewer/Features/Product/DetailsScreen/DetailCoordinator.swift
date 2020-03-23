//
//  DetailCoordinator.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/23/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

class DetailCoordinator: TempoCoordinator {

    private weak var navigationPresenter: UINavigationController?
    
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
    
    lazy var viewController: DetailViewController = {
        return DetailViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        registerListeners()
    }
    
    // MARK: ListCoordinator
    
    func start(navigationPresenter: UINavigationController, state: DetailItemViewState) {
        self.navigationPresenter = navigationPresenter
        self.navigationPresenter?.pushViewController(self.viewController, animated: true)
        
        self.viewState.listItems = [state]
    }
    
    fileprivate func registerListeners() {

    }

}
