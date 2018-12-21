//
//  Router.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import UIKit

public protocol Routable: class {
    var parent: Routable? { get set }
    
    func didAttach()
    func didDetach()
    
    func attachChild(child: Routable)
    func detachChild(child: Routable)
    func detachFromParent()
}

fileprivate var fakeRoot = Router(viewModel: ViewModel(viewController: ViewController()))

open class Router<ViewModelType>: Routable {
    
    public weak var parent: Routable?
    public var children: [ObjectIdentifier: Routable] = [:]
    
    public let viewModel: ViewModelType
    private let viewModelable: ViewModelable
    
    public init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        guard let viewModelable = viewModel as? ViewModelable else {
            fatalError("ViewModelType must conform to ViewModelable")
        }
        
        self.viewModelable = viewModelable
        self.viewModelable.closeListener = self
    }
    
    //TODO: - Remove once the app have been fully migrated to MVVM
    public final func attachToRoot() {
        fakeRoot.attachChild(child: self)
    }
    
    public func didAttach() {
        viewModelable.activate()
    }
    
    public func didDetach() {
        viewModelable.deactivate()
    }
    
    public final func attachChild(child: Routable) {
        let key = ObjectIdentifier(child)
        
        synchronized(children) {
            children[key] = child
            child.parent = self
        }
        
        child.didAttach()
    }
    
    public final func detachChild(child: Routable) {
        let key = ObjectIdentifier(child)
        let child = children[key]
        
        synchronized(children) {
            children.removeValue(forKey: key)
            child?.parent = nil
        }
        
        child?.didDetach()
    }
    
    public func detachFromParent() {
        parent?.detachChild(child: self)
    }
    
    private func synchronized(_ lock: Any, closure:()->Void) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}

// MARK:- CloseListener
extension Router: CloseListener {
    
    public func wasClosed() {
        if parent != nil {
            detachFromParent()
        }
    }
}

open class ViewableRouter<ViewModelType, ViewControllerType>: Router<ViewModelType> {
    public let viewController: ViewControllerType
    
    public init(viewModel: ViewModelType,
                viewController: ViewControllerType) {
        self.viewController = viewController
        
        super.init(viewModel: viewModel)
    }
    
    /**
     Presents a navigation controller modally with the given view controller as a root.
     
     - Important: Router attachment needs to be addressed separately
     
     - Parameters:
     - on: ViewController from which to present the navigation view controller modally.
     - animated: Pass true to animate the presentation; otherwise, pass false.
     - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
     */
    public func presentAsModalNavigation(on presentingViewController: UIViewController,
                                         animated: Bool = true,
                                         completion: (() -> Void)? = nil) {
        
        guard let viewControllerToPresent = self.viewController as? ViewControllable else { return }
        
        let modalNavigationController = UINavigationController(rootViewController: viewControllerToPresent.uiViewController)
        presentingViewController.present(modalNavigationController, animated: animated, completion: completion)
    }
}
