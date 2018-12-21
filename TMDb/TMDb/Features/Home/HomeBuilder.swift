//
//  HomeBuilder.swift
//  TMDbTests
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol HomeDependency: Dependency {
    var apiClient: APIClientable { get }
}

final class HomeComponent: Component<Void>, HomeDependency {
    var apiClient: APIClientable {
        return APIClient()
    }
}

final class HomeBuilder: Builder<HomeRouter, HomeDependency> {
    override func build() -> HomeRouter {
        let vc = HomeViewController()
        let viewModel = HomeViewModel(vc, apiClient: dependency.apiClient)
        let router = HomeRouter(viewModel: viewModel, viewController: vc)
        viewModel.listener = router
        vc.listener = viewModel
        
        return router
    }
}
