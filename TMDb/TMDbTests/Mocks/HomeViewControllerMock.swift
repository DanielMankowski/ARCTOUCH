//
//  HomeViewControllerMock.swift
//  TMDbTests
//
//  Created by Daniel Mankowski on 20/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation
@testable import TMDb

class HomeViewControllerMock: ViewControllableMock, HomeViewControllable {
    var updateCollectionCallCount: Int = 0
    var updateCollectionHandler: (([IndexPath]?)->())?
    
    func updateCollection(indexes: [IndexPath]?) {
        updateCollectionCallCount += 1
        if let returnValue = updateCollectionHandler?(indexes) { return returnValue }
    }
}
