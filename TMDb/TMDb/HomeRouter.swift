//
//  HomeRouter.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol HomeRoutable {
    
}

protocol HomeRouterListener: class {
    
}

final class HomeRouter: HomeRoutable, HomeViewModelListener {
    weak var listener: HomeRouterListener?
    
    private let viewModel: HomeViewModelable
    private let viewController: HomeViewControllable
    
    init(viewModel: HomeViewModelable,
         viewController: HomeViewControllable) {
        self.viewModel = viewModel
        self.viewController = viewController
    }
}
