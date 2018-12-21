//
//  DetailBuilder.swift
//  TMDb
//
//  Created by Daniel Mankowski on 18/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol DetailDependency: Dependency {
}

final class DetailComponent: Component<Void>, DetailDependency {
}

class DetailBuilder: Builder<DetailRouter, DetailDependency> {
    override func build() -> DetailRouter {
        let vc = DetailViewController()
        let viewModel = DetailViewModel(viewController: vc)
        let router = DetailRouter(viewModel: viewModel, viewController: vc)
        viewModel.listener = router
        vc.listener = viewModel
        
        return router
    }
}
