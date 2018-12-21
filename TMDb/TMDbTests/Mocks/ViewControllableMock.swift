//
//  ViewControllableMock.swift
//  TMDbTests
//
//  Created by Daniel Mankowski on 20/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

@testable import TMDb
import UIKit

class ViewControllableMock: ViewControllable {
    
    var viewController = UIViewController()
    var uiViewControllerCallCount : Int = 0
    var attachChildviewControllableCallCount: Int =
    0
    var attachChildviewControllableHandler: ((ViewControllable) -> ())? =
    nil
    var detachChildviewControllableCallCount: Int =
    0
    var detachChildviewControllableHandler: ((ViewControllable) -> ())? =
    nil
    var closeListener: CloseListener? =
    nil
    
    var uiViewController: UIViewController {
        uiViewControllerCallCount += 1
        return viewController
    }
    
    /**
     :param:    viewControllable
     */
    func attachChild(viewControllable: ViewControllable) {
        
        attachChildviewControllableCallCount += 1
        if let returnValue = attachChildviewControllableHandler?(viewControllable) { return returnValue }
    }
    
    /**
     :param:    viewControllable
     */
    func detachChild(viewControllable: ViewControllable) {
        
        detachChildviewControllableCallCount += 1
        if let returnValue = detachChildviewControllableHandler?(viewControllable) { return returnValue }
    }
    
}
