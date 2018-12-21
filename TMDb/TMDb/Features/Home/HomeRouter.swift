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

final class HomeRouter: ViewableRouter<HomeViewModelable, HomeViewController>,
HomeRoutable,
HomeViewModelListener {
    weak var listener: HomeRouterListener?
    
    func presentDetailScreen(movie: Movie) {
        let detailRouter = DetailBuilder(dependency: DetailComponent(dependency: ())).build()
        attachChild(child: detailRouter)
        detailRouter.viewModel.setMovie(movie: movie)
        viewController.navigationController?.pushViewController(detailRouter.viewController.uiViewController, animated: true)
    }
}
