//
//  HomeViewModelListenerMock.swift
//  TMDbTests
//
//  Created by Daniel Mankowski on 20/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

@testable import TMDb
import Foundation

class HomeViewModelListenerMock: HomeViewModelListener {
    var presentDetailScreenCallCount: Int = 0
    var presentDetailScreenHandler: ((Movie)->())? = nil
    
    func presentDetailScreen(movie: Movie) {
        presentDetailScreenCallCount += 1
        if let returnValue = presentDetailScreenHandler?(movie) { return returnValue }
    }
}
