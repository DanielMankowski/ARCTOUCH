//
//  HomeBuilder.swift
//  TMDbTests
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol HomeDependency {
    
}

final class HomeComponent: HomeDependency {
    
}

final class HomeBuilder {
    func build() -> HomeRouter {
        let vc = HomeViewController()
        let viewModel = HomeViewModel(vc)
        let router = HomeRouter(viewModel: viewModel, viewController: vc)
        viewModel.listener = router
        vc.listener = viewModel
        
        return router
    }
}
