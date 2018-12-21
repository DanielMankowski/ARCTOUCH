//
//  DetailRouter.swift
//  TMDb
//
//  Created by Daniel Mankowski on 18/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

protocol DetailRoutable {
}

protocol DetailRouterListener: class {
    
}

class DetailRouter: ViewableRouter<DetailViewModelable, DetailViewController>,
DetailRoutable,
DetailViewModelListener {
    
    weak var listener: DetailRouterListener?
}

