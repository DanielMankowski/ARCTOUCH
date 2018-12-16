//
//  HomeViewModel.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol HomeViewModelable {
    
}

protocol HomeViewModelListener: class {
}

final class HomeViewModel: HomeViewModelable, HomeViewControllerListener {
    weak var listener: HomeViewModelListener?
    
    private let viewController: HomeViewControllable
    
    init(_ viewController: HomeViewControllable) {
        self.viewController = viewController
    }
}
