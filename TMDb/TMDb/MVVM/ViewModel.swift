//
//  ViewModel.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

public protocol ViewModelable: class {
    func activate()
    func deactivate()
    var closeListener: CloseListener? { get set }
}

open class ViewModel<ViewControllableType>: ViewModelable, CloseListener {
    
    public weak var closeListener: CloseListener?
    
    public let viewController: ViewControllableType
    private var viewControllable: ViewControllable
    
    public init(viewController: ViewControllableType) {
        self.viewController = viewController
        
        guard let viewControllable = viewController as? ViewControllable else {
            fatalError("ViewControllerType must conform to view controllable")
        }
        
        self.viewControllable = viewControllable
        self.viewControllable.closeListener = self
    }
    
    open func activate() {
        let _ = viewControllable.uiViewController.view
    }
    
    open func deactivate() {}
    
    public func wasClosed() {
        closeListener?.wasClosed()
    }
}
